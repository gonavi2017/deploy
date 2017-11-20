<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="messageIterator" type="java.util.Iterator" scope="request"/>

<bs:buildLog buildPromotion="${build.buildPromotion}"
             messagesIterator="${messageIterator}"
             renderRunningTime="true"/>
