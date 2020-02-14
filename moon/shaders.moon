import sin, cos from math

export shaders = {}

crt_code = "
    extern vec2 distortionFactor;
    extern vec2 scaleFactor;
    extern number feather;

    vec4 effect(vec4 color, Image tex, vec2 uv, vec2 px) {
      // to barrel coordinates
      uv = uv * 2.0 - vec2(1.0);

      // distort
      uv *= scaleFactor;
      uv += (uv.yx*uv.yx) * uv * (distortionFactor - 1.0);
      number mask = (1.0 - smoothstep(1.0-feather,1.0,abs(uv.x)))
                  * (1.0 - smoothstep(1.0-feather,1.0,abs(uv.y)));

      // to cartesian coordinates
      uv = (uv + vec2(1.0)) / 2.0;

      return color * Texel(tex, uv) * mask;
    }
  "

chroma_code = "
    extern vec2 direction;
    vec4 effect(vec4 color, Image texture, vec2 tc, vec2 _)
    {
      return color * vec4(
        Texel(texture, tc - direction).r,
        Texel(texture, tc).g,
        Texel(texture, tc + direction).b,
        1.0);
    }
  "

shaders.load = =>
  shaders.crt = love.graphics.newShader crt_code
  shaders.chroma = love.graphics.newShader chroma_code
  shaders.crt\send "distortionFactor", {1.05, 1.05}
  shaders.crt\send "scaleFactor", {1, 1}
  shaders.crt\send "feather", 0
  chroma_amount = 2
  dx = cos(10) * chroma_amount / love.graphics.getWidth!
  dy = sin(10) * chroma_amount / love.graphics.getHeight!
  shaders.chroma\send("direction", {dx, dy})
  @set true

shaders.set = (state) =>
  export debugEnableShaders = state
  if state
    push\setShader({shaders.chroma})
  else
    push\setShader({})