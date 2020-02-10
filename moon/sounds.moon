export sounds = {}

sounds.tags = {}
sounds.tags.music = ripple.newTag!
sounds.tags.sfx = ripple.newTag!

newEffect = (name, settings) ->
  source = love.audio.newSource("assets/sounds/#{name}.mp3", "static")
  sound =  ripple.newSound(source, settings)
  sound\tag sounds.tags.sfx

newMusic = (name, settings) ->
  source = love.audio.newSource("assets/sounds/#{name}.mp3", "stream")
  sound =  ripple.newSound(source, settings)
  sound.loop = true
  sound\tag sounds.tags.music
  return sound

sounds.load = =>
  @titleMusic = newMusic "titleMusic"