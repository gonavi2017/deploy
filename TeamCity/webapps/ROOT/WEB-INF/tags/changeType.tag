<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ attribute name="modification" required="true" type="jetbrains.buildServer.vcs.SVcsModification"
    %>
<c:choose>
  <c:when test="${not modification.personal}">change</c:when>
  <c:otherwise><%=modification.getPersonalChangeInfo().getCommitType().getName().toLowerCase()%></c:otherwise>
</c:choose>
