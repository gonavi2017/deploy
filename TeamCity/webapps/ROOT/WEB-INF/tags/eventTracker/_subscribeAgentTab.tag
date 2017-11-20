<%@ taglib prefix="et" tagdir="/WEB-INF/tags/eventTracker"
%><et:subscribeOnEvents>
    <jsp:attribute name="eventNames"><jsp:doBody/></jsp:attribute>
    <jsp:attribute name="eventHandler">
      if ($('agentTabContent')) {
        BS.reload(false, function() {
          $('agentTabContent').refresh();
        });
      }
    </jsp:attribute>
</et:subscribeOnEvents>