"""Create credentials for this isolated local instance, preserving existing ones."""
from pathlib import Path
import secrets

root = Path(__file__).resolve().parent
target = root / '.env'
if not target.exists():
    with target.open('x', encoding='utf-8') as out:
        for name in ['DATABASE_PASSWORD', 'ADMIN_PASSWORD', 'JWT_SECRET', 'TOTP_ENCRYPTION_KEY']:
            out.write(name + '=' + secrets.token_hex(32) + '\n')
    target.chmod(0o600)
print('Local credentials ready: .env; administrator: admin@statekit.local')
