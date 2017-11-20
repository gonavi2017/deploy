<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ attribute name="sourceTemplate" required="true" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" %>
<a href="#" title="Move build configuration"
   onclick="return BS.MoveTemplateForm.showDialog('${sourceTemplate.externalId}');"><jsp:doBody/></a>
