<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<c:url value='/action.html' var="actionUrl"/>

<bs:modalDialog formId="pauseBuildTypeForm"
                title="Pause build configuration"
                action="${actionUrl}"
                closeCommand="BS.PauseBuildTypeDialog.close();"
                saveCommand="BS.PauseBuildTypeDialog.submit()">

  <textarea name="pauseComment"
            rows="5" cols="46" class="commentTextArea"
            onfocus="if (this.value == this.defaultValue) this.value = ''"
            onblur="if (this.value == '') this.value='&lt;your comment here&gt;'">&lt;your comment here&gt;</textarea>
  <input type="hidden" name="pauseBuildType" value=""/>
  <input type="hidden" name="pause" value=""/>
  <authz:authorize allPermissions="CANCEL_BUILD">
    <div>
      <input type="checkbox" name="removeFromQueue" id="removeFromQueue"/>
      <label for="removeFromQueue" id="lbl_removeFromQueue">Cancel already queued builds</label>
    </div>
  </authz:authorize>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Pause" id="PauseSubmitButton"/>
    <forms:cancel onclick="BS.PauseBuildTypeDialog.close()"/>
    <forms:saving id="pauseProgressIcon"/>
  </div>
</bs:modalDialog>