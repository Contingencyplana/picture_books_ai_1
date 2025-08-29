import re
import sys
import keyword
import pathlib

BOOK = pathlib.Path("a0_0_treasury_of_fairytales/a0_0_the_loop_that_wanted_to_close")

# // Code Task: func(args) → RESULT: "..."
# - accepts "->" or "→"
# - accepts straight "..." or curly “...”
# - flexible whitespace
# - MULTILINE so $ anchors to end-of-line (not EOF)
RX_TASK = re.compile(
    r'//\s*Code\s*Task:\s*'
    r'(?P<name>[a-z0-9_]+)\s*'
    r'\(\s*(?P<args>.*?)\s*\)\s*'
    r'(?:→|->)\s*'
    r'(?:RESULT|ERROR)\s*:\s*'
    r'(?P<quote>["“])'
    r'(?P<result>.+?)'
    r'(?P=quote)\s*$',
    re.IGNORECASE | re.MULTILINE,
)

# Optional markers that may sit between the Code Task and stub
RX_FENCE = re.compile(r'^\s*```(?:python)?\s*$', re.IGNORECASE)   # ``` or ```python
RX_PYTAG = re.compile(r'^\s*\[python\]\s*$', re.IGNORECASE)       # [python]

def find_task_match(text: str):
    """Return the regex match object for the first Code Task line, or None."""
    return RX_TASK.search(text)

def safe_collect_indented(tail, start_index):
    """Collect def line + indented body; stop at blank or non-indented line."""
    block = [tail[start_index]]
    k = start_index + 1
    while k < len(tail):
        line = tail[k]
        if not line.strip():
            break
        # If line is not indented (likely a new section like [Illustration: …])
        if line.lstrip() == line and not line.startswith(" "):
            break
        block.append(line)
        k += 1
    return "\n".join(block).replace("\t", "    ")

def find_stub_block_after(text: str, start_index: int):
    """
    From start_index (end of Code Task match), return the full stub code block:
    - Skip blank lines
    - Skip optional [python] (single-line tag) or ```/```python fences
    - Require a 'def ' header line
    - If fenced, collect until closing fence; if fence is missing, fall back to indented collection
    Returns the stub_code string, or None if not found.
    """
    tail = text[start_index:].splitlines()
    j = 0

    # skip blank lines
    while j < len(tail) and not tail[j].strip():
        j += 1

    # Detect markers
    saw_fence = False
    if j < len(tail) and RX_FENCE.match(tail[j]):  # real fence
        saw_fence = True
        j += 1
        while j < len(tail) and not tail[j].strip():
            j += 1
    elif j < len(tail) and RX_PYTAG.match(tail[j]):  # [python] tag only
        j += 1
        while j < len(tail) and not tail[j].strip():
            j += 1

    if j >= len(tail) or not tail[j].lstrip().startswith("def "):
        return None

    if saw_fence:
        # Try to collect until closing fence
        block = [tail[j]]
        k = j + 1
        closed = False
        while k < len(tail):
            if RX_FENCE.match(tail[k]):
                closed = True
                break
            block.append(tail[k])
            k += 1
        if closed:
            return "\n".join(block).replace("\t", "    ")
        # If no closing fence found, fall back to indented collection
        return safe_collect_indented(tail, j)

    # No fence: collect based on indentation
    return safe_collect_indented(tail, j)

def arg_count(args_str: str) -> int:
    if not args_str or not args_str.strip():
        return 0
    parts = [a.strip() for a in args_str.split(",")]
    return len([p for p in parts if p])

def main() -> int:
    failures = []
    for n in range(1, 33):
        p = BOOK / f"page{n:02}.md"
        try:
            text = p.read_text(encoding="utf-8", errors="replace")
        except FileNotFoundError:
            failures.append((p, "Missing file"))
            continue

        m = find_task_match(text)
        if not m:
            # debug hint: show first line containing "Code Task"
            hint = ""
            for line in text.splitlines():
                if "Code Task" in line:
                    hint = f" (saw: {line.strip()!r})"
                    break
            failures.append((p, "Missing or malformed Code Task line" + hint))
            continue

        fname = m.group("name")
        fargs = m.group("args")
        expected = m.group("result").replace("“", '"').replace("”", '"')

        stub_code = find_stub_block_after(text, m.end())
        if not stub_code:
            failures.append((p, "Missing Python stub beneath Code Task"))
            continue

        env = {}
        try:
            exec(stub_code, env, env)

            # Look up function by Code Task name; if it's a Python keyword,
            # also try '<name>_' as a conventional alias used in stubs.
            func = env.get(fname)
            if func is None and keyword.iskeyword(fname):
                func = env.get(f"{fname}_")

            if func is None:
                failures.append((p, f"Execution error: function '{fname}' not found (keyword alias unsupported?)"))
                continue

            got = func(*([None] * arg_count(fargs)))
        except Exception as e:
            failures.append((p, f"Execution error: {e!r}"))
            continue

        if got != expected:
            failures.append((p, f"Stub returned '{got}' != expected '{expected}'"))

    if failures:
        for path, msg in failures:
            print(f"[FAIL] {path}: {msg}")
        return 1

    print("[OK] All stubs match their Code Tasks.")
    return 0

if __name__ == "__main__":
    sys.exit(main())
