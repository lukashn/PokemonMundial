additem = nil

local additem

function createWindow()
  lootWindow = g_ui.displayUI('loot')
end

function disable()
  lootButton:hide()
end

function hide()
  lootWindow:hide()
end

function show()
  lootWindow:show()
  lootWindow:raise()
  lootWindow:focus()
end