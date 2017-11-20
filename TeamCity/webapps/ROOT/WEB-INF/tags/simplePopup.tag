<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="controlId" required="true" %><%@
    attribute name="content" fragment="true" required="true" %><%@
    attribute name="linkOpensPopup" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="style" required="false" %><%@
    attribute name="controlClass" type="java.lang.String" required="false" %><%@
    attribute name="popupClass" type="java.lang.String" required="false" %><%@
    attribute name="popup_options" required="false"%><%@
    attribute name="topRightButton" required="false"
%><bs:trimWhitespace>
<%--
  deprecated, use popup_static instead
--%>
<c:if test="${linkOpensPopup}">
  <c:set var="body"><a href="#" class="popupLink" onclick="return false"><jsp:doBody/></a></c:set>
</c:if>
<c:if test="${not linkOpensPopup}">
  <c:set var="body"><jsp:doBody/></c:set>
</c:if>
<span class="pc ${controlClass}${not empty topRightButton ? ' pc_topRightButton' : ''}" id="sp_span_${controlId}"
      ><span class="pc__label">${body}</span><span class="pc__toggle-wrapper">&nbsp;<span id="${controlId}" class="icon icon16 toggle"></span></span>
</span>
<div id="sp_span_${controlId}Content" class="popupDiv ${popupClass}"><jsp:invoke fragment="content"/></div>
<script>
  BS.install_simple_popup('sp_span_${controlId}', {${popup_options}});
</script>
</bs:trimWhitespace>
