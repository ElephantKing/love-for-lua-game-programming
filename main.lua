local LevelScene = require 'level/Scene'
local MenuScene = require 'menu/Scene'

local scene

local key_pressed = {}
local key_held = {}

function love.keypressed(k)
  key_pressed[k] = true
  key_held[k] = true
end

function love.keyreleased(k)
  key_held[k] = nil
end

local function reset_keys()
  for key in pairs(key_pressed) do
    key_pressed[key] = nil
  end
end

local function init()
  scene = MenuScene(key_pressed, function()
    scene = LevelScene(key_pressed, key_held, 'res/background.png', 'res/map.tmx', init, init)
  end)
end

function love.load()
  init()
end

function love.draw()
  scene:render()
end

function love.update(dt)
  scene:update(dt)
  reset_keys()
end
