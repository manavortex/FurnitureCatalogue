Website: https://www.esoui.com/downloads/info1617-FurnitureCatalogue.html

# Furniture Crafter's best friend\*

<sup>\*Actually not. The AddOn is pretty indifferent towards humans. Don't take it personal.</sup>

### DependsOn

If you are here because ESO told you that the AddOn can't load due to missing dependencies, please check [here](https://www.esoui.com/portal.php?uid=10277).

### Missing/Incorrect entries

If you are here because you want to report an error in the data, please check [here](https://www.esoui.com/portal.php?&id=177&pageid=63).
Feel free to send me a message (here or in game) with the item info for timely updates!

## Features:

### Check the [screenshots](https://www.esoui.com/downloads/info1617-FurnitureCatalogue.html#info)!

- **User-Interface**: _toggleable either via **keybind** or via **slash command** /fur_
- [FurnitureShoppingList](https://www.esoui.com/downloads/info1865-FurnitureShoppingListFurC2.0patch.html): Fully integrated
- **Compact/Full view**: Check the +/- button
- **Item database**: Holds a list of all available furniture blueprints (source: I datamined them myself! `^_^`)
- **Filters**: All filters can be combined - check first screenshot
  - crafting station
  - crafting knowledge
  - item source
  - quality
  - game version
  - item name
- **Post to chat** Print the recipe (if known) or the material list to chat from an item link or the Interface - see second screenshot
- **Responsive developer** Found something that's not in the catalogue? Tell me where you got it, send me an item link, and in it goes!

## Not possible:

- Preview: can't let you preview things from Furniture Catalogue. Scroll down for the long explanation
- Crown Store: can't access Crown Store tooltips. If you have a crown store item, please send me the link and price!

## Why should I use this instead of CraftStore?

> **_manavortex:_**
> You probably shouldn't - this AddOn has a different purpose. I wrote FurnitureCatalogue to help me with furnishing my homes - I wanted to know **what's out there** and **how I can get it**.

## Donations welcome!

> **_manavortex:_**
> Writing this AddOn was **a lot** of work. Almost all the included data files are generated by hand. I have literally spent hours just standing in front of furniture merchants, checking item conditions and putting things into files. _(If you want a better impression, check data/Homestead/AchievementVendors.lua - I have visited every single one of those myself.)_
>
> By careful estimate I've spent 30+ hours on FurC since Morrowind hit PTS - the initial release ate a week of vacation turned to pretty much nonstop coding.

**I've taken over updating since manavortex no longer plays ESO, so if you want to give back, feel free to donate to @berylbones, both on NA and EU!**

## Possible issues

### My crafter's knowledge isn't correct!

Just click the refresh button. If you want the AddOn to scan on every load, there is a setting "enable initial scan" - check if it's deactivated.

### This only shows Pact PVP furniture, and I'm $other_faction!

This is a **feature**. Adding complexity adds bugs and loading times - and that's needlessly complex, since the prices and item sources are the same.

### Something else is broken!

1. Disable **Shissu's Guild Tools** - Shissu altered some ESO functions, it's nothing I can fix
2. Reset the furniture catalogue database by middle-clicking the refresh button or wiping it from the menu
3. Wipe the saved variables - you can do that from the AddOn menu via "Reset to default".
4. Do a clean install of the AddOn to make sure no outdated files are left
5. Get in touch with manavortex with a description of the bug:
   - Where exactly does it occur? (FurnitureCatalogue window, when right-clicking an item link...)
   - What is affected? (item links, posting to chat, exporting...)
   - What do I have to do when I want to reproduce this bug?

<sup>Big thanks to my fellow developers for being so awesome and helping me out so much!</sup>

## The long version about the preview

I have talked to Chip Hilseberg (may his code never bug) about this, and he was quite clear - ZOS doesn't want us to preview items from the item links because of datamining etc. A function to preview items that we can craft may come eventually, but that will only help you while logged in on your crafter.

Why can't you make it work like FurniturePreview?
There is an API function that lets you preview something that is in a bag (a vendor is a bag too) or a guild store. In theory I could add preview functions from Furniture Catalogue for items that are in your inventory, but that would require yet another loop and have a negative impact on performance. (Again.) Just use FurniturePreview for those, please.

## Wishlist/ToDo:

- please see [GitHub issues](https://github.com/manavortex/FurnitureCatalogue/issues) for features and todos
- you can use the issue search function and labels before suggesting new features
