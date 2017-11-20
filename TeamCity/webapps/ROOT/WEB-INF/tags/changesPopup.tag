<%@ tag import="jetbrains.buildServer.web.functions.change.ChangeFunctions" %>
<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="buildPromotion" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildPromotionEx"
  %><%@ attribute name="highlightIfCommitter" required="false" type="java.lang.Boolean"
  %><%@ attribute name="containsUserChanges" required="false" type="java.lang.Boolean"
  %><%
  boolean highlight = false;
  if (highlightIfCommitter == null || highlightIfCommitter) {
    if (containsUserChanges != null) {//highlight already calculated by the caller
      highlight = containsUserChanges;
    } else {
      highlight = ChangeFunctions.containsUserChanges(buildPromotion, SessionUser.getUser(request));
    }
  }
  jspContext.setAttribute("highlightChanges", highlight);
%><bs:popupControl 
    clazz="${highlightChanges ? 'highlightChanges': ''}"
    showPopupCommand="BS.ChangesPopup.showBuildChangesPopup(this, ${buildPromotion.id});"
    hidePopupCommand="BS.ChangesPopup.hidePopup();"
    stopHidingPopupCommand="BS.ChangesPopup.stopHidingPopup();"
    controlId="changes:${buildPromotion.id}"><jsp:doBody/></bs:popupControl>