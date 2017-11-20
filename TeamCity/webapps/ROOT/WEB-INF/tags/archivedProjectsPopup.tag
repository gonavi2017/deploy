<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    attribute name="archivedProjects" required="true" type="java.util.List"

%><c:set var="controlId" value="archivedProjects"
/><c:url value="/allArchivedProjects.html" var="popupUrl"
/><c:set var="popup_options" value="shift: {x: 30, y: -5}, url: '${popupUrl}'"/>

<%-- Unfortunately we can't use SimplePopup here, because the content DIV must be
     outside of 'allProjectsPopup' div. So we emulate it here. --%>
<script type="text/javascript">
  BS.${controlId}_handle = new BS.Popup("${controlId}Content",{${popup_options}});
</script>
<div class="archivedPopup">
  <bs:popupControl showPopupCommand="BS.${controlId}_handle.showPopupNearElement(this)"
                   hidePopupCommand="BS.${controlId}_handle.hidePopup(300)"
                   stopHidingPopupCommand="BS.${controlId}_handle.stopHidingPopup()"
                   controlId="${controlId}">
    and ${fn:length(archivedProjects)}
    <c:if test="${afn:adminSpaceAvailable()}">
      <a title="View archived projects list" href="<c:url value="/admin/admin.html?includeArchived=true"/>">
        archived project<bs:s val="${fn:length(archivedProjects)}"/>
      </a>
    </c:if>
    <c:if test="${not afn:adminSpaceAvailable()}">
      archived project<bs:s val="${fn:length(archivedProjects)}"/>
    </c:if>
  </bs:popupControl>
</div>