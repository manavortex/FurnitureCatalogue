-- Check favourite system

if not Taneth then
  return
end

-- Real global table
local G = _G

Taneth("FurC:Unit", function()
  local Test = FurCDev.Test

  -- Store SavedVars, so we don't wipe the real ones
  local function protectSavedVars(fn)
    local savedFavorites = FurC.settings.favorites
    local savedData = FurC.settings.data
    local savedUpdateGui = FurC.UpdateGui
    FurC.settings.favorites = {}
    FurC.UpdateGui = function() end

    local ok, err = pcall(fn)

    FurC.settings.favorites = savedFavorites
    FurC.settings.data = savedData
    FurC.UpdateGui = savedUpdateGui
    if not ok then
      error(err, 0)
    end
  end

  describe("favourites (id set in SavedVars)", function()
    it("Toggles Faves and can read them", function()
      protectSavedVars(function()
        local id = 204688 -- Dawnwood Lantern, Hanging
        local link = Test.link(id)

        FurC.Fave(link)
        assert.is_true(FurC.IsFavoriteById(id))
        assert.is_true(FurC.IsFavorite(link))
        FurC.Fave(link)
        assert.is_false(FurC.IsFavoriteById(id))
      end)
    end)

    it("resolves recipe to furnishing result", function()
      local recipeId, resultId = 126987, 126427 -- Praxis: Telvanni Shelves, Organic -> Telvanni Shelves, Organic
      local recipeLink, resultLink = Test.link(recipeId), Test.link(resultId)

      local savedIsRecipe = G.IsItemLinkFurnitureRecipe
      local savedRecipeResult = G.GetItemLinkRecipeResultItemLink
      G.IsItemLinkFurnitureRecipe = function(link)
        return link == recipeLink
      end
      -- Headless just returns recipe, so we fake the pair
      G.GetItemLinkRecipeResultItemLink = function(link)
        return link == recipeLink and resultLink or link
      end

      local ok, err = pcall(function()
        protectSavedVars(function()
          FurC.Fave(recipeLink)
          assert.is_true(FurC.IsFavoriteById(resultId))
          assert.is_false(FurC.IsFavoriteById(recipeId))
          assert.is_true(FurC.IsFavorite(recipeLink))
        end)
      end)

      G.IsItemLinkFurnitureRecipe = savedIsRecipe
      G.GetItemLinkRecipeResultItemLink = savedRecipeResult
      if not ok then
        error(err, 0)
      end
    end)
  end)
end)
