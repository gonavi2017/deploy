<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>

<div style="vertical-align: middle">
  The server currently uses incompatible external plugin <a href="https://confluence.jetbrains.com/display/TW/VSTest.Console+Runner">VSTest Support</a>.
  Its functionality has been <bs:helpLink file="Upgrade+Notes" anchor="Changesfrom9.0.xto9.1">bundled since TeamCity 9.1</bs:helpLink>.
  Please consider migrating build steps that use it to <bs:helpLink file="Visual+Studio+Tests">Visual Studio Tests</bs:helpLink> runner and removing the plugin.
</div>
