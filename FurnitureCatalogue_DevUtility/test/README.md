# FurnitureCatalogue test suites

[Taneth](https://www.esoui.com/downloads/info3584-Taneth-TestingFramwork.html)


Runs two ways:

- **In-game** - install Taneth AddIn, then `/taneth FurnitureCatalogue`
- **Headless** — `.scripts/run_tests.sh` uses [ESOLua](https://github.com/sirinsidiator/esolua), no game client

Just optional dependency, so nothing happens if not available. Not part of main AddOn, so it does not load unnecessary stuff.

Test suite ids:

- `FurC:Regression`
- `FurC:Unit`


## Running headless

```sh
.scripts/run_tests.sh # runs every registered suite
.scripts/run_tests.sh FurC:Unit # just UnitTests
```

Script offers to download anything missing for tests.
Override with `ESOLUA`, `ESOUI_SRC`, `TANETH_DIR` env vars or in `.scripts/.env` (see `.scripts/env.example`)

Headless path needs `.scripts/test_stubs.lua`, because
of some missing library dependencies (LibAddonMenu, LibAsync, etc). It's not loaded when run in-game.

Some headless tests fail if they need GUI and other stuff. It's OK, not an error.
