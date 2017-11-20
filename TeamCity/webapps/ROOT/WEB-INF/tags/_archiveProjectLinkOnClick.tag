<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"%>
<%@ attribute name="archive" required="true" type="java.lang.Boolean"%>BS.ArchiveProjectDialog.showArchiveProjectDialog('${project.externalId}', ${archive});
