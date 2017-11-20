<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    attribute name="onBuildPage" required="true" type="java.lang.Boolean" %><%@
    attribute name="build" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="buildType"  required="true" type="jetbrains.buildServer.serverSide.SBuildType"

%><c:url value='/ajax.html' var="actionUrl"
/><bs:modalDialog formId="pinBuildForm"
                title="Pin build"
                action="${actionUrl}"
                closeCommand="BS.PinBuildDialog.close();"
                saveCommand="BS.PinBuildDialog.submit()"
                dialogClass="editTagsDialog">
  <textarea name="pinComment" rows="5" cols="46" class="commentTextArea"
            onfocus="if (this.value == this.defaultValue) this.value = ''" onblur="if (this.value == '') this.value='&lt;your comment here&gt;'">&lt;your comment here&gt;</textarea>
  <input type="hidden" name="pin" value=""/>
  <input type="hidden" name="buildId" value=""/>
  <input type="hidden" name="onBuildPage" value="${onBuildPage}"/>
  <c:if test="${!onBuildPage}">
    <input type="hidden" name="savePinnedBuild" value="true"/>
  </c:if>

  <bs:_tagsEditingControl label="Tags" formId="pinBuildForm" type="PinBuild"/>

  <bs:_applyToAllBuildsCheckbox prefix="pin"/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Pin" id="PinSubmitButton"/>
    <forms:cancel onclick="BS.PinBuildDialog.close()"/>
    <forms:saving id="pinBuildDialogSaving"/>
  </div>
</bs:modalDialog>