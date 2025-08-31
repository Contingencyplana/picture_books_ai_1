from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
ALLOWED_ROOT_BOOKS = {"a0_0_treasury_of_fairytales"}  # adjust if needed

def test_no_root_level_books_except_allowed():
    offenders = []
    for p in ROOT.iterdir():
        if p.is_dir() and p.name.startswith("a0_") and p.name not in ALLOWED_ROOT_BOOKS:
            offenders.append(p.name)
    assert offenders == [], f"Ghost book dirs at root: {offenders}"
