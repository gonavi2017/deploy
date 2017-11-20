<%@ page import="jetbrains.buildServer.maven.MavenConstants" %>
<%@ page import="jetbrains.buildServer.maven.metadata.MavenMetadataState" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="STATE_READY" value="<%=MavenMetadataState.READY.name()%>"/>
<c:set var="STATE_GENERATING" value="<%=MavenMetadataState.GENERATING.name()%>"/>
<c:set var="STATE_ERROR" value="<%=MavenMetadataState.ERROR.name()%>"/>
<c:set var="STATE_DISABLED" value="<%=MavenMetadataState.DISABLED.name()%>"/>
<c:set var="STATE_UNSPECIFIED" value="<%=MavenMetadataState.UNSPECIFIED.name()%>"/>
<c:set var="STATE_OUT_OF_DATE" value="<%=MavenMetadataState.OUT_OF_DATE.name()%>"/>

<c:set var="BUNDLED_M2_FULL_VERSION" value="2.2.1"/>
<c:set var="BUNDLED_M3_FULL_VERSION" value="3.0.5"/>
<c:set var="BUNDLED_M3_1_FULL_VERSION" value="3.1.1"/>
<c:set var="BUNDLED_M3_2_FULL_VERSION" value="3.2.5"/>
<c:set var="BUNDLED_M3_3_FULL_VERSION" value="3.3.9"/>

<c:set var="USER_SETTINGS_SELECTION_BY_PATH" value="<%=MavenConstants.USER_SETTINGS_SELECTION_BY_PATH%>"/>
<c:set var="USER_SETTINGS_SELECTION_DEFAULT" value="<%=MavenConstants.USER_SETTINGS_SELECTION_DEFAULT%>"/>
<c:set var="USER_SETTINGS_SELECTION" value="<%=MavenConstants.USER_SETTINGS_SELECTION%>"/>
<c:set var="USER_SETTINGS_PATH" value="<%=MavenConstants.USER_SETTINGS_PATH%>"/>

<c:set var="IS_INCREMENTAL" value="<%=MavenConstants.IS_INCREMENTAL%>"/>
<c:set var="USE_OWN_LOCAL_REPO" value="<%=MavenConstants.USE_OWN_LOCAL_REPO%>"/>

<c:set var="TOOL_SELECTION_PARAM" value="<%=MavenConstants.TOOL_SELECTION_PARAM%>"/>
<c:set var="TOOL_TYPE_NAME" value="<%=MavenConstants.TOOL_TYPE_NAME%>"/>

