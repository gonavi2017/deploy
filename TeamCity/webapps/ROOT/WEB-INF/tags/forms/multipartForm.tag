<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="id" type="java.lang.String" required="true" %><%@
    attribute name="action" type="java.lang.String" required="false" %><%@
    attribute name="onsubmit" type="java.lang.String" required="false" %><%@
    attribute name="targetIframe" type="java.lang.String" required="false"
%><form id="${id}" method="post" action="${action}" onsubmit="${onsubmit}" enctype="multipart/form-data" target="${targetIframe}" autocomplete="off"><jsp:doBody/></form>
<c:if test="${not empty targetIframe}"><iframe id="${targetIframe}" name="${targetIframe}" style="display:none;"></iframe></c:if>