<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild"
%>${build.pinned ? "Pinned" : "Unpinned"}