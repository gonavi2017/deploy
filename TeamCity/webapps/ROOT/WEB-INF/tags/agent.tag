<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="agent" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildAgent"
  %><%@attribute name="showRunningStatus" required="false" type="java.lang.Boolean"
  %><%@attribute name="doNotShowPoolInfo" required="false" type="java.lang.Boolean"
  %><%@attribute name="showCommentsAsIcon" required="false" type="java.lang.Boolean"
  %><bs:agentDetailsFullLink agent="${agent}" doNotShowPoolInfo="${doNotShowPoolInfo}" showRunningStatus="${showRunningStatus}" showCommentsAsIcon="${showCommentsAsIcon}"/>