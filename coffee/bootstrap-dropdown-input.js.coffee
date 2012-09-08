# =========================================================
# bootstrap-dropdown-input.js
# http://www.github.com/simonoff/bootstrap-dropdown-input
# =========================================================
# Copyright 2012
#
# Created By:
# Alexander Simonov
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# =========================================================

(($, window) ->
  pluginName = 'dropdowninput'
  document = window.document
  defaults =
    inputClass: 'input-mini'

  # The actual plugin constructor
  class LabeledInput
    constructor: (@element, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options
      @init()

    template: ->
      "<div class='dropdown bootstrap-dropdowninput'>" +
        "<a class='dropdown-toggle bootstrap-dropdowninput bootstrap-dropdowninput-link' data-toggle='dropdown' href='#'>#{@value}</a>" +
          "<div class='bootstrap-dropdowninput dropdown-menu' data-autoclose='0'>" +
            "<input name='dropdown_input_#{@name}' value='#{@value}' class='#{@options.inputClass} bootstrap-dropdowninput bootstrap-dropdowninput-input' type='text'>" +
        "</div>" +
      "</div>"

    init: ->
      @value = @element.val()
      @name = @element.prop('name')
      @widget = $(@template()).insertAfter(@element)
      @input = @widget.find('input.bootstrap-dropdowninput-input')
      @link = @widget.find('a.bootstrap-dropdowninput-link')
      @bindEvents()

    bindEvents: ->
      @input.on 'keyup', $.proxy(@updateLabel, this)
      @input.on 'change', $.proxy(@updateValue, this)

    updateLabel: ->
      value = @input.val()
      @link.html(value) if value != ''

    updateValue: ->
      value = @input.val()
      if value != ''
        @element.val(value)
        @element.trigger('change')

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn["#{pluginName}"] = (options) ->
    @each ->
      $element = $(this)
      options = $.extend {}, options, $element.data()
      $.data(@, "plugin_#{pluginName}", new LabeledInput($element, options )) unless $.data(@, "plugin_#{pluginName}")?

  $('body').on 'click', '[data-autoclose="0"]', (e) ->
    e.stopPropagation()

  $('[data-provide="dropdowninput"]').dropdowninput()
)(jQuery, window)