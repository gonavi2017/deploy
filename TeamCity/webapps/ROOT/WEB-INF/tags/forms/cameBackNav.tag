<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="cameFromSupport" required="true" type="jetbrains.buildServer.web.util.CameFromSupport"

%><c:if test="${not empty cameFromSupport.cameFromUrl and not empty cameFromSupport.cameFromTitle}">
{title: "<bs:escapeForJs text='${cameFromSupport.cameFromTitle}'/>", url: '${util:escapeUrlForQuotes(cameFromSupport.cameFromUrl)}'}
</c:if>
