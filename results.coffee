
data = require './data'

max = {n:0, x, y}
all = 0


for x in [1..20]
  for y in [1..20]
    entry = data[x][y]
    
    all += entry.solvs.length
    if entry.solvs.length > max.n
      max.x = x
      max.y = y
      max.n = entry.solvs.length
    
    console.log "#{x} * #{y}, solvs: #{entry.solvs.length}, min: #{entry.minMs}, max: #{entry.maxMs}"
    
console.log "all solvs: #{all}"
console.log "max: #{max.x} * #{max.y} with #{max.n} solvs."