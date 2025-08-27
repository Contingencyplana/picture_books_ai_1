# How to Create a New Picture Book from this Template

## 1) Copy the template folder
Copy `_templates/picture_book_template` into your treasury folder and rename it to your new book ID.

Example (PowerShell):
Copy-Item -Recurse -Force `
  .\_templates\picture_book_template `
  .\a0_0_treasury_of_fairytales\a0_3_your_book_name

## 2) Update identifiers
Open these files and replace placeholders:
- `README.md`: set Title and synopsis
- `ai_player.json`: set `"id"`, `"title"`
- `taskmaps/milestones.md`: add quick beat labels
- All `pageNN.md`: keep the 3-part structure

Placeholders to replace:
- {{TREASURY_ID}}  e.g., tof1
- {{BOOK_ID}}      e.g., a0_03
- {{BOOK_TITLE}}   e.g., "Your Book Title"
- {{PAGE_NUMBER}}  e.g., 01 … 32 (used in pages)

## 3) Verify structure
Each book must contain:
- README.md, ai_player.json
- taskmaps/ (README.md, milestones.md, main_taskmap.md)
- assets/ (.gitkeep stays)
- page01.md … page32.md (two-digit numbering)

## 4) Commit your new book
git add -A
git commit -m "Add new book a0_03_your_book_name from template"
git push
