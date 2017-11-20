<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<c:url value='/admin/action.html' var="actionUrl"/>

<bs:modalDialog formId="archiveProjectForm"
                title="Archive project"
                action="${actionUrl}"
                dialogClass="archiveDialog"
                closeCommand="BS.ArchiveProjectDialog.close();"
                saveCommand="BS.ArchiveProjectDialog.submit()"
    >
  <div>
    <p id="message">
    </p>
  </div>
  <input type="hidden" name="projectId" value=""/>
  <input type="hidden" name="archiveAction" value=""/>
  <authz:authorize allPermissions="CANCEL_BUILD">
    <div id="removeFromQueueDiv">
      <input type="checkbox" name="removeFromQueue" id="removeFromQueue"/>
      <label for="removeFromQueue" >Cancel already queued builds</label>
    </div>
  </authz:authorize>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Archive" id="ArchiveSubmitButton"/>
    <forms:cancel onclick="BS.ArchiveProjectDialog.close()"/>
    <forms:saving id="archiveProgressIcon"/>
  </div>
</bs:modalDialog>