<%@include file="/include-internal.jsp" %>
<jsp:useBean id="agentJavaVersion" scope="request" type="java.lang.String"/>

<div>
  <span class="icon icon16 yellowTriangle agentVersion" <bs:tooltipAttrs text="Cloud image configured to run build agent under Java ${agentJavaVersion} that will not be supported in future TeamCity releases" /> ></span>
  Please update Java in the Cloud Image <bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="UpgradingJavaonAgents"/>
</div>
