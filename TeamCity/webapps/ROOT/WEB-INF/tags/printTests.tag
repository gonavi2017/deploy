<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ attribute name="tests" fragment="false" required="true" type="java.util.List"
  %><%@ attribute name="maxTests2Show" fragment="false" required="true"
  %><%@ attribute name="buildData" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild"
  %>
<div id="failedTestsDl">

  <tt:_testGroupForBuild tests="${tests}" maxTests2Show="${maxTests2Show}"
                         buildData="${buildData}" showMuteFromTestRun="false" id="build_fail"/>

</div>

<script type="text/javascript">
  // We don't want this function to run on each AJAX refresh call, and we don't want to expand stacktrace
  // on each refresh for a running build.
  BS.TestDetails.expandTestInfo();
</script>
