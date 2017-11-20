<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
  %><%@attribute name="queuedBuild" required="false" type="jetbrains.buildServer.serverSide.SQueuedBuild"
  %><c:choose
  ><c:when test="${intprop:getBooleanOrTrue('teamcity.buildQueue.compatibleAgents.separatePageForQueuedBuild')}"
  ><bs:_viewQueued queuedBuild="${queuedBuild}" tab="queuedBuildCompatibilityTab"><jsp:doBody/></bs:_viewQueued
  ></c:when
  ><c:otherwise
  ><bs:buildTypeTabLink buildType="${queuedBuild.buildType}" title="Click to view compatible agents" tab="compatibilityList"><jsp:doBody/></bs:buildTypeTabLink
  ></c:otherwise
  ></c:choose>