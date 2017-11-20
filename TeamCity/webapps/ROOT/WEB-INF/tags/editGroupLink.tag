<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@attribute name="group" type="jetbrains.buildServer.groups.SUserGroup" required="true"
  %><%@attribute name="tab" required="false"
  %><%@attribute name="noLink" required="false"
  %><c:set var="tabParam" value=""
  /><c:if test="${not empty tab}"><c:set var="tabParam">&tab=${tab}</c:set></c:if
  ><c:url value='/admin/editGroup.html?init=1&groupCode=${group.key}${tabParam}' var="editUrl"
  /><c:set var="content"><jsp:doBody/></c:set
  ><c:if test="${empty content}"><c:set var="content"><c:out value="${group.name}"/></c:set></c:if
  ><c:choose
  ><c:when test="${noLink}">${editUrl}</c:when
  ><c:when test="${afn:canEditGroup(group)}"
  ><a href="${editUrl}">${content}</a
  ></c:when
  ><c:otherwise
  >${content}</c:otherwise></c:choose>