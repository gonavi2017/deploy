<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="projectId" required="true" type="java.lang.String" description="project external id"

%><bs:popupControl
    showPopupCommand="BS.ShowBuildTypesPopup.showPopup(this, '${projectId}');"
    hidePopupCommand="BS.ShowBuildTypesPopup.hidePopup(300);"
    stopHidingPopupCommand="BS.ChangesPopup.stopHidingPopup();"
    controlId="vis_${projectId}"><jsp:doBody/></bs:popupControl>