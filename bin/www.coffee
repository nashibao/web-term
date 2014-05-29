#!/usr/bin/env node
debug = require('debug')('web-term')
app = require('../app')

app.set('port', process.env.PORT || 3000)

server = app.listen app.get('port'), ()->
  debug('Express server listening on port ' + server.address().port)

io = require('socket.io').listen(server, { log: false })

global.io = io

require('../apps/shell')
