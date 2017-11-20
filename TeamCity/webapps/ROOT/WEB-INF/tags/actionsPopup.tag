<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="controlId" required="true" %><%@
    attribute name="content" fragment="true" required="true"%><%@
    attribute name="popup_options" required="false"%><%@
    attribute name="autoSetupPopup" required="false" type="java.lang.Boolean"
%><bs:trimWhitespace><c:if test="${empty autoSetupPopup}"><c:set var="autoSetupPopup" value="${true}"/></c:if>
<c:set var="text"><jsp:doBody/></c:set>
<c:set var="options">{${popup_options}}</c:set>
<span class="btn-group" id="sp_span_${controlId}"><button <c:if test="${not autoSetupPopup}">data_non_initialized_actions_popup_id="${controlId}" data_popup_options="${options}"</c:if> class="btn btn_mini popupLink <c:if test="${not autoSetupPopup}">nonInitializedActionPopup</c:if>" type="button">
<c:if test="${empty text}"><i class="icon-list-ul"></i></c:if><c:if test="${not empty text}">${text}</c:if> <i class="icon-caret-down" id="${controlId}"></i></button></span>
  <div id="sp_span_${controlId}Content" class="popupDiv"><jsp:invoke fragment="content"/></div>
<c:if test="${autoSetupPopup}">
<script>
  BS.install_simple_popup('sp_span_${controlId}', {${popup_options}});
</script>
</c:if>
</bs:trimWhitespace>