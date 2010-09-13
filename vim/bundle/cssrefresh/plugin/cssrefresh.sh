#!/bin/sh
osascript -s o << END
    tell application "Safari"
      do JavaScript "
        (function(\$) {
          var spec = '$1';
          var updater = {
            el: null,
            init: function () {
                if (this.el) { this.el.remove(); }
                this.el = \$('<div>').css({
                    position: 'absolute',
                    top: '5px',
                    left: '5px',
                    background: 'rgba(0, 0, 0, 0.5)',
                    color: 'white',
                    'font': '8pt/12pt helvetica, sans-serif',
                    'z-index': '10012',
                    'padding': '2px 10px',
                    'border': 'solid 2px rgba(255,255,255,0.5)'
                });
                \$('body').append(this.el);
            },
            updateNumbers: function (a, b, url) {
                if (a == b) { this.el.fadeOut(function () { \$(this).remove(); }); }
                var str = '';
                for (var i=0; i<a; ++i) { str += '|'; }
                for (var i=0; i<(b-a); ++i) { str += '&nbsp;'; }
                this.update(str);
            },
            update: function (str) {
                this.el.html(str);
            }
          };

          var \$sheets = \$('link[rel=stylesheet]');
          var loaded = 0;
          var total = 0;

          \$sheets.each(function () {
              var \$this = \$(this);

              if (\$this.data('url')) {
                  var href = \$this.data('url');
              } else {
                  var href = \$this.attr('href');
                  \$this.data('url', href);

                  var \$style = \$('<style>').attr('type', 'text/css');
                  \$('head').append(\$style);
                  \$this.data('style', \$style);
              }

              \$this.reloader = function () {
                  var _this = \$(this);
                  var url = _this.data('url');
                  \$.get(url, function (data) {
                      _this.attr('href', '');
                      _this.data('style').html(data);
                      _this.attr('disabled', 1);
                      updater.updateNumbers(++loaded, total, url);
                  });
              };

              if ((!spec) || (href.match(spec)))
                  { \$this.reloader(); total += 1; }
          });

          updater.init();
          updater.updateNumbers(0, total);
        })(jQuery);
      " in front document
    end tell
END
