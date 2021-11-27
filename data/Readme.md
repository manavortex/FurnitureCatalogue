# Introduction  
This is a guide that assumes you have little to no idea about coding, but want to help. If you know how to achieve the end results, feel free to skip any intermediary steps.    
# Prequisites    
- an account at github.com (so if you burn out or go MIA, the next volunteer can take over from you)  
- Notepad++ for file editing (trust me, it's so much better than regular notepad)  
- git: https://git-scm.com/download/win.  
	- Install with default options, except for "chosing the default editor used by git" - you'll want to select notepad or notepad++  
- a client. I'll walk you through how to use https://www.syntevo.com/smartgit/download/ here.  
  
## To set up local dependencies/requirements, you can also run _dev_setup.cmd!    
# Grab the code  
##  1. Fork it on github    
- go to https://github.com/manavortex/FurnitureCatalogue  
- the "fork" button is on github, TOPRIGHT corner, directly below your avatar  
- this will give you an own copy of my repository: https://github.com/yourusername/FurnitureCatalogue  
- You need this because you can't write to mine, and I'm not turning it on for the general public. You push your changes to your copy, then create a pull request. I'll review and put it back into the main code base. :)    
## 2. Check out your new fork to your local harddrive    
- For this, first delete all the files from the AddOn that you have installed via Minion. (The first step to developing the AddOn is to delete the AddOn!)   
	You can get there by pressing windows+R and executing the command `explorer %USERPROFILE%\Documents\Elder Scrolls Online\live\AddOns\FurnitureCatalogue`  
- In your browser on github, the green "code" button gives you an URL to copy.   
	It will look like `https://github.com/yourusername/FurnitureCatalogue.git`  
- Open smartgit. Use the default settings unless indicated otherwise.  
	- You're a non-commercial user.  
	- Style: You want "Working Tree", I think.  
	- Click "Clone a repo".  
	- Path: Click "browse", then open the explorer bar and enter `%USERPROFILE%\Documents\Elder Scrolls Online\live\AddOns\FurnitureCatalogue`.  
	- URL: the one you copied from the browser in the step above.    
## 3. - Optional: Add the original repository as a second upstream.  
This allows you to fetch changes from my repository, in case we're working on this together.  
- click Remote -> Add -> and enter  
	- original  
	- https://github.com/manavortex/FurnitureCatalogue.git  
  
# Terminology  
I'll be using these words through the guide, so you need to be familiar with them:    
## Table and Key/Value  
In LUA, everything is a table. Tables look like this:  
```
	local tbl = {  
		["Key"] = "Value",  
	}  
```
The key is how you access stuff in the table. The value is the stored value.   
Keys are always left of the =.   
`tbl["Key"]` is identical to `tbl.Key`.    
# Set up development stuff  
## 1. Register yourself as a developer    
- Add your account name to the table at line 10 of FurnitureCatalogue_DevUtility\00_startup.lua  
- Make sure that you don't forget the trailing comma!    
## 2. Copy the required files (or run _dev_setup.cmd)    
### Custom.lua  
- Copy or move `data\_SidTools_Custom.lua` to `..\sidTools\Custom.lua`. That will add a little bit of code to sirinsidiator's AddOn that'll let you export furniture recipes as saved var.  
- Rename `data\Custom_Example.lua` to `data\Custom.lua`.    
# Extract items    
## 1. log in and datamine!  
- Run the command `/sidtools items show` or run `/sidtools` and open the "ItemViewer" via menu  
- populate it - make it scan. If you need to put an item ID, use 80000 or something.  
- type '/dumpfurniture'.  
- When it's done, reload the UI via `reloadUI`.    
## 2. grab the stuff from sidTool's saved variables  
For now, we will stay in Custom.lua so you can fuck around and find out. As for how to properly set up the files, see below.    
- go to `..\SavedVariables\sidTools.lua`  
- the relevant entries are `furnitureRecipes` and `furniture`.  
- Copy them to the corresponding tables in your `data\Custom.lua`. You'll see differences in formatting – you need to make sure that the generated entries have the same format as the regular ones.  
	  
### Fix up the items  
- mark all the items. Fastest way to go about it is to click the "-" on the left side of Notepad++ and to select the collapsed region.  
- Press Ctrl+H (Search&Replace)  
- Check "In selection"-box  
- Select the third entry under "Search Mode": Regular expression  
1. Find what: `((?<=\] = )")|(",$)`  
2. Replace with: ``  
  
### Fix up the recipes  
- Mark all the recipes.  Fastest way to go about it is to click the "-" on the left side of Notepad++ and to select the collapsed region.   
- Press Ctrl+H (Search&Replace)  
- Check "In selection"-box  
- Select the third entry under "Search Mode": Regular expression  
1. Find what: `\[|(\] = "rumourSource)|",$`  
2. Replace with: ``  
  
# OK, I wanna release! What now?  
  
## 1. Version number    
### Create a new constant.  
In `FurnitureCatalogue\_Constants.lua`, add a line like this:  
	FURC_FOOBAR				= FURC_LASTLINE     +1        -- <number in previous line +1>  
The thing on the left of the = is your new entry. The thing on the right of the = is the value in the line below.  
The comment on the right is to see the number at first glance if you ctrl+F for the constant.    
### Add translation constants  
Menu entry:   
In `FurnitureCatalogue\locale\en.lua`, find the list that starts with `SI_FURC_FILTER_VERSION_OFF`. It should be around line 207.   
Add SI_FURC_FILTER_VERSION_FOOBAR at the end of the block (you can duplicate the previous line), and change the text.     
Add mouseover tooltip:   
Now, find the list that starts with `SI_FURC_FILTER_VERSION_OFF_TT`. It should be around line ~250 somewhere.   
Add SI_FURC_FILTER_VERSION_FOOBAR_TT at the end of the block (you can duplicate the previous line), and change the text.     
### Add the context menu entries.  
In `FurnitureCatalogue\startup.lua`, find `FurC.DropdownData` around line 131.  
At the bottom of each list, add a line with the constant from the previous step.      
# Troubleshooting    
If you are running into any problems with FurC data, the answer is going to be "you're missing a comma" in 95% of all cases.    
## The UI is showing, but all data is gone!  
You're probably missing a comma in one of the data files. That will lead to the scan function failing and an empty database.   
To fix this, open DebugViewer and look for the first FurC related error you see.     
## I added items to an existing table, but they're not showing up  
1: Search for one of the preexisitng items in the table. Does it show up?   
Yes: Make sure that you got the nesting right. Everything needs to be on the right level. If you put entries into other entries, they'll be ignored.  
No: You're missing a comma.    