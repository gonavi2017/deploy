<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bl" uri="/WEB-INF/buildLogTree.tld" %>

<jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="messagesIterator" type="jetbrains.buildServer.serverSide.buildLog.LowLevelEventsAwareMessageIterator" scope="request"/>
<jsp:useBean id="expand" type="java.lang.String" scope="request"/>
<jsp:useBean id="hideBlocks" type="java.lang.String" scope="request"/>
<jsp:useBean id="consoleStyle" type="java.lang.String" scope="request"/>
<jsp:useBean id="tabID" type="java.lang.String" scope="request"/>
<jsp:useBean id="filters" type="java.util.Collection<jetbrains.buildServer.controllers.viewLog.tree.filters.TreeViewMessageFilter>" scope="request"/>

<c:set var="enabledFilter" value="${param['filter'] eq null ? 'all' : param['filter']}"/>

  <bl:buildLogTreeTag  messagesIterator="${messagesIterator}"
                       build = "${buildData}"
                       filter = "${enabledFilter}"
                       incremental = "false"
                       expand = "${expand}"
                       hideBlocks = "${hideBlocks}"
                       consoleStyle = "${consoleStyle}"
                       baseClasses="${param.baseClasses}"
                       baseLevel="${param.baseLevel}"
                       id="${param.id}"
                       sizeLimit="${param.sizeLimit}"
                       state="${param.state}"
  />
