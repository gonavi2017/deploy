<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags" %>
<bs:modalDialog formId="muteTestsForm"
                title="Mute test"
                action="#"
                saveCommand="BS.BulkInvestigateDialog.submit();"
                closeCommand="BS.BulkInvestigateDialog.close();">
  <div id="mute-dialog-container"></div>
  <div><forms:saving id="mute-dialog-progress" className="progressRingInline"/></div>
</bs:modalDialog>

<bs:modalDialog formId="errorForm"
                title=""
                action="#"
                saveCommand="BS.ErrorDialog.close();"
                closeCommand="BS.ErrorDialog.close();">
</bs:modalDialog>

<bs:dialog dialogId="shutdownDialog"
           title="Server communication failure"
           titleId="shutdownDialogTitle"
           closeCommand="BS.ServerUnavailableModalDialog.close()">
  <strong id="shutdownDetails">Server is unavailable</strong>
  <p id="onCommunicationFailure">Server stopped or communication with the server is not possible due to network failure.</p>
  <p id="onServerShutdown">Server shutdown started.</p>
  <p id="onAuthFailure">Please relogin to continue your work.</p>
</bs:dialog>

<c:url var="actionUrl" value="/runCustomBuild.html"/>
<bs:modalDialog formId="runBuild"
                title="Run Custom Build"
                action="${actionUrl}"
                dialogClass="editTagsDialog"
                closeCommand="BS.RunBuildDialog.close()"
                saveCommand="BS.RunBuildDialog.submit()">
</bs:modalDialog>

<bs:stopBuildDialog/>

<resp:form buildType="${null}" currentUser="${currentUser}" />

<tags:editTagsForm/>

<bs:modalDialog formId="abstractLoading"
                title="Loading..."
                action="#"
                closeCommand="BS.LoadingDialog.close();"
                saveCommand="BS.LoadingDialog.close()">

  <forms:saving id="abstractProgress" className="progressRingInline"/>
</bs:modalDialog>

<bs:dialog dialogId="confirmDialog" closeCommand="BS.confirmDialog.doCancelAction();" title="Are you sure?" dialogClass="modalDialog_small">
  <div class="confirmDialog__content"></div>
  <div class="popupSaveButtonsBlock">
    <forms:submit label="OK" onclick="BS.confirmDialog.doAction();"/>
    <forms:cancel onclick="BS.confirmDialog.doCancelAction();"/>
  </div>
</bs:dialog>