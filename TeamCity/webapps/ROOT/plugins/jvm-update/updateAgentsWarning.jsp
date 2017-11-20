<%@ page import="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" %>
<%@include file="/include-internal.jsp" %>
<c:set var="inplaceMode" value="<%=HealthStatusItemDisplayMode.IN_PLACE%>"/>
<jsp:useBean id="showMode" type="jetbrains.buildServer.web.openapi.healthStatus.HealthStatusItemDisplayMode" scope="request"/>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<c:set var="agentsToUpgrade" value="${healthStatusItem.additionalData['agentsToUpgrade']}"/>
<c:set var="cloudAgentTypesToUpgrade" value="${healthStatusItem.additionalData['cloudAgentTypesToUpgrade']}"/>

<bs:linkCSS>
  /css/agentBlocks.css
</bs:linkCSS>

Some build agents run under Java less than 1.8, the recommended version. Earlier Java versions will not be supported in future TeamCity releases.
<c:if test="${showMode == inplaceMode}">
  <a href="#" id="updateAgentsJavaDetailsShowMore" onclick="$j('#updateAgentsJavaDetails').show(); $j('#updateAgentsJavaDetailsShowMore').hide(); $j('#updateAgentsJavaDetailsShowLess').show(); return false;">Show details</a>
  <a href="#" id="updateAgentsJavaDetailsShowLess" onclick="$j('#updateAgentsJavaDetails').hide(); $j('#updateAgentsJavaDetailsShowMore').show(); $j('#updateAgentsJavaDetailsShowLess').hide(); return false;" style="display: none">Hide details</a>
</c:if>

<div id="updateAgentsJavaDetails" style="margin-top: 1em; <c:if test="${showMode == inplaceMode}">display: none;</c:if>">
  <div>
    <c:if test="${not empty agentsToUpgrade}">
      Consider updating Java on these agents: <bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="UpgradingJavaonAgents"/>

      <c:set var="linesCount" value="0"/>
      <c:set var="poolsCount" value="0"/>
      <c:set var="hiddenItemsStarted" value="${false}"/>

      <div style="margin-top: 1em">
        <c:forEach items="${agentsToUpgrade}" var="entry">

          <%--Pool name--%>
          <c:if test="${healthStatusItem.additionalData['hasSeveralPools']}">
            <div class="${linesCount >= 10 ? 'hidden' : ''}">
              <bs:agentPoolLink agentPoolId="${entry.key.agentPoolId}" agentPoolName="${entry.key.name}" noLink="${true}"/>
            </div>
            <c:set var="linesCount" value="${linesCount + 1}"/>
            <c:set var="poolsCount" value="${poolsCount + 1}"/>
          </c:if>

          <%--Pool agents--%>
          <ul class="updateAgentsWarningHealthReport" style="margin-top: 0; margin-bottom: 0">
            <c:forEach items="${entry.value}" var="agentType">
              <li class="${linesCount >= 10 ? 'hidden' : ''}">
                <c:choose>
                  <c:when test="${agentType.realAgent != null}">
                    <bs:agentDetailsLink agent="${agentType.realAgent}" anchor="updateJavaDialog=show"/>
                  </c:when>
                  <c:otherwise>
                    <bs:agentDetailsLink agentType="${agentType}"/><span class="icon icon16 cloudIcon" title="Cloud Agent"></span>
                  </c:otherwise>
                </c:choose>
              </li>
              <c:set var="linesCount" value="${linesCount + 1}"/>
            </c:forEach>
          </ul>
        </c:forEach>
        <c:if test="${linesCount > 10}"><a href="#" class="updateAgentsWarningHealthReportShowMoreLink" onclick="$j('#updateAgentsJavaDetails li.hidden').toggleClass('hidden'); $j('#updateAgentsJavaDetails div.hidden').toggleClass('hidden'); $j('.updateAgentsWarningHealthReportShowMoreLink').hide(); return false;">view all (${linesCount - poolsCount}) &raquo;</a></c:if>
      </div>

    </c:if>
  </div>
</div>
