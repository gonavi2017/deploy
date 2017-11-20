<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><%@ attribute name="tab" fragment="false" required="false"
  %><%@ attribute name="title" fragment="false" required="false"
  %><%@ attribute name="urlAddOn" fragment="false" required="false"
  %><%@ attribute name="attrs" fragment="false" required="false"
  %><%@ variable name-given="url" scope="AT_END"
  %><%@ attribute name="noLink" required="false"
  %><c:set var="title"><c:out
    value="${title}"
    /></c:set><c:if test="${empty tab}" ><c:set
  var="tab" value="buildLog"/></c:if><c:url
  value="/viewLog.html?buildId=${build.buildId}&tab=${tab}&buildTypeId=${build.buildTypeExternalId}" var="url"/><c:set var="url" value="${url}${urlAddOn}"
  /><c:if test="${empty noLink or not noLink}" ><a class="resultsLink" href="${serverPath}${url}" title="${title}" ${attrs}><jsp:doBody/></a></c:if>