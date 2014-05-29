socket = io.connect("http://localhost")


oo = ko.observable
oa = ko.observableArray
co = ko.computed

class ViewModel
  constructor: ()->
    @lines = oa([])
    @input = oo('')

    @command = ''

    socket.on "res", (data)=>
      lines = data.lines
      lines = lines.filter (line)=>
        return (not line.match('⏎')) and (not line.match(@command)) and (not (line == '[m'))
      lines = lines.map (line)->
        line = line.replace(']0;', '')
        line = line.replace('  ', '\t')
        return line
      @lines(@lines().concat(lines))
      window.scrollTo(0,document.body.scrollHeight)
      return

    @_input = co {
      owner: @
      read: ()=>
        return @input()
      write: (val)=>
        @input(val)
        return if not val
        @command = val
        socket.emit "command", {command: val}
        @input('')
    }

  convert: (line)->
    line = ansi_up.ansi_to_html(line)
    line = line.replace('\t', '<span class="tab"></span>')
    return line

module.exports = ViewModel
