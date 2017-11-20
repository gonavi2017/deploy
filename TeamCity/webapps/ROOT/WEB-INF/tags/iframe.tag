<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
  %><%@ attribute name="url" fragment="false" required="true"
  %>
<iframe id="iframe" src="${url}" width="100%" frameborder="0"
onload="{
var avoidScrollbars = ${intprop:getBooleanOrTrue('teamcity.ui.iframe.avoidScrollbars')},
  iframe = this,
  $iframe = $j(iframe),
  fakeResize = true,
  resizeFrame = function () {
    var window = BS.Util.windowSize(window);
    var header = $('topWrapper').getDimensions();
    var height = Math.max(window[1] - header.height - 200, 600); // 600 - magic constant from ancient times
    var iframeBody;

    try {
      iframeBody = iframe.contentWindow.document.body
    } catch (e) {
      iframeBody = null; // could not get into iframe due to cross-domain restrictions
    }

    if (avoidScrollbars && iframeBody) {
      if (iframeBody.scrollWidth > iframe.scrollWidth) {
        $iframe.css('width', iframeBody.scrollWidth);
      }

      height = Math.max(height, iframeBody.scrollHeight);
    }

    $iframe.css('height', height);
  };

resizeFrame();
fakeResize = false;
Event.observe(window, 'resize', resizeFrame);

this.onload = resizeFrame;
}"></iframe>
