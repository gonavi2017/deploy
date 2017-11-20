<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><bs:webComponentsSettings/>
<script type="text/javascript">
  var internalProps = [];

  internalProps['teamcity.ui.pollInterval'] = ${intprop:getInteger('teamcity.ui.pollInterval', 6)};
  internalProps['teamcity.ui.serverAvailability.pollInterval'] = ${intprop:getInteger('teamcity.ui.serverAvailability.pollInterval', 3)};

  internalProps['teamcity.ui.events.pollInterval'] = ${intprop:getInteger('teamcity.ui.events.pollInterval', 6)};
  internalProps['teamcity.ui.systemProblems.pollInterval'] = ${intprop:getInteger('teamcity.ui.systemProblems.pollInterval', 20)};
  internalProps['teamcity.ui.problemsSummary.pollInterval'] = ${intprop:getInteger('teamcity.ui.problemsSummary.pollInterval', 8)};
  internalProps['teamcity.ui.buildQueueEstimates.pollInterval'] = ${intprop:getInteger('teamcity.ui.buildQueueEstimates.pollInterval', 10)};

  // Doesn't use BS.SubscriptionManager and standard subscription mechanism
  internalProps['teamcity.ui.cleanupNotificatorProgress.pollInterval'] = ${intprop:getInteger('teamcity.ui.cleanupNotificatorProgress.pollInterval', 6)};

  internalProps['teamcity.ui.codeMirrorEditor.enabled'] = ${intprop:getBooleanOrTrue('teamcity.ui.codeMirrorEditor.enabled')};
  internalProps['teamcity.ui.customConfirm'] = ${intprop:getBoolean('teamcity.ui.customConfirm')};
  internalProps['teamcity.ui.branches.inBreadcrumbs'] = ${intprop:getBoolean('teamcity.ui.branches.inBreadcrumbs')};
  internalProps['teamcity.ui.restSelectors.disabled'] = ${restSelectorsDisabled};
  internalProps['teamcity.ui.restBreadcrumbs.popupInMainLink.enabled'] = ${intprop:getBoolean('teamcity.ui.restBreadcrumbs.popupInMainLink.enabled')};
</script>
