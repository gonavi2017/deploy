if (CodeMirror) {
  BS.CodeMirror = {
    _textarea: null,
    _editor: null,
    _defaultOptions: {
      viewportMargin: 100,
      lineNumbers: true,
      matchBrackets: true,
      autoCloseTags: true,
      styleActiveLine: true,
      autofocus: true
    },
    fromTextArea: function(textarea, options) {
      var _options = OO.extend(this._defaultOptions, options);

      if (!this._hasMode(_options.mode)) {
        if (CodeMirror.TeamCity.modeMap.hasOwnProperty(_options.mode)) {
          _options.mode = CodeMirror.TeamCity.modeMap[_options.mode];
        } else {
          _options.mode = 'null';
        }
      }

      this._editor = CodeMirror.fromTextArea(textarea, _options);

      if (!this._hasMode(_options.mode)) {
        CodeMirror.autoLoadMode(this._editor, _options.mode);
      }

      return this._editor;
    },
    _hasMode: function (mode) {
      return CodeMirror.modes.hasOwnProperty(mode);
    }
  };
}