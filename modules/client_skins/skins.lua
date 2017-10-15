
-- private variables
local defaultLocaleName = 'en'
local installedLocales
local currentLocale


function createWindow()


  localesWindow = g_ui.displayUI('skins')
  local localesPanel = localesWindow:getChildById('localesPanel')
  local layout = localesPanel:getLayout()
  local spacing = layout:getCellSpacing()
  local size = layout:getCellSize()

end

function hide()
  localesWindow:hide()
end

