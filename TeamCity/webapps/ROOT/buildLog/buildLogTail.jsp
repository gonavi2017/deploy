<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion" scope="request"/>

<jsp:useBean id="tailIterator" type="java.util.Iterator" scope="request"/>
<bs:buildLog buildPromotion="${buildPromotion}" messagesIterator="${tailIterator}" renderRunningTime="true" mergeTestOutput="false"/>

<c:if test="${(not empty buildPromotion.associatedBuild) and (not buildPromotion.associatedBuild.finished)}">
  <script type="text/javascript">
    $j(document).ready(function () {
      BS.BuildLog.enableRefresh();
    });
  </script>
</c:if>

