"""Loopback-only administration client for this integration instance."""
import json, urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = 'http://127.0.0.1:18089'

class Client:
    def __init__(self):
        self.token = None
        self.opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
    def request(self, path, data=None, method=None, headers=None):
        raw = data if isinstance(data, bytes) else json.dumps(data).encode() if data is not None else None
        req = urllib.request.Request(BASE + path, data=raw, method=method,
            headers={'Content-Type':'application/json', **({'Authorization':'Bearer '+self.token} if self.token else {}), **(headers or {})})
        with self.opener.open(req, timeout=90) as response:
            value = json.load(response)
            return value.get('data', value)
    def login(self):
        env = dict(line.split('=',1) for line in (ROOT/'.env').read_text().splitlines() if '=' in line)
        session = self.request('/api/v1/auth/login', {'email':'admin@statekit.local','password':env['ADMIN_PASSWORD']})
        self.token = session['access_token']
        return session
