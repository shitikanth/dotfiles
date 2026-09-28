# CLAUDE.md

Personal dotfiles for macOS and Linux. No build or test step — deployment is symlinking into `$HOME`. The one check is the Elisp lint (see Emacs). Files in `$HOME` are symlinks into this repo, so an edit here changes the running config immediately; only a reload of the affected program is needed.

## Symlink convention

`bootstrap.sh` symlinks every **top-level** entry matching `_*` into `$HOME`, replacing only the *first* underscore with a dot:

- `_zshrc` → `~/.zshrc`
- `_aliases.darwin` → `~/.aliases.darwin`
- `_vim` → `~/.vim` (`_vim` is itself an in-repo symlink to `vimfiles/`)

- A new dotfile is deployed only if it sits at the repo root and is named `_name`. Nested files are never linked.
- Top-level dirs without the underscore (`ci/`, `config/`, `local/`, `scripts/`, `zsh/`, `gdb_printers/`, `vimfiles/`) are not symlinked. They are referenced by absolute path (see `ZSH_CUSTOM`), reached through another symlink (`_vim`), or copied into place by hand (`config/` and `local/` mirror `~/.config` and `~/.local` on Linux).
- `bootstrap.sh` requires GNU find; on macOS it uses `gfind` (`brew install findutils`).

## Commands

```sh
./bootstrap.sh                      # git pull + submodule update + symlink + install vim/emacs plugins
git submodule update --init --recursive
source ~/.zshrc                     # or the `reload` alias
vim +PluginInstall +qall            # Vundle plugin install
ZSH_DEBUGRC=1 zsh                   # profile zsh startup (zprof)
emacs -q -l ~/.emacs.d.old/init.el  # the `emacs_old` alias; init.el prints per-package load times
ci/byte-compile [FILE...]           # byte-compile _emacs.d.old/**/*.el, warnings are errors
```

`bootstrap.sh` begins with `git pull`.

## Shell architecture

Layered so non-zsh shells still work:

1. `_zshenv` → sources `~/.profile`.
2. `_profile` — POSIX sh. Owns `PATH` (via the idempotent `pathmunge` helper), `GOPATH`, `MANPATH`. Shell-agnostic settings go here.
3. `_zshrc` — oh-my-zsh setup, then sources `~/.bashrc.functions` and `~/.aliases`. Tool blocks (bun, sdkman, dbt) accumulate at the bottom; **the sdkman block must stay last in the file**.
4. `_aliases` — POSIX aliases, then conditionally sources `~/.aliases.darwin` (macOS), `~/.aliases.zsh` (zsh global aliases like `L='| less'`), and `~/.aliases.local` (untracked, per-machine).

`ZSH_CUSTOM` is `$HOME/dotfiles/zsh/custom` — a hardcoded absolute path into the repo, not a symlink. oh-my-zsh auto-sources every `*.zsh` there, so `zsh/custom/worktree.zsh` and `custom.zsh` need no `source` line.

`zsh/custom/worktree.zsh` holds the `worktree` command and its zsh completion. It assumes `$BEEWORKS/bee_recon` with a `recon-platform` subdir and a `develop` base branch. Keep the completion's flag list in sync when changing subcommand flags.

`zsh/custom/dotenv.zsh` holds `dotenv` — parses `.env` files and runs a command under them via `env`, never touching the calling shell. Same convention: keep its `_dotenv_complete` flag list in sync with the option parser.

## Emacs

**`_emacs.d.old/init.el`** is the config. Hand-rolled, `use-package`-based, one `(use-package ...)` block per package. Load order: `site-lisp/` onto `load-path` → `custom.el` → package blocks → `local.el` last. Language servers via `eglot`; the old `lsp-mode`/`cquery` blocks are commented out, not deleted. Tree-sitter modes are guarded by `treesit-language-available-p` before `major-mode-remap-alist`.

Despite the `.old` name there is no newer config — a spacemacs setup (`_emacs.d` submodule + `_spacemacs.d/layers/sk-*`) was removed in 2026-09. `~/.emacs.d` is a hand-made symlink to `_emacs.d.old`, not one `bootstrap.sh` creates.

Every elisp file needs a `-*- lexical-binding: t; -*-` cookie on line 1; Emacs 31 warns at load without it.

`init.el` needs Emacs 29+: it relies on the built-in `use-package` (the `lib/use-package` submodule was removed).

`ci/byte-compile` runs `batch-byte-compile` with `byte-compile-error-on-warn`, packages from `~/.emacs.d/elpa`, and deletes the `.elc` files afterwards. The pre-commit hook `ci/pre-commit` (enabled by `bootstrap.sh` via `core.hooksPath`) runs it on staged `.el` files. `.github/workflows/emacs.yml` symlinks the checkout to `~/.emacs.d` like bbatsov/prelude, runs `ci/test-startup` (purcell/emacs.d's batch load of `init.el`, which installs the `:ensure t` packages into the cached `~/.emacs.d/elpa`), then `ci/byte-compile` on every file. `ci/test-startup` is CI-only: Emacs saves recentf, bookmarks and similar state into `~/.emacs.d` on exit.

The `ec` / `e` aliases talk to a daemon named `emacs-old` (`emacsclient -s emacs-old`).

`local.el` and `custom.el` are untracked — the per-machine escape hatch (host paths, org agenda files, API-backed packages). OS-specific settings like `mac-command-modifier` go in `init.el` behind a `system-type` check. Machine-specific state goes in `local.el`, not `init.el`.

Ignore rules for emacs runtime state live in `_emacs.d.old/.gitignore` as root-anchored patterns (`/recentf`); add new state files there. Nothing under `_emacs.d.old/` is tracked except the elisp itself — no history, project lists, caches, or compiled grammars.

## Vim

`vimfiles/vimrc` sources `rcfiles/tiny.vim` first — the minimal, plugin-free subset usable standalone on remote machines. Basic settings go there, plugin-dependent settings in `vimrc`. `vimrc` detects restricted mode (`E145`) and `finish`es before Vundle, so it stays usable as `vim -Z`.

## Repo conventions

- Working branch is `develop`; `master` is the main branch.
- Commit subjects use an area prefix: `[emacs]`, `[zsh]`, `[git]`, `[vim]`, `[shell]`.
- `_gitconfig` is the deployed global git config; `_gitignore` is the global ignore file (`core.excludesfile`), distinct from this repo's own `.gitignore`.
