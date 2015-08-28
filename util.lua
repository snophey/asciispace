-- general utils functionality
utils = {}

local debug = true

function utils.dbg(str)
  if debug then
    print("GAME: " .. str)
  end
end

utils.dbg("Running in debug mode.")

return utils
