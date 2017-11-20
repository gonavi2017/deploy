<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    attribute name="muteBean" type="jetbrains.buildServer.controllers.investigate.BulkMuteBean" required="true"

%><c:forEach items="${muteBean.buildTypes}" var="buildType">
  <div>
    <jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="page"/>
    <forms:checkbox name="mute-in-bt-${buildType.buildTypeId}"
                    checked="<%=muteBean.isChecked(buildType)%>"/>
    <label for="mute-in-bt-${buildType.buildTypeId}"><c:out value="${buildType.name}"/></label>
  </div>
</c:forEach>