# 書いた内容を保持するモデル
class TextModel extends Backbone.Model
  defaults:
    text: ''

# プレビュー用のビュー
class PreviewView extends Backbone.View
  el: '#preview'

  initialize: (options) ->
    @listenTo @model, 'change', @render

  render: (model)->
    @$el.html marked model.toJSON().text
    @

# 入力用のView
class InputView extends Backbone.View
  el: '#input'
  bindings:
    '#input': 'text'

textModel = new TextModel();
previewView = new PreviewView
  model: textModel
editorView = new InputView
  model: textModel 