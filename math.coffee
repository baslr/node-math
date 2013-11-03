
fs   = require 'fs'

try
  table = require './data.json'
catch e
  table = {}
  for x in [1..20]
    for y in [1..20]
      table[x] = {} if ! table[x]?
      table[x][y] = {solvs:[], minMs:0, maxMs:0}

max    = {n:0, x, y} # store maxMs solve time
x      = 0
y      = 0
tStart = 0

for x in [1..20]
  for y in [1..20]
    entry = table[x][y]
    if entry.solvs.length
      if entry.solvs[0].ms >= max.n
        max.n = entry.solvs[0].ms
        max.x = x
        max.y = y

newTask = ->
  if 10 is Math.floor (Math.random()*10)+1
    console.log '10. present you maxMs:'
    ms = 0
    for a in [1..20]
      for b in [1..20]
        entry = table[a][b]
        if entry.solvs.length
          if entry.solvs[0].ms >= ms
            ms = entry.solvs[0].ms
            x = a
            y = b
  else
    console.log 'select fewest solvs'
    n     = 99999999
    parts = []
    
    for a in [1..20]
      for b in [1..20]
        entry = table[a][b]
        if entry.solvs.length is n
          parts.push {x:a, y:b}
        else if entry.solvs.length < n
          n     = entry.solvs.length
          parts = []
          parts.push {x:a, y:b}

    part = Math.floor (Math.random()*parts.length)
    console.log "parts: #{parts.length}, part:#{part}"

    x = parts[part].x
    y = parts[part].y    


  
  console.log "#{x} * #{y}"
  tStart = new Date().getTime()

process.stdin.resume()
process.stdin.setEncoding 'utf8'

process.stdin.on 'data', (sol) ->
  sol = sol.split('\n')[0]
  
  if sol is 'pause'
    tStart = new Date().getTime() - tStart # time for now
    console.log "pause with #{tStart}ms"
    return
    
  if sol is 'resume'
    tStart = new Date().getTime() - tStart
    console.log 'resume'
    return
  
  if x * y is Number sol
    ms    = new Date().getTime() - tStart
    entry = table[x][y]
    entry.maxMs = ms if entry.maxMs < ms or entry.maxMs is 0
    entry.minMs = ms if entry.minMs > ms or entry.minMs is 0
    
    entry.solvs.unshift {ms:ms, date:new Date()}
    fs.writeFileSync './data.json', JSON.stringify table
    
    console.log "right :) you needed #{ms}"

  else
    console.log "wrong :( true is: #{x * y}"
  newTask()

newTask()

# blutgeld
