<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<c:url value='/ajax.html' var="actionUrl"/>
<bs:modalDialog formId="buildCommentForm"
                title="Add build comment"
                action="${actionUrl}"
                closeCommand="BS.BuildCommentDialog.close();"
                saveCommand="BS.BuildCommentDialog.submit()">
  <textarea name="buildComment" rows="5" cols="46" class="commentTextArea"
            onfocus="if (this.value == this.defaultValue) this.value = ''" onblur="if (this.value == '') this.value='&lt;your comment here&gt;'">&lt;your comment here&gt;</textarea>
  <input type="hidden" name="promotionId" value=""/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Save comment" id="BuildCommentSubmitButton"/>
    <forms:cancel onclick="BS.BuildCommentDialog.close()"/>
    <forms:saving/>
  </div>
</bs:modalDialog>
