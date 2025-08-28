import re, sys, pathlib

BOOK = pathlib.Path("a0_0_treasury_of_fairytales/a0_0_the_loop_that_wanted_to_close")
# Accepts:
# - "->" or "→"
# - straight "..." or curly “...”
# - flexible whitespace
# - trailing spaces at EOL
RX_TASK = re.compile(
    r'^//\s*Code\s*Task:\s*'                  # // Code Task:
    r'(?P<name>[a-z0-9_]+)\s*'                # function name
    r'\(\s*(?P<args>.*?)\s*\)\s*'             # (args)
    r'(?:→|->)\s*'                            # arrow: → or ->
    r'(?:RESULT|ERROR)\s*:\s*'                # label
    r'(?P<quote>["“])'                        # opening quote: " or “
    r'(?P<result>.+?)'                        # result text (non-greedy)
    r'(?P=quote)\s*\.\s*$',                   # closing quote + period
    re.IGNORECASE
)

RX_FUNC = re.compile(r'^\s*def\s+(?P<name>[a-z0-9_]+)\s*\((?P<args>.*?)\)\s*:', re.IGNORECASE)

def extract_task_and_stub(text):
    lines = text.splitlines()
    for i, line in enumerate(lines):
        m = RX_TASK.match(line.strip())
        if not m:
            continue
        name = m.group("name")
        args = m.group("args")
        result = m.group("result")
        # normalize curly quotes in captured result if present (no visual diff)
        result = result.replace('”','"').replace('“','"') if ('“' in result or '”' in result) else result
        # find stub on next non-empty line
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        stub = lines[j] if j < len(lines) else ""
        fm = RX_FUNC.match(stub)
        return (name, args, result), stub
    return None, None

def arg_count(args_str):
    if not args_str or not args_str.strip():
        return 0
    parts = [a.strip() for a in args_str.split(",")]
    parts = [p for p in parts if p]  # drop empties
    return len(parts)

failures = []
for n in range(1, 33):
    p = BOOK / f"page{n:02}.md"
    try:
        t = p.read_text(encoding="utf-8")
    except FileNotFoundError:
        failures.append((p, "Missing file"))
        continue

    parsed, stub = extract_task_and_stub(t)
    if not parsed:
        failures.append((p, "Missing or malformed Code Task line"))
        continue

    (fname, fargs, expected), stub_line = parsed, stub
    if not stub_line or not stub_line.lstrip().startswith("def "):
        failures.append((p, "Missing Python stub beneath Code Task"))
        continue

    env = {}
    try:
        exec(stub_line, env, env)
        got = env[fname](*([None] * arg_count(fargs)))
    except Exception as e:
        failures.append((p, f"Execution error: {e!r}"))
        continue

    if got != expected:
        failures.append((p, f"Stub returned '{got}' != expected '{expected}'"))

if failures:
    for p, msg in failures:
        print(f"[FAIL] {p}: {msg}")
    sys.exit(1)
else:
    print("[OK] All stubs match their Code Tasks.")
