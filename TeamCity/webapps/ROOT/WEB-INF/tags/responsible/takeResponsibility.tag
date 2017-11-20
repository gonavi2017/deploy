<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="currentUser" required="true" type="jetbrains.buildServer.users.User"

%><c:if test="${buildType.status.failed}"
  ><c:set var="name"><bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/></c:set
  ><span class="statusChangeLink-failed" id="takeResp:${buildType.buildTypeId}"
         onclick="return BS.ResponsibilityDialog.showDialog('${buildType.externalId}', '${name}')">
    Start investigation</span> of current problems in this build configuration (<c:out value="${buildType.name}"/>)
  <resp:form buildType="${buildType}" currentUser="${currentUser}"
/></c:if>