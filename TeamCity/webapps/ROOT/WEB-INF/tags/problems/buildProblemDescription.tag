<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems"
%><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

%><%@ attribute name="compactMode" type="java.lang.Boolean" required="true"
%><%@ attribute name="showPopup" type="java.lang.Boolean" required="true"
%><%@ attribute name="showLink" type="java.lang.Boolean" required="true"
%><%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true"
%><%@ attribute name="buildProblemType" type="java.lang.String" required="false"
%><%@ attribute name="buildProblemUID" type="java.lang.String" required="true"
%><%@ attribute name="invokeDescription" type="java.lang.Boolean" required="false"
%><%@ attribute name="invokeDetails" type="java.lang.Boolean" required="false"

%><c:set var="uid" value="${buildProblemUID}"
/><c:set var="rawDescription"><bs:out value="${buildProblem.buildProblemData.description}" resolverContext="empty"/></c:set
><c:set var="problemDescription"><c:if test="${not empty buildProblemType && !fn:contains(rawDescription,buildProblemType)}">${buildProblemType}:</c:if>${rawDescription}</c:set
><c:set var="lineSeparatorIndex" value="${util:indexOfNewLineEx(rawDescription, 0, true)}"
/><c:if test="${lineSeparatorIndex>0}"
  ><c:set var="problemDescription">${fn:substring(rawDescription, 0, lineSeparatorIndex)}</c:set
  ><c:set var="problemDetails">${fn:substring(rawDescription, lineSeparatorIndex + fn:length(util:lineSeparator(true)), -1)}</c:set
></c:if

><c:set var="hasDetails" value="${not empty problemDetails && fn:length(problemDetails)>0}"

/><c:if test="${invokeDescription}"
><problems:buildProblemDescriptionText buildProblem="${buildProblem}" showPopup="${showPopup}"
  ><jsp:attribute name="problemBody"
      ><c:if test="${not empty buildProblemType}"><c:set var="additionalClasses" value="singleNode"/></c:if
      ><span class="descriptionContainer ${additionalClasses}" id="descriptionContainer_${uid}" data-id="${buildProblem.id}"><c:choose
        ><c:when test="${showLink}"><a id="problemLink_${uid}"
                          href="<c:url value="/viewLog.html?buildId=${buildProblem.buildPromotion.associatedBuildId}&problemId=${buildProblem.id}"/>"
                          title="Show problem on build Overview">${problemDescription}</a></c:when
          ><c:otherwise>${problemDescription}</c:otherwise
        ></c:choose
      ></span><script>
    var el = $j('#descriptionContainer_${uid}');
    if (el.find('a').length > 0) {
      el = el.find('a');
    }
    BS.BuildProblems.shortenLongDescription(el);
  </script></jsp:attribute
  ></problems:buildProblemDescriptionText
></c:if
><c:if test="${invokeDetails && !compactMode && hasDetails}"
  ><problems:buildProblemDetails uid="${uid}" insertIcons="true" buildProblem="${buildProblem}">
    <div class="code">${rawDescription}</div>
  </problems:buildProblemDetails
></c:if>