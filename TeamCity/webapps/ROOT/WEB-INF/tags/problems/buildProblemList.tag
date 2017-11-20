<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %>

<%@ attribute name="buildProblemsBean" type="jetbrains.buildServer.web.problems.BuildProblemsBean" required="true" %>
<%@ attribute name="compactMode" type="java.lang.Boolean" required="true" %>
<%@ attribute name="showPopup" type="java.lang.Boolean" required="true" %>
<%@ attribute name="showLink" type="java.lang.Boolean" required="true" %>
<%@ attribute name="showExpandCollapseActions" type="java.lang.Boolean" required="false" %>
<%@ variable name-given="buildProblem" variable-class="jetbrains.buildServer.serverSide.problems.BuildProblem" scope="NESTED" %>

<c:set var="style" value="${param['style']}"/>
<c:choose>
  <c:when test="${empty style}">
    <c:set var="additionalClasses" value="heavy"/>
  </c:when>
  <c:otherwise>
    <c:set var="additionalClasses" value="${style}"/>
  </c:otherwise>
</c:choose>

<c:set var="bpListId"><bs:id/></c:set>
<div class="tcTable bpl ${additionalClasses}" id="${bpListId}">
  <div>
    <problems:buildProblemExpandCollapse showExpandCollapseActions="${showExpandCollapseActions && buildProblemsBean.multipleExpandApplicable}">
      <c:set var="groupsByType" value="${buildProblemsBean.buildProblemGroupsByType}"/>
      <c:forEach items="${groupsByType}" var="groupByType">
        <c:set var="bpType" value="${groupByType.key}"/>
        <c:set var="bps" value="${groupByType.value}"/>
        <c:set var="noGroupExpand" value="${!buildProblemsBean.multipleExpandApplicable && fn:length(bps)==1}"/>
        <c:choose>
          <c:when test="${additionalClasses=='light' && noGroupExpand}">
            <c:set var="buildProblem" value="${bps[0]}"/>
            <problems:buildProblemRow buildProblemsBean="${buildProblemsBean}" buildProblemType="${bpType}"
                                      buildProblemListId="${bpListId}" compactMode="${compactMode}" showPopup="${showPopup}" showLink="${showLink}" buildProblem="${buildProblem}">
              <jsp:doBody/>
            </problems:buildProblemRow>
          </c:when>
          <c:otherwise>
            <problems:buildProblemGroup problemNumber="${fn:length(bps)}">
              <jsp:attribute name="header"><span class="problemType">${bpType}</span></jsp:attribute>
              <jsp:attribute name="body">
                <c:forEach items="${bps}" var="buildProblem">
                  <problems:buildProblemRow buildProblemsBean="${buildProblemsBean}"
                                            buildProblemListId="${bpListId}" compactMode="${compactMode}" showPopup="${showPopup}" showLink="${showLink}" buildProblem="${buildProblem}">
                    <jsp:doBody/>
                  </problems:buildProblemRow>
                </c:forEach>
              </jsp:attribute>
            </problems:buildProblemGroup>
          </c:otherwise>
        </c:choose>

      </c:forEach>
    </problems:buildProblemExpandCollapse>
  </div>
</div>
<c:set var="requestProblemId" value='<%=request.getParameter("problemId")%>'/>
<c:if test="${not empty requestProblemId}">
  <script type="text/javascript">
    BS.BuildProblems.focusBuildProblem('${requestProblemId}');
  </script>
</c:if>