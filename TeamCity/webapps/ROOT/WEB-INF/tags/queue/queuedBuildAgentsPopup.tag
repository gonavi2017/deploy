<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@attribute name="itemId" type="java.lang.String" required="true" %>
<%@attribute name="buildTypeId" type="java.lang.String" required="true" %>
<bs:popupControl showPopupCommand="BS.AgentInfoPopup.showAgentsPopup(this, '${itemId}', false)" hidePopupCommand="BS.AgentInfoPopup.hidePopup()" stopHidingPopupCommand="BS.AgentInfoPopup.stopHidingPopup()" controlId="agents_${buildTypeId}">
  <jsp:doBody/>
</bs:popupControl>
