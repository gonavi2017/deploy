<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
  %><%@attribute name="editableProjects" required="true" type="java.util.Collection"
  %><%@attribute name="autoSetupPopup" required="false" type="java.lang.Boolean"
  %><c:if test="${empty autoSetupPopup}"><c:set var="autoSetupPopup" value="${true}"/></c:if>
<bs:actionsPopup controlId="btActions${buildType.buildTypeId}"
                 popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'"
                 autoSetupPopup="${autoSetupPopup}">
  <jsp:attribute name="content">
    <div>
      <ul class="menuList">
        <c:set var="showCopyBuildTypeLink" value="${serverSummary.enterpriseMode or serverSummary.buildConfigurationsLeft > 0}"/>
        <c:if test="${showCopyBuildTypeLink}">
          <l:li>
            <a href="#" title="Copy build configuration"
               onclick="return BS.CopyBuildTypeForm.showDialog('${buildType.externalId}');">Copy build configuration...</a>
          </l:li>
        </c:if>
        <c:if test="${not showCopyBuildTypeLink}">
          <l:li>
            <span class="commentText" title="Cannot copy due to limit for number of build configurations">copy</span>
          </l:li>
        </c:if>
        <c:if test="${not buildType.readOnly}">
          <c:if test="${fn:length(editableProjects) > 1}">
            <l:li>
              <admin:moveBuildTypeLink sourceBuildType="${buildType}">Move build configuration...</admin:moveBuildTypeLink>
            </l:li>
          </c:if>
          <l:li>
            <admin:deleteBuildTypeLink buildTypeId="${buildType.buildTypeId}">Delete build configuration...</admin:deleteBuildTypeLink>
          </l:li>
        </c:if>
      </ul>
    </div>

  </jsp:attribute>
  <jsp:body></jsp:body>
</bs:actionsPopup>
