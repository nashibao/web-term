require('sugar')
pty = require("pty.js")

# terminal emulater to stdout
term = pty.spawn("fish", [],
    {
        name: "xterm-color"
        cols: 8000
        rows: 3000
        # cwd: process.env.HOME
        env: process.env
    }
)


# # stdin to terminal emulater
# process.stdin.setEncoding('utf8')
# process.stdin.on "readable", ->
#   chunk = process.stdin.read()
#   if chunk
#       term.write chunk
#   return

# socket.io
io = global.io

cache = ''

io.sockets.on "connection", (socket) ->

  term.on "data", (data) ->
    data = data.trim()
    return if not data
    lines = data.split('\r')
    socket.emit "res", {lines: lines}

  socket.emit "news",
    hello: "world"

  socket.on "command", (data) ->
    term.write data.command + '\r'
    return

  return