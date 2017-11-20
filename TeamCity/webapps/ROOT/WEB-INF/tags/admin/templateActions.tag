<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@attribute name="template" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" required="true"
  %><%@attribute name="editableProjects" required="true" type="java.util.Collection"
  %><bs:actionsPopup controlId="tplActions${template.id}"
                     popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
  <jsp:attribute name="content">
    <c:set var="numUsages" value="${template.numberOfUsages}"/>
    <div>
      <ul class="menuList">
        <l:li>
          <a href="#" title="Copy template" onclick="return BS.CopyTemplateForm.showDialog('${template.externalId}');">Copy template...</a>
        </l:li>
        <c:if test="${not template.readOnly}">
          <c:if test="${fn:length(editableProjects) > 1}">
            <l:li>
              <admin:moveBuildTypeTemplateLink sourceTemplate="${template}">Move template...</admin:moveBuildTypeTemplateLink>
            </l:li>
          </c:if>
          <l:li>
            <c:choose>
              <c:when test="${numUsages > 0}"><a href="#" onclick="alert('This template is used in ${numUsages} build configuration<bs:s val="${numUsages}"/>.\nBefore deleting this template you need to remove references to it from these build configurations.'); return false">Delete template...</a></c:when>
              <c:otherwise><a href="#" onclick="BS.AdminActions.deleteBuildTypeTemplate('${template.id}'); return false">Delete template...</a></c:otherwise>
            </c:choose>
          </l:li>
        </c:if>
      </ul>
    </div>
  </jsp:attribute>
  <jsp:body></jsp:body>
</bs:actionsPopup>
