<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="text" %><%@
    attribute name="clazz" %><%@
    attribute name="scope" rtexprvalue="true" %><%@
    attribute name="noLink" rtexprvalue="true" %><%@
    attribute name="levelToSet" %><c:url var="a_link" value="${grp_link}"><c:param name="currentGroup" value="${levelToSet}"
    /><c:param name="scope" value="${scope}"
    /><c:param name="pager.currentPage" value="1"
    /></c:url><c:if test="${noLink}"><b><c:out value="${text}"/></b></c:if><c:if test="${not noLink}"><a href="${a_link}" title="Change current scope"
                 onclick="updateTestInfo('${levelToSet}', '<bs:escapeForJs forHTMLAttribute="true" text="${scope}"/>'); return false;"
                 <c:if test="${not empty clazz}">class="${clazz}"</c:if>
    ><c:out value="${text}"/></a></c:if>