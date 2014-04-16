apiUrl = "https://api.github.com/repos/yyx990803/vue/commits?per_page=3&sha="

demo = new Vue
  el:  '#demo'

  data:
    branch: 'master'

  created: ->
    @$watch 'branch', ->
      @fetchData()

  filters:
    truncate: (v)->
      newline = v.indexOf '\n'
      (if newline > -1 then v.slice(0, newline) else v)

    formatDate: (v)->
      v.replace /T|Z/g, ' '

  methods:
    fetchData: ->
      xhr = new XMLHttpRequest()
      self = this
      xhr.open "GET", apiUrl + self.branch
      xhr.onload = ->
        self.commits = JSON.parse(xhr.responseText)
        return

      xhr.send()
      return

