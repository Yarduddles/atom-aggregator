{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-text-editor', 'aggregate:sum': => @sum()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'aggregate:max': => @max()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'aggregate:min': => @min()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'aggregate:avg': => @avg()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'aggregate:count': => @count()

  deactivate: ->
    @subscriptions.dispose()

  get_nums: (text) ->
    # A regex to grab all numbers available in the selected text
    r_nums = ///(-{0,1}\d*\.{0,1}\d+)///g
    text.match(r_nums)

  sum: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    text = selection.getText()

    found = @get_nums(text)

    sum = 0.0

    if not found
      return

    for n in found
      sum += parseFloat(n)

    selection.insertText("#{sum}")

  max: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    text = selection.getText()

    found = @get_nums(text)

    if not found
      return

    max = Math.max found...
    selection.insertText("#{max}")

  min: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    text = selection.getText()

    found = @get_nums(text)

    if not found
      return

    min = Math.min found...
    selection.insertText("#{min}")

  avg: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    text = selection.getText()

    found = @get_nums(text)

    if not found
      return

    sum = 0.0
    count = 0

    for n in found
      sum += parseFloat(n)
      count += 1

    selection.insertText("#{sum/count}")

  count: ->
    editor = atom.workspace.getActivePaneItem()
    selection = editor.getLastSelection()
    text = selection.getText()

    found = @get_nums(text)

    if not found
      return

    count = found.length
    selection.insertText("#{count}")
