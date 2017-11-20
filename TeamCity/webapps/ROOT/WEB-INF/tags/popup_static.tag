<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="controlId" required="true" %><%@
    attribute name="content" fragment="true" required="true" %><%@
    attribute name="linkOpensPopup" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="style" required="false" %><%@
    attribute name="controlClass" type="java.lang.String" required="false" %><%@
    attribute name="popupClass" type="java.lang.String" required="false" %><%@
    attribute name="popup_options" required="false" %><%@
    attribute name="topRightButton" required="false"
    %><bs:trimWhitespace>
  <c:if test="${linkOpensPopup}">
    <c:set var="body"><a href="#" class="popupLink" onclick="return false"><jsp:doBody/></a></c:set>
  </c:if>
  <c:if test="${not linkOpensPopup}">
    <c:set var="body"><jsp:doBody/></c:set>
  </c:if>
  <bs:popup type="simplePopup"
            id="${controlId}"
            additionalClasses="${controlClass}"
            showOptions="{${popup_options}}"
            topRightButton="${topRightButton}">${body}</bs:popup>
  <div id="${controlId}Content" class="popupDiv ${popupClass}"><jsp:invoke fragment="content"/></div>
</bs:trimWhitespace>
