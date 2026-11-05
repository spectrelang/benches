#!/usr/bin/env python3
"""Rewrite benchmark tables in README.md from Hyperfine's exported Markdown."""

from __future__ import annotations

import argparse
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Display order in the README. Each entry is (benchmark directory, section title).
BENCHMARKS = [
    ("json", "JSON"),
    ("json-parse", "JSON (large parse)"),
    ("json-write", "JSON (large write)"),
    ("json-roundtrip", "JSON (roundtrip)"),
    ("checksum", "Checksum"),
    ("calls", "Calls"),
    ("sort", "Sort (5M u64 values)"),
    ("hashmap", "Hashmap (i64 keys)"),
    ("core", "Core language (arithmetic, branches, recursion)"),
    ("core-vector", "Core language (SIMD vector math)"),
]


def format_table(path: Path) -> list[str]:
    """Read a Hyperfine markdown export and return a padded GFM table."""
    rows: list[list[str]] = []
    for line in path.read_text().splitlines():
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if all(set(cell) <= set("-: ") for cell in cells):
            continue
        rows.append(cells)

    if not rows:
        raise SystemExit(f"error: no table rows found in {path}")

    header, body = rows[0], rows[1:]
    widths = [
        max(len(row[column]) for row in [header, *body])
        for column in range(len(header))
    ]
    aligns = ["left", *(["right"] * (len(header) - 1))]

    def fmt_row(cells: list[str]) -> str:
        parts = []
        for cell, width, align in zip(cells, widths, aligns):
            value = cell.ljust(width) if align == "left" else cell.rjust(width)
            parts.append(f" {value} ")
        return "|" + "|".join(parts) + "|"

    def fmt_separator() -> str:
        parts = []
        for width, align in zip(widths, aligns):
            if align == "left":
                parts.append(" :" + "-" * max(width - 1, 3) + " ")
            else:
                parts.append(" " + "-" * max(width - 1, 3) + ": ")
        return "|" + "|".join(parts) + "|"

    return [fmt_row(header), fmt_separator(), *(fmt_row(row) for row in body)]


def replace_heading_table(
    section: list[str], heading: str, table: list[str]
) -> bool:
    """Replace the first table following a heading, or append a new section."""
    marker = f"#### {heading}"
    for index, line in enumerate(section):
        if line.strip() != marker:
            continue

        cursor = index + 1
        while cursor < len(section):
            if section[cursor].startswith("|"):
                break
            if section[cursor].startswith("#### ") or section[cursor].startswith("### "):
                break
            cursor += 1

        if cursor < len(section) and section[cursor].startswith("|"):
            end = cursor
            while end < len(section) and section[end].startswith("|"):
                end += 1
            section[cursor:end] = table
        else:
            insert_at = index + 1
            if insert_at < len(section) and section[insert_at].strip() == "":
                insert_at += 1
            else:
                section.insert(insert_at, "")
                insert_at += 1
            section[insert_at:insert_at] = [*table, ""]
        return True

    if section and section[-1].strip() != "":
        section.append("")
    section.extend([marker, "", *table, ""])
    return False


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--section", required=True, help="README section heading to update")
    parser.add_argument("--toolchains", help="replacement Toolchains: line content")
    parser.add_argument("--readme", default=str(ROOT / "README.md"))
    args = parser.parse_args()

    readme_path = Path(args.readme)
    lines = readme_path.read_text().splitlines()

    section_start = None
    section_end = len(lines)
    wanted = f"### {args.section}"
    for index, line in enumerate(lines):
        if line.strip() == wanted:
            section_start = index
            break
    if section_start is None:
        raise SystemExit(f"error: README section not found: {wanted}")

    for index in range(section_start + 1, len(lines)):
        if lines[index].startswith("### "):
            section_end = index
            break

    section = lines[section_start:section_end]

    if args.toolchains:
        for index, line in enumerate(section):
            if line.startswith("Toolchains:"):
                section[index] = f"Toolchains: {args.toolchains}"
                break

    for directory, heading in BENCHMARKS:
        results = ROOT / directory / "benchmark-results.md"
        if not results.exists():
            raise SystemExit(f"error: missing results file: {results}")
        replace_heading_table(section, heading, format_table(results))

    lines[section_start:section_end] = section
    readme_path.write_text("\n".join(lines) + "\n")
    print(f"updated {readme_path} [{args.section}]")


if __name__ == "__main__":
    main()
