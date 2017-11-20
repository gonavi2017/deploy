<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="checked" required="false"
%><tr>
  <td><forms:checkbox name="investigation-bt"
                      id="tr_${buildType.buildTypeId}"
                      value="${buildType.buildTypeId}"
                      checked="${checked != null}"
                      onclick="BS.ResponsibilityDialog.setButtonsEnabling();"/></td>
  <resp:_buildTypeWithDetails buildType="${buildType}" labelFor="tr_${buildType.buildTypeId}"/>
</tr>