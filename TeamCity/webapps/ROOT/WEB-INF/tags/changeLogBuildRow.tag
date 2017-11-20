<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="showBuildTypeInBuilds" required="true" type="java.lang.Boolean" %><%@
    attribute name="showBranch" required="true" type="java.lang.Boolean"%><%@
    attribute name="noBranchLink" required="false" type="java.lang.Boolean"
  %><c:set var="pendingBuild" value="${build.buildId < 0}"/><table class="changeLogBuildRow">
  <tr>
    <c:if test="${showBuildTypeInBuilds}">
      <td class="bt">
        <bs:buildTypeLinkFull buildType="${build.buildType}" popupMode="true"/>
      </td>
    </c:if>
    <c:if test="${pendingBuild}">
      <bs:buildRow build="${build}"  showBranchName="${showBranch}" noLinkBranchForBranchName="${noBranchLink}"/>
      <td class="startDate" colspan="5">Pending changes</td>
    </c:if>
    <c:if test="${not pendingBuild}">
      <bs:buildRow build="${build}"
                   showBuildNumber="true"
                   showBranchName="${showBranch}"
                   showStatus="true"
                   outOfChangesSequence="${build.outOfChangesSequence}"
                   noLinkBranchForBranchName="${noBranchLink}"/>
      <td class="tags" style="text-align: right;">
        <c:set var="tags" value="${build.tags}"/>
        <c:if test="${fn:length(tags) > 0}"
          >Tags: <bs:trimWithTooltip maxlength="50"
          ><c:forEach var="t" items="${tags}" varStatus="pos"><c:out value="${t}"/><c:if test="${not pos.last}">, </c:if></c:forEach
          ></bs:trimWithTooltip></c:if>
      </td>
      <td class="pinStatus">
        <c:if test="${build.pinned}"><bs:pinImg build="${build}"/></c:if>
      </td>
      <td class="startDate">
        <bs:date value="${build.startDate}"/>
      </td>
    </c:if>
  </tr>
</table>