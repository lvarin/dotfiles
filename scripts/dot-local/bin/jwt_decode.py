#!/usr/bin/env python3
import sys, json, base64

def b64url_decode(data: str) -> str:
    # add padding if needed
    data += "=" * ((4 - len(data) % 4) % 4)
    return base64.urlsafe_b64decode(data).decode()

def jwt_decode(token: str):
    parts = token.split(".")
    if len(parts) < 2:
        print("Invalid JWT format", file=sys.stderr)
        sys.exit(1)

    header, payload = parts[0], parts[1]

    try:
        header_decoded = json.loads(b64url_decode(header))
        payload_decoded = json.loads(b64url_decode(payload))
    except Exception as e:
        print(f"Error decoding token: {e}", file=sys.stderr)
        sys.exit(1)

    print("{\"HEADER\":")
    print(json.dumps(header_decoded, indent=2))
    print(",\"PAYLOAD\":")
    print(json.dumps(payload_decoded, indent=2))
    print("}")

# Read token from stdin (strip whitespace/newlines)
raw = sys.stdin.read().strip()
if not raw:
    print("No token provided on stdin", file=sys.stderr)
    sys.exit(1)

jwt_decode(raw)

