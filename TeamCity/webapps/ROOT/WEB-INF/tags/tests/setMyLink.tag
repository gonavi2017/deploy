<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
    %><%@ attribute name="buildData" type="jetbrains.buildServer.serverSide.SBuild" 
    %><%@ attribute name="testsForm" type="jetbrains.buildServer.controllers.viewLog.TestsTabForm" %>
<tt:setSelfLink buildData="${buildData}"/>
<%--@elvariable id="selfLink" type="java.lang.String"--%>
<c:url var="myLink" value="${selfLink}" scope="request">
  <c:param name="order" value="${testsForm.order}"/>
  <c:param name="recordsPerPage" value="${testsForm.recordsPerPage}"/>
  <c:param name="filterText" value="${testsForm.filterText}"/>
  <c:param name="status" value="${testsForm.status}"/>
  <c:param name="currentGroup" value="${testsForm.currentGroup}"/>
  <c:param name="scope" value="${testsForm.scope}"/>
  <c:param name="pager.currentPage" value="${testsForm.pager.currentPage}"/>
</c:url>
