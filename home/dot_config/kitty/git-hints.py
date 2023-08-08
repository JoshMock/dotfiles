import re
import subprocess


def mark(text, args, Mark, extra_cli_args, *a):
    # match a git commit hash
    for idx, m in enumerate(re.finditer(r"[a-f0-9]{8,40}", text)):
        start, end = m.span()
        mark_text = text[start:end]
        yield Mark(idx, start, end, mark_text, {})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    matches = []
    groupdicts = []
    for m, g in zip(data["match"], data["groupdicts"]):
        if m:
            matches.append(m)
            groupdicts.append(g)
    for hash, match_data in zip(matches, groupdicts):
        # open the commit in browser
        output = subprocess.run(
            [
                "gh",
                "repo",
                "view",
                "--json",
                "url",
                "-q",
                ".url",
            ],
            cwd=data["cwd"],
            capture_output=True,
        )
        url_prefix = output.stdout.decode('utf-8').strip()
        boss.open_url(f"{url_prefix}/commit/{hash}")
