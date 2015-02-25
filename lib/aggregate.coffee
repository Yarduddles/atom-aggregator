{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    atom.workspaceView.command "aggregate:sum", => @sum()
    atom.workspaceView.command "aggregate:max", => @max()
    atom.workspaceView.command "aggregate:min", => @min()
    atom.workspaceView.command "aggregate:avg", => @avg()
    atom.workspaceView.command "aggregate:count", => @count()

  get_nums: (text) ->
    # A regex to grab all numbers available in the selected text
    r_nums = ///(-{0,1}\d*\.{0,1}\d+)///g
    text.match(r_nums)

  sum: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getSelection()

    text = selection.getText()
    found = this.get_nums(text)

    sum = 0.0

    if !found
      return

    for n in found
      sum += parseFloat(n)

    editor.getSelection().insertText("#{sum}")

  max: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getSelection()

    text = selection.getText()
    found = this.get_nums(text)

    if !found
      return

    max = Math.max found...
    editor.getSelection().insertText("#{max}")

  min: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getSelection()
    text = selection.getText()

    found = this.get_nums(text)

    if !found
      return

    min = Math.min found...
    editor.getSelection().insertText("#{min}")

  avg: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getSelection()
    text = selection.getText()

    found = this.get_nums(text)

    if !found
      return

    sum = 0.0
    count = 0

    for n in found
      sum += parseFloat(n)
      count += 1

    selection.insertText("#{sum/count}")

  count: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getSelection()
    text = selection.getText()

    found = this.get_nums(text)

    if !found
      return

    count = found.length
    editor.getSelection().insertText("#{count}")
