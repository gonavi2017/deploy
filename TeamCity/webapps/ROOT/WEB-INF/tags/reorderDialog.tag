<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@
    attribute name="dialogId" required="true" type="java.lang.String" %><%@
    attribute name="dialogTitle" required="true" type="java.lang.String" %><%@
    attribute name="dialogClass" required="false" type="java.lang.String" %><%@
    attribute name="sortables" required="true" fragment="true" %><%@
    attribute name="messageBody" required="false" fragment="true" %><%@
    attribute name="actionsExtension" required="false" fragment="true" %>
<bs:dialog dialogId="${dialogId}" title="Reorder ${dialogTitle}" closeCommand="$j('#${dialogId}').trigger('closeDialog')"
           dialogClass="${dialogClass} reorderDialog" titleId="${dialogId}Title">
  <form id="${dialogId}Form">
    <div>Drag and drop <c:out value="${fn:toLowerCase(dialogTitle)}"/> to change the current order.</div>
    <jsp:invoke fragment="messageBody"/>

    <div class="messagesHolder">
      <div id="savingData"><i class="icon-refresh icon-spin"></i> Saving...</div>
      <div id="dataSaved"></div>
    </div>

    <div id="sortableList" class="custom-scroll">
      <jsp:invoke fragment="sortables"/>
    </div>

    <div class="popupSaveButtonsBlock">
      <jsp:invoke fragment="actionsExtension"/><%-- is floated to the right--%>
      <forms:submit type="button" label="Apply" id="saveOrderButton"/>
      <forms:cancel id="cancelButton"/>
      <forms:saving id="saveOrderProgress"/>
    </div>
  </form>
</bs:dialog>