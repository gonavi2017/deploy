<%@include file="/include.jsp"
%><jsp:useBean id="buildData" scope="request" type="jetbrains.buildServer.serverSide.SBuild"
/><c:set var="bt" value="${buildData.buildType}"  />

<bs:buildTypeLinkFull buildType="${bt}"/>
<br />
Build: <bs:resultsLink build="${buildData}" noPopup="true" noTitle="true">
  <bs:buildNumber buildData="${buildData}"/>
  <bs:buildDataIcon buildData="${buildData}"/>
  ${buildData.statusDescriptor.text}
</bs:resultsLink>
<br/>
Duration on agent: <strong><bs:printTime time="${buildData.duration}" showIfNotPositiveTime="&lt; 1s"/></strong><br/>
(<bs:date value="${buildData.serverStartDate}" pattern="dd MMM yyyy HH:mm:ss"/>
-
<bs:date value="${buildData.finishDate}" pattern="dd MMM yyyy HH:mm:ss"/>)

