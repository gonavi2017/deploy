<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%>
<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%>
<bs:dialog dialogId="valuePopup" dialogClass="modalDialog_large" title="" titleId="valuePopupTitle" closeCommand="BS.BuildTypeSettingsPopup.closeMultilineValuePopup()">
  <textarea id="valueContainer" readonly="true" wrap="off"></textarea>
</bs:dialog>
