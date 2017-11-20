<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<%@ attribute name="uid" type="java.lang.String" required="true" %>
<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="insertIcons" type="java.lang.Boolean" required="true" %>
<%@ attribute name="expand" type="java.lang.Boolean" required="false" %>
<div class="tcRow detailsWrapper" id="detailsWrapper_${uid}" data-id="${buildProblem.id}">
    <c:if test="${insertIcons}">
      <span style="visibility: hidden;"> <%--we need this to fix layout until we will have only one icon for every status--%>
          <problems:buildProblemIcon currentMuteInfo="${buildProblem.currentMuteInfo}" showBuildSpecificInfo="${true}"
                                     buildProblem="${buildProblem}"/>
      </span>
    </c:if>
    <span class="tcCell details" id="details_${uid}">
       <jsp:doBody/>
       <div class="hideDetailsLink"><span class="inplaceLinkSymbol">&laquo;</span>&nbsp;<a href="#" class="inplaceLink" onclick="return BS.BuildProblems.toggleDetailsSection('${uid}');">Hide details</a></div>
    </span>
</div>
<script type="text/javascript">
  BS.BuildProblems.addDetailsSectionSupport('${uid}');
</script>
<c:if test="${expand}">
  <script type="text/javascript">
    BS.BuildProblems.expandDetailsSection('${uid}');
  </script>
</c:if>