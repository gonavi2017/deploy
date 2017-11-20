<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %>
<%@attribute name="mode" type="java.lang.String" required="true" %>
<%@attribute name="ownerBuild" type="jetbrains.buildServer.Build" required="true" %>
<%@attribute name="builds" type="java.util.Collection" required="true" %>
<table class="dependenciesTable">
  <c:forEach items="${builds}" var="build">
    <tr>
      <bs:dependencyState dependency="${build.buildPromotion}"/>
      <td>
        <bs:_downloadedProvidedArtifacts mode="${mode}" ownerBuild="${ownerBuild}" targetBuild="${build}"/>
      </td>
    </tr>
  </c:forEach>
</table>
