<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@

    attribute name="title" type="java.lang.String" required="true" %><%@
    attribute name="id" type="java.lang.String" required="true" %><%@
    attribute name="promotions" type="java.util.List" required="true" %><%@
    attribute name="collapsed" type="java.lang.Boolean" required="false"

%><bs:_collapsibleBlock title="${title}" id="${id}" collapsedByDefault="${not empty collapsed ? collapsed : false}"
                        tag="div" headerStyle="margin-top: 13px">
  <table class="modificationBuilds">
    <c:forEach var="promotion" items="${promotions}" varStatus="pos">
      <%--@elvariable id="promotion" type="jetbrains.buildServer.serverSide.BuildPromotion"--%>
      <c:set var="buildType" value="${promotion.buildType}"/>
      <c:set var="build" value="${promotion.associatedBuild}"/>
      <c:set var="queuedDependencyBuild" value="${promotion.queuedBuild}"/>
      <c:if test="${not empty buildType}">
        <tr class="buildTypeProblem">
          <td class="buildTypeName">
            <bs:responsibleIcon responsibility="${buildType.responsibilityInfo}" buildTypeRef="${buildType}"/>
            <bs:buildTypeLinkFull buildType="${buildType}" fullProjectPath="true" popupMode="no_self"/>
          </td>
          <c:choose>
            <c:when test="${not empty build}">
              <c:choose>
                <c:when test="${build.finished}">
                  <bs:buildRow build="${build}" showBranchName="true" showBuildNumber="true" showStatus="true" showChanges="true" showStartDate="true" showArtifacts="true"/>
                  <td class="finishedBuildDuration"><bs:printTime time="${build.duration}" showIfNotPositiveTime="&lt; 1s"/></td>
                </c:when>
                <c:otherwise>
                  <bs:buildRow build="${build}" showBranchName="true" showBuildNumber="true" showStatus="true" showChanges="true" showProgress="true"  showArtifacts="true" showStop="true"/>
                </c:otherwise>
              </c:choose>
            </c:when>
            <c:when test="${not empty queuedDependencyBuild}">
              <bs:queuedBuild queuedBuild="${queuedDependencyBuild}"  estimateColspan="5" showNumber="true" showBranches="true"  hideIcon="false"/>
            </c:when>
            <c:otherwise>
              <td colspan="8"><i>Deleted build</i></td>
            </c:otherwise>
          </c:choose>
        </tr>
      </c:if>
    </c:forEach>
  </table>
</bs:_collapsibleBlock>