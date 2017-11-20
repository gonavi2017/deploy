<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SBuild" %>

<a class="changeBuildStatus" href="#"
   onclick="BS.ChangeBuildStatusDialog.showDialog('${build.buildId}', ${build.buildStatus.failed}, ${build.finished}); return false;"
    >Mark as ${build.buildStatus.failed ? 'successful' : 'failed'}...</a>

<bs:executeOnce id="changeBuildStatus">
  <c:url var="actionUrl" value="/ajax.html"/>
  <bs:modalDialog formId="changeBuildStatus"
                  title="todo"
                  action="${actionUrl}"
                  closeCommand="BS.ChangeBuildStatusDialog.close();"
                  saveCommand="BS.ChangeBuildStatusDialog.submit()">

    <label class="changeBuildStatus-reason">
      Reason: <layout:star/><br>
      <forms:textField name="comment" className="commentTextArea" expandable="true" noAutoComplete="true"/>
    </label>

    <div class="changeBuildStatus-errorText"></div>
    <div class="changeBuildStatus-warningText"></div>
    <div class="changeBuildStatus-notificationNote">Note: notifications about manual status change are not sent</div>

    <input type="hidden" name="status" value=""/>
    <input type="hidden" name="changeBuildStatus" value=""/>

    <div class="changeBuildStatus-why">
      <bs:help file="Changing+Build+Status+Manually"/>
    </div>
    <div class="popupSaveButtonsBlock">
      <forms:submit label="Change status" id="changeBuildStatusSubmitButton" onclick="return BS.ChangeBuildStatusDialog.submit();"/>
      <forms:cancel onclick="BS.ChangeBuildStatusDialog.close()"/>
      <forms:saving/>
    </div>

  </bs:modalDialog>
</bs:executeOnce>