<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="modification" required="true" type="jetbrains.buildServer.vcs.SVcsModification"
  %><%@ attribute name="title"
  %><%@ attribute name="attrs"
  %><%@ attribute name="buildTypeId"
  %><%@ attribute name="tab" required="false"
  %><c:if test="${empty title}"><c:set var="title">View change details</c:set></c:if><c:url
  value="/viewModification.html?modId=${modification.id}&personal=${modification.personal}&buildTypeId=${buildTypeId}" var="url"
    /><c:if test="${not empty tab}"><c:set var="url" value="${url}&tab=${tab}"/></c:if><a href="${serverPath}${url}"
                                                                                          title="${title == 'none' ? '' : title}" ${attrs}><jsp:doBody/></a>