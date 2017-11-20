<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bl" uri="/WEB-INF/buildLogTree.tld"
%><jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><jsp:useBean id="messagesIterator" type="jetbrains.buildServer.serverSide.buildLog.InsideBlockMessageIterator" scope="request"
/>
<c:set var="enabledFilter" value="${param['filter'] eq null ? 'all' : param['filter']}"/>

<bl:buildLogTreeTag  messagesIterator="${messagesIterator}"
                     build = "${buildData}"
                     filter = "${enabledFilter}"
                     expand = "${param.expand}"
                     hideBlocks = "${param.hideBlocks}"
                     consoleStyle = "${param.consoleStyle}"
                     baseClasses="${param.baseClasses}"
                     baseLevel="${param.baseLevel}"
                     id="${param.id}"
                     sizeLimit="${param.sizeLimit}"
                     state="${param.state}"
                     additionalSizeWarningArg="{type: 'block', id: '${param.id}', baseLevel: '${param.baseLevel}'}"
/>
