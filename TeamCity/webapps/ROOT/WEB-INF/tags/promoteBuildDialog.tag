<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>

<bs:modalDialog formId="promoteBuild"
                title="Promote Build"
                action="" saveCommand="false;"
                closeCommand="BS.PromoteBuildDialog.close();">
  <forms:saving id="promoteBuildDialogContentProgress" className="progressRingInline"/>
  <div id="promoteBuildDialogContent"></div>
</bs:modalDialog>
