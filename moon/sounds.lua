sounds = { }
sounds.tags = { }
sounds.tags.music = ripple.newTag()
sounds.tags.sfx = ripple.newTag()
local newEffect
newEffect = function(name, settings)
  local source = love.audio.newSource("assets/sounds/" .. tostring(name) .. ".mp3", "static")
  local sound = ripple.newSound(source, settings)
  return sound:tag(sounds.tags.sfx)
end
local newMusic
newMusic = function(name, settings)
  local source = love.audio.newSource("assets/sounds/" .. tostring(name) .. ".mp3", "stream")
  local sound = ripple.newSound(source, settings)
  sound.loop = true
  sound:tag(sounds.tags.music)
  return sound
end
sounds.load = function(self)
  self.titleMusic = newMusic("titleMusic")
end
