<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="mod" required="true" type="jetbrains.buildServer.vcs.SVcsModification"
    %><%@ attribute name="noTitle" required="false" type="java.lang.Boolean"
    %><bs:personalChangesIcon myChanges="<%= mod.isCommitter(SessionUser.getUser(request))%>" noTitle="${noTitle}"/>