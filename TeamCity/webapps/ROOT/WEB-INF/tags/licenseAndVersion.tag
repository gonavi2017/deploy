<%@ tag import="jetbrains.buildServer.serverSide.LicenseMode"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="licensingPolicy" type="jetbrains.buildServer.serverSide.LicensingPolicy" required="true"
%><bs:doLicenseAndVersion licenseMode="<%=new LicenseMode(licensingPolicy)%>"/>