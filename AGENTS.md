# AGENTS.md

Maintenance notes for this Homebrew tap. End-user usage lives in `README.md`;
keep that file user-facing and free of project lists and maintenance details.

## Layout

- `Formula/*.rb` — formulae (CLI tools)
- `Casks/*.rb` — casks (GUI apps)
- `projects.yaml` — single source of truth for the auto-bump
- `scripts/bump.rb` — the bump engine
- `.github/workflows/bump.yml` — runs the engine

Tap name is `xingrz/tap` (the `homebrew-` prefix is implicit). Users install with
`brew install xingrz/tap/<name>` or `brew install --cask xingrz/tap/<name>`.

## Auto-bump

The `.rb` files are never hand-edited for releases. `projects.yaml` lists each
managed project; `scripts/bump.rb` reads it, fetches each upstream's latest
GitHub release, takes the sha256 straight from the release asset digests (no
download), rewrites `version` + `sha256` in the matching `.rb`, and commits per
project when something changed.

Dependencies: `ruby`, `gh` (authenticated via `GH_TOKEN`), `git` — all
preinstalled on macOS, Homebrew environments, and GitHub runners. No jq/perl/yq.

Run locally:

```sh
scripts/bump.rb            # all projects
scripts/bump.rb tapeflow   # just one
```

### Triggers

Same engine, three entry points in `bump.yml`:

- `schedule` — daily safety net; needs no secrets anywhere.
- `workflow_dispatch` — run by hand from the Actions tab.
- `repository_dispatch` (`event_type: bump`) — fired by an upstream repo right
  after it releases, e.g.:

  ```sh
  gh api repos/xingrz/homebrew-tap/dispatches \
    -f event_type=bump -f 'client_payload[project]=tapeflow'
  ```

Auth model: the **commit** is always made by this repo's own `GITHUB_TOKEN` — no
personal access token is stored here. Only the optional `repository_dispatch`
trigger needs a token with `actions:write` on this repo, and it lives in the
upstream that fires it. The `schedule` path needs nothing, so relying on cron
alone is fully secret-free.

## Adding a project

1. Write its `Formula/<name>.rb` (CLI) or `Casks/<name>.rb` (GUI app) once.
2. Add one entry to `projects.yaml`:
   - `type: formula` — one release asset, hashed into the `sha256 "…"` line. If
     the `url` carries a literal version (`…/download/vX/…`), it is rewritten too.
   - `type: cask` — per-arch assets (`arm`/`intel`), hashed into the matching
     `sha256 arm:/intel:` lines; the `url` should use `#{version}`/`#{arch}`.
   - `assets` values match release asset names by suffix.

`bump.rb` and the workflow need no changes for a new project of an existing type.
A new asset **shape** (e.g. a cask with a single universal dmg, or a per-arch
formula) needs a new `type` handler in `bump.rb`.

## Validate

```sh
brew style Formula/*.rb Casks/*.rb
ruby -c scripts/bump.rb
```

To dry-run the bump without touching this repo, copy it to a scratch dir, run
`git init`, then run `scripts/bump.rb` there.
