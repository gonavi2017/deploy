<%@ include file="include-internal.jsp" %>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<jsp:useBean id="changeLogBean" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" scope="request"/>
<%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><et:subscribeOnBuildTypeEvents buildTypeId="${buildType.buildTypeId}">
    <jsp:attribute name="eventNames">
      BUILD_STARTED
      BUILD_CHANGES_LOADED
      BUILD_FINISHED
      BUILD_INTERRUPTED
      BUILD_TYPE_ADDED_TO_QUEUE
      BUILD_TYPE_REMOVED_FROM_QUEUE
      CHANGE_ADDED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.BuildType.updateView();
    </jsp:attribute>
</et:subscribeOnBuildTypeEvents>
<bs:changesList
     changeLog="${changeLogBean}"
     url="viewType.html?buildTypeId=${buildType.externalId}&tab=buildTypeChangeLog"
     filterUpdateUrl="buildTypeChangeLogTab.html?buildTypeId=${buildType.externalId}"
     projectId="${buildType.projectExternalId}"
/>