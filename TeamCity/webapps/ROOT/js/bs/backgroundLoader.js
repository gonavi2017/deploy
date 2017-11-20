BS.BackgroundLoader = {
  _started: false,
  _requests: [],

  /**
   * Loads part of markup accessible via given markupUrl in background
   * and replaces the $j(placeholder) with the result. Sends provided params
   * to markupUrl.
   * @param placeholder
   * @param markupUrl
   * @param params
   */
  load: function(placeholder, markupUrl, params) {
    this._requests.push({placeholder: placeholder,
      markupUrl: markupUrl,
      params: params});
    if (!this._started) {
      this._started = true;
      this._computeNext();
    }
  },

  _computeNext: function() {
    var that = BS.BackgroundLoader;
    if (that._requests.length == 0) {
      that._started = false;
      return;
    }
    var next = that._requests.shift();
    var placeholder = next.placeholder;
    var url = next.markupUrl;
    BS.ajaxRequest(url, {
      parameters: Object.toQueryString(next.params),
      onSuccess: function(transport) {
        var txt = transport.responseText;
        if (txt !== '') {
          //for some reason prototype calls onSuccess callback with empty txt
          //when user leaves the page, don't replace anything in this case,
          //otherwise placeholder disappears
          var className = $j(placeholder).attr('class');
          var replacement = $j(txt);
          $j(placeholder).replaceWith(replacement);
          if (className) {
            $j(replacement).addClass(className);
          }
        }
        that._computeNext();
      }
    });
  }
};