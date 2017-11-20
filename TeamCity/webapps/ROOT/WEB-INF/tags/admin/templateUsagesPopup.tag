<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="templateId" required="true"
  %><%@attribute name="selectedStep" required="true"
  %><bs:popupControl showPopupCommand="BS.TemplateUsagesPopup.showPopup(this, '${templateId}', '${selectedStep}')" hidePopupCommand="BS.TemplateUsagesPopup.hidePopup()" stopHidingPopupCommand="BS.TemplateUsagesPopup.stopHidingPopup()" controlId="usages_${templateId}"><jsp:doBody/></bs:popupControl>