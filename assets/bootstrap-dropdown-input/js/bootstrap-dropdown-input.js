(function() {

  (function($, window) {
    var LabeledInput, defaults, document, pluginName;
    pluginName = 'dropdowninput';
    document = window.document;
    defaults = {
      inputClass: 'input-mini'
    };
    LabeledInput = (function() {

      function LabeledInput(element, options) {
        this.element = element;
        this.options = $.extend({}, defaults, options);
        this.init();
      }

      LabeledInput.prototype.template = function() {
        return "<div class='dropdown bootstrap-dropdowninput'>" + ("<a class='dropdown-toggle bootstrap-dropdowninput bootstrap-dropdowninput-link' data-toggle='dropdown' href='#'>" + this.value + "</a>") + "<div class='bootstrap-dropdowninput dropdown-menu' data-autoclose='0'>" + ("<input name='dropdown_input_" + this.name + "' value='" + this.value + "' class='" + this.options.inputClass + " bootstrap-dropdowninput bootstrap-dropdowninput-input' type='text'>") + "</div>" + "</div>";
      };

      LabeledInput.prototype.init = function() {
        this.value = this.element.val();
        this.name = this.element.prop('name');
        this.widget = $(this.template()).insertAfter(this.element);
        this.input = this.widget.find('input.bootstrap-dropdowninput-input');
        this.link = this.widget.find('a.bootstrap-dropdowninput-link');
        return this.bindEvents();
      };

      LabeledInput.prototype.bindEvents = function() {
        this.input.on('keyup', $.proxy(this.updateLabel, this));
        return this.input.on('change', $.proxy(this.updateValue, this));
      };

      LabeledInput.prototype.updateLabel = function() {
        var value;
        value = this.input.val();
        if (value !== '') {
          return this.link.html(value);
        }
      };

      LabeledInput.prototype.updateValue = function() {
        var value;
        value = this.input.val();
        if (value !== '') {
          this.element.val(value);
          return this.element.trigger('change');
        }
      };

      return LabeledInput;

    })();
    $.fn["" + pluginName] = function(options) {
      return this.each(function() {
        var $element;
        $element = $(this);
        options = $.extend({}, options, $element.data());
        if ($.data(this, "plugin_" + pluginName) == null) {
          return $.data(this, "plugin_" + pluginName, new LabeledInput($element, options));
        }
      });
    };
    $('body').on('click', '[data-autoclose="0"]', function(e) {
      return e.stopPropagation();
    });
    return $('[data-provide="dropdowninput"]').dropdowninput();
  })(jQuery, window);

}).call(this);
