<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="agent" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildAgent"
  %><c:if test="${not empty agent.statusComment && not empty agent.statusComment.comment}"
><c:set var="comment"><c:out value="${agent.statusComment.comment}"/></c:set><bs:commentIcon text="${comment}"
/></c:if>