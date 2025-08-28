import json, pathlib, textwrap

ROOT = pathlib.Path(__file__).resolve().parents[1]
MINIGAMES = ROOT / "minigames"

def load_spec(name: str):
    with open(MINIGAMES / f"{name}.json", "r", encoding="utf-8") as f:
        return json.load(f)

def ask(prompt: str, choices):
    print("\n" + textwrap.fill(prompt, width=80))
    for i, c in enumerate(choices, 1):
        print(f"  {i}. {c['label']}")
    while True:
        sel = input("Choose 1-" + str(len(choices)) + ": ").strip()
        if sel.isdigit() and 1 <= int(sel) <= len(choices):
            return choices[int(sel)-1]
        print("Invalid choice.")

def play(spec):
    print("\n=== " + spec["title"] + " ===")
    print(textwrap.fill(spec["intro"], width=80))
    benefit_scores = []
    for step in spec["steps"]:
        choice = ask(step["prompt"], step["choices"])
        print("→ " + choice.get("feedback",""))
        benefit_scores.append(choice["benefit"])
    # harmonic mean of three components per step (Impact, Inclusion, Integrity)
    # benefit is a dict with keys i, n, g in [0,1]
    import math
    def hmean(triples):
        # average the harmonic means of each step to keep it simple
        parts = []
        for b in triples:
            nums = [max(1e-6, b[k]) for k in ["i","n","g"]]
            parts.append(3.0 / sum(1.0/x for x in nums))
        return sum(parts)/len(parts)
    score = hmean(benefit_scores)
    print(f"\nBenefit Index: {score:.2f}")
    if score >= spec.get("unlock_threshold", 0.66):
        print("Unlocked: Next mode available (fictional).")
    else:
        print("Tip: Balance Impact, Inclusion, and Integrity to unlock.")

if __name__ == "__main__":
    print("Research Arcade — choose a minigame:")
    names = ["lab_research", "kickstarter", "monetary_sandbox", "sanctuary", "game_studio"]
    for i, n in enumerate(names, 1):
        print(f"  {i}. {n}")
    sel = input("Select 1-5: ").strip()
    if sel.isdigit() and 1 <= int(sel) <= 5:
        spec = load_spec(names[int(sel)-1])
        play(spec)
    else:
        print("Goodbye.")
