<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<bs:modalDialog formId="duplicateVcsRoots" title="Duplicate VCS Roots Found" action="" closeCommand="BS.DuplicateVcsRootsDialog.close()" saveCommand="">
  <div id="duplicateVcsRootsContainer"></div>

  <div class="popupSaveButtonsBlock">
    <input class="btn" type="button" id="submitAnywayButton" value="Create Duplicate VCS Root" onclick="BS.DuplicateVcsRootsDialog._submitAnyway();"/>
    <forms:cancel onclick="BS.DuplicateVcsRootsDialog.close()" showdiscardchangesmessage="false"/>
  </div>
</bs:modalDialog>
