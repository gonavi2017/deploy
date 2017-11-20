<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@attribute name="authModule" required="true" type="jetbrains.buildServer.serverSide.auth.AuthModule"
%><c:out value="<%=authModule.getType().describeProperties(authModule.getProperties())%>"/>