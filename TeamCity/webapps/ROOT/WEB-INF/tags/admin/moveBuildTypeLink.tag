<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<%@ attribute name="sourceBuildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %>

<a href="#" title="Move build configuration"
   onclick="return BS.MoveBuildTypeForm.showDialog('${sourceBuildType.externalId}');"><jsp:doBody/></a>
