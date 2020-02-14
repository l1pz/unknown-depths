local sin, cos
do
  local _obj_0 = math
  sin, cos = _obj_0.sin, _obj_0.cos
end
shaders = { }
local crt_code = "\n    extern vec2 distortionFactor;\n    extern vec2 scaleFactor;\n    extern number feather;\n\n    vec4 effect(vec4 color, Image tex, vec2 uv, vec2 px) {\n      // to barrel coordinates\n      uv = uv * 2.0 - vec2(1.0);\n\n      // distort\n      uv *= scaleFactor;\n      uv += (uv.yx*uv.yx) * uv * (distortionFactor - 1.0);\n      number mask = (1.0 - smoothstep(1.0-feather,1.0,abs(uv.x)))\n                  * (1.0 - smoothstep(1.0-feather,1.0,abs(uv.y)));\n\n      // to cartesian coordinates\n      uv = (uv + vec2(1.0)) / 2.0;\n\n      return color * Texel(tex, uv) * mask;\n    }\n  "
local chroma_code = "\n    extern vec2 direction;\n    vec4 effect(vec4 color, Image texture, vec2 tc, vec2 _)\n    {\n      return color * vec4(\n        Texel(texture, tc - direction).r,\n        Texel(texture, tc).g,\n        Texel(texture, tc + direction).b,\n        1.0);\n    }\n  "
shaders.load = function(self)
  shaders.crt = love.graphics.newShader(crt_code)
  shaders.chroma = love.graphics.newShader(chroma_code)
  shaders.crt:send("distortionFactor", {
    1.05,
    1.05
  })
  shaders.crt:send("scaleFactor", {
    1,
    1
  })
  shaders.crt:send("feather", 0)
  local chroma_amount = 2
  local dx = cos(10) * chroma_amount / love.graphics.getWidth()
  local dy = sin(10) * chroma_amount / love.graphics.getHeight()
  shaders.chroma:send("direction", {
    dx,
    dy
  })
  return self:set(true)
end
shaders.set = function(self, state)
  debugEnableShaders = state
  if state then
    return push:setShader({
      shaders.chroma
    })
  else
    return push:setShader({ })
  end
end
