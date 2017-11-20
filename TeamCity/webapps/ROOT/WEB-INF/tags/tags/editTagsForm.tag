<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><c:set var="formId" value="editBuildTagsForm"/>
<c:url value='/ajax.html' var="action"/>
<bs:modalDialog formId="${formId}"
                title="Edit tags"
                action="${action}"
                closeCommand="BS.Tags.close()"
                saveCommand="BS.Tags.submitTags()"
                dialogClass="editTagsDialog">
  <bs:_tagsEditingControl formId="${formId}" type="EditTags"/>
  <bs:_applyToAllBuildsCheckbox prefix="tag"/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Save"/>
    <forms:cancel onclick="BS.Tags.close()"/>
    <input type="hidden" value="" name="editTagsForPromotion"/>
    <forms:saving id="savingTags"/>
  </div>
</bs:modalDialog>
