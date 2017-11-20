<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%--TODO: move styles into separate tag--%>
<bs:linkCSS>
  /css/jquery/jquery-ui-ufd/ufd-base.css
  /css/jquery/jquery-ui-ufd/default/default.css
  /css/jquery/jquery-ui-ufd/popup/popup.css
  /css/jquery/jquery-ui/jquery-ui-1.9.2.custom.css
</bs:linkCSS>

<bs:linkScript>
  /js/es5-shim.js
  /js/jquery/jquery-1.12.1.min.js
</bs:linkScript>

<script type="text/javascript">
  window.$j = jQuery.noConflict();
</script>

<bs:linkScript>
  <%-- jQuery, jQuery UI, and plugins --%>
  /js/jquery/jquery.mousewheel.js
  /js/jquery/jquery-ui-1.10.4.custom.js
  /js/jquery/jquery.ui.ufd.js
  /js/jquery/jquery.ui.textarea.js

  /js/bs/teamcity.ui.autocomplete.js
  /js/bs/teamcity.ui.placeholder.js
  /js/bs/teamcity.ui.ellipsis.js
</bs:linkScript>
