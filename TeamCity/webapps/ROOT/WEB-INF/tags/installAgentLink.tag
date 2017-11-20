<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="buildAgentInstallerLink" value="/update/agentInstaller.exe"/>
<c:url var="buildAgentZipLink" value="/update/buildAgent.zip"/>
<p>Install build agent via <strong><a href="${buildAgentInstallerLink}">Windows installer</a></strong></p>
<p>Install build agent manually <strong><a href="${buildAgentZipLink}">download zip file</a></strong></p>