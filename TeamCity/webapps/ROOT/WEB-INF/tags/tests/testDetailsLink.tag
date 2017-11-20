<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="testBean" type="jetbrains.buildServer.serverSide.STest" required="true" %><%@
    attribute name="hideIcon" type="java.lang.Boolean" required="false" %><%@
    attribute name="showResponsible" type="java.lang.Boolean" required="false"
%><c:url var="testDetailUrl" value="/project.html?tab=testDetails">
  <c:param name="projectId" value="${testBean.projectExternalId}"/>
  <c:choose>
    <c:when test="${not empty testBean.testNameId}">
      <c:param name="testNameId" value="${testBean.testNameId}"/>
    </c:when>
    <c:otherwise>
      <c:param name="testName" value="${testBean.testName}"/>
    </c:otherwise>
  </c:choose>
</c:url>
<a href="${testDetailUrl}" title="View test details" <bs:iconLinkStyle icon="test-history" hideIcon="${hideIcon}"/> ><jsp:doBody/></a>