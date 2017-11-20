<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="projectBuildProblemsBean" type="jetbrains.buildServer.web.problems.ProjectBuildProblemsBean" required="true" %>
<%@ attribute name="inlineMuteInfo" type="java.lang.Boolean" required="false" %>
<%@ attribute name="inlineResponsibiltyInfo" type="java.lang.Boolean" required="false" %>
<problems:buildProblemGroup problemNumber="${projectBuildProblemsBean.buildProblemsNumber}">
  <jsp:attribute name="header"
    ><bs:projectOrBuildTypeIcon className="problemProject"><bs:projectLink project="${projectBuildProblemsBean.project}"
    /></bs:projectOrBuildTypeIcon
  ></jsp:attribute>
  <jsp:attribute name="body">
    <c:set var="groupSeparator" value="${fn:length(projectBuildProblemsBean.subProjectBuildProblemBeans)>0 ? 'outer' : 'inner'}"/>
    <c:forEach items="${projectBuildProblemsBean.buildTypeBuildProblems}" var="bean">
      <problems:buildProblemGroup problemNumber="${bean.problemsNumber}" classes="problemBuildTypeHeader ${groupSeparator}">
        <jsp:attribute name="header"><bs:projectOrBuildTypeIcon className="problemBuildType"><bs:buildTypeLink buildType="${bean.buildType}"/></bs:projectOrBuildTypeIcon></jsp:attribute>
        <jsp:attribute name="body">
          <problems:buildProblemList buildProblemsBean="${bean}"
                                     compactMode="false" showPopup="true" showLink="false">
            <problems:additonalInfo compactMode="false" inlineMuteInfo="${inlineMuteInfo}" buildProblem="${buildProblem}"
                                                                           inlineResponsibilty="${inlineResponsibiltyInfo}"
                                                                           currentBuildProblemBean="${bean}"/>
          </problems:buildProblemList>
        </jsp:attribute>
      </problems:buildProblemGroup>
    </c:forEach>
    <c:forEach items="${projectBuildProblemsBean.subProjectBuildProblemBeans}" var="subProjectBean">
      <problems:buildProblemGroupByProject projectBuildProblemsBean="${subProjectBean}"/>
    </c:forEach>
  </jsp:attribute>
</problems:buildProblemGroup>

