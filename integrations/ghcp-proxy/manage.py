"""Prepare/start/stop this local integration without changing other services."""
import argparse
import json
import os
from pathlib import Path
import secrets
import subprocess
import sys
import time
import urllib.request

ROOT = Path(__file__).resolve().parent
CONFIG = json.loads((ROOT / "integration.json").read_text(encoding="utf-8"))
RUNTIME = ROOT / ".runtime"
SOURCE = (ROOT / CONFIG["upstream_dir"]).resolve()
PYTHON = SOURCE / (".venv/Scripts/python.exe" if os.name == "nt" else ".venv/bin/python")


def health():
    request = urllib.request.Request(f'http://127.0.0.1:{CONFIG["listen_port"]}/health')
    with urllib.request.build_opener(urllib.request.ProxyHandler({})).open(request, timeout=3) as r:
        result = json.load(r)
    if result.get("service") != "sub2api-ghcp":
        raise RuntimeError("Configured port belongs to another service")
    return result


def prepare():
    RUNTIME.mkdir(exist_ok=True)
    if not SOURCE.exists():
        SOURCE.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(["git", "clone", "https://github.com/Nonary/ghcp_proxy.git", str(SOURCE)], check=True)
        subprocess.run(["git", "-C", str(SOURCE), "checkout", "--detach", CONFIG["upstream_revision"]], check=True)
    revision = subprocess.check_output(["git", "-C", str(SOURCE), "rev-parse", "HEAD"], text=True).strip()
    if revision != CONFIG["upstream_revision"]:
        raise RuntimeError("Upstream revision differs from pinned integration revision")
    if not PYTHON.exists():
        subprocess.run([sys.executable, "-m", "venv", str(SOURCE / ".venv")], check=True)
    subprocess.run([str(PYTHON), "-m", "pip", "install", "-r", str(SOURCE / "requirements.txt")], check=True)
    key = RUNTIME / "bridge-key"
    if not key.exists():
        key.write_text(secrets.token_urlsafe(48) + "\n")
        key.chmod(0o600)
    print("PREPARED revision=" + revision)


def start():
    try:
        print(json.dumps(health()))
        return
    except (OSError, ValueError):
        pass
    # Bind check before spawning; never replace another listener.
    import socket
    with socket.socket() as sock:
        sock.bind(("127.0.0.1", CONFIG["listen_port"]))
    if not (RUNTIME / "bridge-key").exists() or not PYTHON.exists():
        raise RuntimeError("Run prepare first")
    flags = subprocess.CREATE_NO_WINDOW | subprocess.CREATE_NEW_PROCESS_GROUP if os.name == "nt" else 0
    with (RUNTIME / "service.log").open("ab") as log:
        process = subprocess.Popen([str(PYTHON), "-u", str(ROOT / "run.py")], cwd=ROOT,
                                   stdin=subprocess.DEVNULL, stdout=log, stderr=log,
                                   creationflags=flags, start_new_session=os.name != "nt")
    (RUNTIME / "process.json").write_text(json.dumps({"pid": process.pid, "run": str(ROOT / "run.py")}))
    for _ in range(40):
        if process.poll() is not None:
            raise RuntimeError("GHCP exited; see .runtime/service.log")
        try:
            print(json.dumps(health()))
            return
        except (OSError, ValueError):
            time.sleep(.5)
    raise RuntimeError("GHCP startup timed out; see .runtime/service.log")


def stop():
    record = RUNTIME / "process.json"
    if not record.exists():
        print("ALREADY_STOPPED")
        return
    state = json.loads(record.read_text())
    # Verify process ownership before terminating; stale PID files are harmless.
    if os.name == "nt":
        command = f"Get-CimInstance Win32_Process -Filter 'ProcessId={int(state['pid'])}' | Select-Object ProcessId,CommandLine | ConvertTo-Json -Compress"
        raw = subprocess.check_output(["powershell", "-NoProfile", "-Command", command], text=True).strip()
        current = json.loads(raw) if raw else None
        if current:
            if str(ROOT / "run.py").lower() not in current.get("CommandLine", "").lower():
                raise RuntimeError("PID now belongs to another process")
            subprocess.run(["taskkill", "/PID", str(state["pid"]), "/T", "/F"], check=True)
    else:
        import signal
        command = subprocess.check_output(["ps", "-p", str(state["pid"]), "-o", "args="], text=True).strip()
        if str(ROOT / "run.py") not in command:
            raise RuntimeError("PID ownership differs")
        os.kill(state["pid"], signal.SIGTERM)
    record.unlink()
    print("STOPPED")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["prepare", "start", "stop", "status"])
    action = parser.parse_args().action
    if action == "status":
        print(json.dumps(health()))
    else:
        globals()[action]()
