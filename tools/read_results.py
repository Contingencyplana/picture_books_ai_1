from pathlib import Path
import re
import sys

BOOK = Path("a0_0_treasury_of_fairytales/a0_0_the_loop_that_wanted_to_close")
RX = re.compile(r'^//\s*Code Task:\s*([a-z0-9_]+)\((.*?)\)\s*→\s*RESULT:\s*"(.+?)"\.\s*$', re.I)

def main() -> int:
    failures = 0
    for n in range(1, 33):
        p = BOOK / f"page{n:02}.md"
        try:
            lines = p.read_text(encoding="utf-8").splitlines()
        except FileNotFoundError:
            print(f"Page {n:02}: MISSING file: {p}")
            failures += 1
            continue

        matched = False
        for i, raw in enumerate(lines):
            line = raw.strip()
            m = RX.match(line)
            if not m:
                continue
            matched = True
            name, args_str, expected = m.groups()
            # Next non-empty line should be the stub "def ..."
            j = i + 1
            while j < len(lines) and not lines[j].strip():
                j += 1
            if j >= len(lines) or not lines[j].lstrip().startswith("def "):
                print(f"Page {n:02}: MISSING stub under Code Task")
                failures += 1
                break

            stub = lines[j]
            env = {}
            try:
                exec(stub, env, env)
                arg_count = 0 if not args_str.strip() else len([a for a in args_str.split(",") if a.strip()])
                result = env[name](*([None] * arg_count))
            except Exception as e:
                print(f"Page {n:02}: EXEC ERROR: {e!r}")
                failures += 1
                break

            print(f"Page {n:02}: {result}")
            if result != expected:
                print(f"Page {n:02}: RESULT MISMATCH: got '{result}' != '{expected}'")
                failures += 1
            break

        if not matched:
            print(f"Page {n:02}: MISSING or malformed Code Task line")
            failures += 1

    return 1 if failures else 0

if __name__ == "__main__":
    sys.exit(main())
