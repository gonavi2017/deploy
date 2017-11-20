<%@ tag import="jetbrains.buildServer.serverSide.BuildTypeEx" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%>
<%@ attribute name="historyForm" type="jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean"%>
<%@ attribute name="label"%>

<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"/>

<c:set var="userTags" value=""/>
<t:showPublicAndPrivateTags buildTypeId="${buildType.externalId}" label="${label}"
                            publicTags="${buildType.tags}" selectedPublicTag="${empty historyForm ? null : historyForm.tag}"
                            privateTags="<%=((BuildTypeEx)buildType).getTags(currentUser)%>"
                            selectedPrivateTag="${empty historyForm ? null : historyForm.privateTag}" hidePrivateTags="${false}"/>
<t:_buildTypeTags buildType="${buildType}"/>