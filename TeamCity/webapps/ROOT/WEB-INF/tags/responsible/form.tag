<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    attribute name="buildType" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="currentUser" required="true" type="jetbrains.buildServer.users.User"
%><bs:executeOnce id="investigationForm"
    ><bs:modalDialog formId="investigationForm"
                     title="Responsibility"
                     action=""
                     closeCommand="BS.ResponsibilityDialog.close();"
                     saveCommand="BS.ResponsibilityDialog.submit()"
      ></bs:modalDialog
></bs:executeOnce>