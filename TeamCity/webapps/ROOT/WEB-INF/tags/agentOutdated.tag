<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="agent" type="jetbrains.buildServer.serverSide.SBuildAgent" required="true"
  %><c:if test="${agent.outdated or agent.pluginsOutdated }"
  ><c:set var="outdatedText"
  ><c:if test="${agent.outdated}"
  >The agent is outdated. Current version is <strong>${serverTC.agentBuildNumber}</strong>, while <strong><c:out value="${agent.name}"/></strong> version is still <strong><c:out value="${agent.version}"/></strong>.</c:if
  ><c:if test="${not agent.outdated and agent.pluginsOutdated}"
  >Some plugins on the agent are out of date.</c:if
  ><c:if test="${agent.upgrading}"
  ><br/>Upgrade process is scheduled to this agent. New builds will not start on this agent until it upgrades.</c:if
  ></c:set><span class="icon icon16 yellowTriangle agentVersion" <bs:tooltipAttrs text="${outdatedText}"/> ></span></c:if>