# DevUtility testing

For data contributions, see the [LFC contribution guide](https://github.com/wookiefriseur/LFC/blob/main/CONTRIBUTING.md).

## Headless check

From the addon root, using the existing ESOLua checkout:

```sh
../esolua/src/lua -s ../esoui/esoui FurnitureCatalogue_DevUtility/test/headless_discovery.lua /tmp/lfc-discovery.jsonl
../esolua/src/lua -s ../esoui/esoui FurnitureCatalogue_DevUtility/test/headless_dev_dashboard.lua
```

To validate those exact Lua-generated lines against the website import and
submission contracts, run from `LFC/tests/web`:

```sh
DISCOVERY_JSONL=/tmp/lfc-discovery.jsonl node --test discovery.test.mjs
```

Profiling helpers such as `test/RowShape.lua` are loaded in a development checkout but excluded from release packages to keep those lean.
