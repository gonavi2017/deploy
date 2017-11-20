<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><c:url value='/ajax.html' var="actionUrl"
/><bs:modalDialog formId="stopBuildForm"
                title="TODO"
                action="${actionUrl}"
                closeCommand="BS.StopBuildDialog.close()"
                saveCommand="BS.StopBuildDialog.killBuild();">
  <textarea id="removeQueuedBuildComment" name="comment" rows="3" cols="46" class="commentTextArea"
            onfocus="if (this.value == this.defaultValue) this.value = ''" onblur="if (this.value == '') this.value='&lt;your comment here&gt;'">&lt;your comment here&gt;</textarea>
  <input type="hidden" name="kill" value=""/>
  <input type="hidden" name="operationKind" value="0"/>

  <div id="moreToStop">
    Loading related builds...
    <forms:saving id="moreToStopLoader" savingTitle="Loading related builds to stop..." className="progressRingInline"/>
  </div>
  <div id="moreToStopFragment" class="custom-scroll"></div>

  <div id="moreToStopRetryNotice" class="icon_before icon16 attentionComment" style="display: none">The stop command has already been sent to the build. This will re-send stop command</div>

  <div class="popupSaveButtonsBlock">
    <forms:submit name="submit" label="Stop" id="submitRemoveQueuedBuild"/>
    <forms:cancel onclick="BS.StopBuildDialog.close()" id="cancelRemoveQueuedBuild"/>
    <forms:saving id="stopBuildIndicator"/>
  </div>
</bs:modalDialog>