<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="modification" type="jetbrains.buildServer.vcs.SVcsModification" scope="request"/>
<jsp:useBean id="buildTypeId" type="java.lang.String" scope="request"/>
<jsp:useBean id="changeStatus" scope="request" type="jetbrains.buildServer.vcs.ChangeStatus"/>


<c:set var="refreshUrl"><bs:vcsModificationUrl change="${modification}"
                                               buildTypeId="${buildTypeId}"
                                               extension="${extensionTab}"/></c:set>
<bs:refreshable containerId="buildTypesContainerId" pageUrl="${refreshUrl}"
                useJsp="viewModificationBuildTypes.jsp">

  <%@ include file="/viewModificationBuildTypes.jsp" %>

</bs:refreshable>
