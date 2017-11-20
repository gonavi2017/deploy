<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="licenseMode" type="jetbrains.buildServer.serverSide.LicenseMode" required="true"
%><a target="_blank" href="https://www.jetbrains.com/teamcity/?fromServer">TeamCity <c:out value="${licenseMode.displayName}"
/></a><bs:version/><c:out value="${licenseMode.details}"/>