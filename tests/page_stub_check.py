import re, sys, pathlib

BOOK = pathlib.Path("a0_0_treasury_of_fairytales/a0_0_the_loop_that_wanted_to_close")
PAGES = [BOOK / f"page{n:02}.md" for n in range(1, 33)]

RX_TASK = re.compile(r'^//\s*Code Task:\s*(?P<sig>[a-z0-9_]+\s*\(.*?\))\s*→\s*(RESULT|ERROR):\s*"(?P<result>.+?)"\.\s*$', re.I)
RX_FUNC = re.compile(r'^\s*def\s+(?P<name>[a-z0-9_]+)\s*\((?P<args>.*?)\)\s*:', re.I)

def extract_task_and_stub(text):
    lines = text.splitlines()
    for i, line in enumerate(lines):
        m = RX_TASK.match(line.strip())
        if not m:
            continue
        sig = m.group("sig")
        exp = m.group("result")
        # Next non-empty, non-comment line should start a stub 'def ...'
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        stub = lines[j] if j < len(lines) else ""
        fm = RX_FUNC.match(stub)
        return sig, exp, stub, (i, j)
    return None, None, None, None

def sig_to_name_args(sig):
    name = sig.split("(", 1)[0].strip()
    args = sig.split("(", 1)[1].rsplit(")", 1)[0].strip()
    # Very light parse (keeps arg names only)
    args_list = [a.split("=")[0].strip() for a in args.split(",")] if args else []
    return name, args_list

def make_call(name, args_list):
    call = f"{name}(" + ", ".join(a or "" for a in args_list) + ")"
    # Create fake arg names to satisfy the signature in eval env
    env = {a or "": object() for a in args_list if a}
    return call, env

failures = []
for p in PAGES:
    t = p.read_text(encoding="utf-8")
    sig, expected, stub, idxs = extract_task_and_stub(t)
    if not sig:
        failures.append((p, "Missing or malformed Code Task line"))
        continue
    if '→ ERROR:' in t:
        failures.append((p, "Code Task uses ERROR instead of RESULT"))
        continue
    if not stub or not stub.strip().startswith("def "):
        failures.append((p, "Missing Python stub beneath Code Task"))
        continue
    name, args = sig_to_name_args(sig)
    # Build a tiny exec env and run the stub
    env = {}
    try:
        exec(stub, env, env)
        # Create placeholder args (positional) and call
        call_expr = f"{name}(" + ", ".join(["None"] * len(args)) + ")"
        got = eval(call_expr, env, env)
        if got != expected:
            failures.append((p, f"Stub returned '{got}' != expected '{expected}'"))
    except Exception as e:
        failures.append((p, f"Execution error: {e!r}"))

if failures:
    for p, msg in failures:
        print(f"[FAIL] {p}: {msg}")
    sys.exit(1)
else:
    print("[OK] All stubs match their Code Tasks.")
