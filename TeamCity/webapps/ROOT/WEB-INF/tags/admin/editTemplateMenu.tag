<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="template" required="true" type="jetbrains.buildServer.serverSide.BuildTypeTemplate"
  %><%@attribute name="cameFromUrl" required="true" %>
<script type="text/javascript">
  <c:set var="cameFrom"><c:if test="${not empty cameFromUrl}">&cameFromUrl=${cameFromUrl}</c:if></c:set>
  BS['_EditSettings${template.id}'] = new BS.Popup('editTemplateSettingsPopup', {
    url: window['base_uri'] + '/showJsp.html?jspPath=/editTemplatePopup.jsp?templateId=${template.externalId}${cameFrom}',
    shift: {x: -241, y: 20},
    className: 'quickLinksMenuPopup'
  });
</script>
<bs:popupControl showPopupCommand="BS['_EditSettings${template.id}'].showPopupNearElement(this)"
                 hidePopupCommand="BS['_EditSettings${template.id}'].hidePopup();"
                 stopHidingPopupCommand="BS['_EditSettings${template.id}'].stopHidingPopup();"
                 controlId="editControl${template.id}">
  <admin:editTemplateLink templateId="${template.externalId}" cameFromUrl="${cameFromUrl}"
                           title="Edit build configuration template"><jsp:doBody/></admin:editTemplateLink></bs:popupControl>