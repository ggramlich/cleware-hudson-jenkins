module.exports = (_) ->
  (colors) ->
    colors = if (typeof colors is 'string') then [colors] else _.values colors
    has = (color) -> _.contains colors, color

    normalized = {}
    ['red', 'yellow', 'green', 'blue'].forEach (color) ->
      normalized[color] = if has("#{color}_anime") then 'a' else has(color)

    # merge blue into green
    normalized['green'] =
      if (normalized['blue'] is 'a' or normalized['green'] is 'a')
      then 'a'
      else normalized['blue'] or normalized['green']

    delete normalized['blue']

    normalized
