<%@ tag import="jetbrains.buildServer.web.util.PageResourceCompressor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% PageResourceCompressor compressor = (PageResourceCompressor)request.getAttribute("pageResourceCompressor");
    jspContext.setAttribute("version", compressor.getVersion());
%>
<script type="text/javascript">
  var webComponentsSupported = ('registerElement' in document
                                && 'import' in document.createElement('link')
                                && 'content' in document.createElement('template'));
  if (!webComponentsSupported) {
    var wcPoly = document.createElement('script');
    wcPoly.src = "<c:url value='/res/webComponents/libs/webcomponentsjs/webcomponents-lite.min.js?v=${version}'/>";
    wcPoly.onload = lazyLoadPolymerAndElements;
    document.head.appendChild(wcPoly);
  } else {
    lazyLoadPolymerAndElements();
  }
  function lazyLoadPolymerAndElements () {
    var elements = [
      "<c:url value='/res/webComponents/teamcity-elements/popups.html?v=${version}'/>"
    ];
    elements.forEach(function(elementURL) {
      var elImport = document.createElement('link');
      elImport.rel = 'import';
      elImport.href = elementURL;
      document.head.appendChild(elImport);
    })
  }
</script>
