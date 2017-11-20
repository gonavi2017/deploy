<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %>
<%@ attribute name="systemProblems" type="java.util.Collection"%>
<jsp:useBean id="systemProblems" type="java.util.Collection<jetbrains.buildServer.controllers.changes.ProblemBean>"/>
<%@ attribute name="projectId" type="java.lang.String" required="false" description="project internal id" %>

<div class="systemProblemsContainer">
<c:forEach items="${systemProblems}" var="problemBean">
  <%-- @elvariable id="problemBean" type="jetbrains.buildServer.controllers.changes.ProblemBean" --%>
  <c:if test="${not empty problemBean.problemWebSpecifics}">
    <div class="systemProblemHead">
    <c:set var="solutionLink">
      <c:choose>
        <c:when test="${not empty problemBean.problemWebSpecifics.solutionLink.title}">
          <c:set var="title" value="${problemBean.problemWebSpecifics.solutionLink.title}"/>
        </c:when>
        <c:otherwise>
          <c:set var="title" value="solve the problem"/>
        </c:otherwise>
      </c:choose>
      <c:url value='${problemBean.problemWebSpecifics.solutionLink.link}' var="link"/>
      <a href="${link}" style="float: right;">${title} &raquo;</a>
    </c:set>
    <c:choose>
      <c:when test="${problemBean.buildInternalError}">${solutionLink}</c:when>
      <c:otherwise>
        <authz:authorize projectId="${projectId}" allPermissions="EDIT_PROJECT">${solutionLink}</authz:authorize>
      </c:otherwise>
    </c:choose>
      
    <strong><c:out value="${problemBean.problemWebSpecifics.problemCaption}"/></strong>
    </div>
  </c:if>

  <div class="systemProblem">
    <span class="problemMessage mono"><l:br val="${problemBean.problemEntry.problem.description}" /></span>

    <authz:authorize projectId="${projectId}" allPermissions="EDIT_PROJECT">
      <c:set var="detailsId" value="details:${problemBean.problemEntry.id}"/>
      <c:if test="${not empty problemBean.detailsString}">
        <br/>
        <a href="#" onclick="
          $('${detailsId}').toggle();
          this.innerHTML = BS.Util.visible('${detailsId}') ? 'Hide stacktrace' : 'Show stacktrace &raquo;';
          return false;
        ">Show stacktrace &raquo;</a>
        <div id="${detailsId}" style="display: none;" class="problemDetails mono custom-scroll"><l:br val="${problemBean.detailsString}"/></div>
      </c:if>

    </authz:authorize>
  </div>

  <c:set var="firstProblem" value="${false}"/>
</c:forEach>
</div>
