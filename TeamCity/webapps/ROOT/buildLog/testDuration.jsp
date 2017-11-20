<%@ include file="../include-internal.jsp" %>
<%@ taglib prefix="stats" tagdir="/WEB-INF/tags/graph" %>
<bs:dialog dialogId="testDuration" title="Test Duration" closeCommand="BS.Hider.hideDiv('testsDurationGraph');" titleId='testDurationTitle'>
  <stats:buildGraph id="TestDuration" valueType="TestDuration" height="150" width="500" maxTitleLength="50"
    defaultFilter="showFailed"
    controllerUrl="buildGraph.html"
    isPredefined="${true}"
    additionalProperties="testNameId,testId,buildId"/>
</bs:dialog>
<script type="text/javascript">
  new Draggable('testsDurationGraph', {
        starteffect: function() {},
        endeffect: function() {},
        handle: 'testDurationTitle',
        change: function() {
          BS.Util.moveDialogIFrame($('testsDurationGraph'));
        }
      });
</script>
