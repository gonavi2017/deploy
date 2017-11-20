<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="buildRunners" required="true" type="java.util.Collection"
  %><c:if test="${fn:length(buildRunners) == 0}">No build steps</c:if
    ><c:forEach items="${buildRunners}" var="runner" varStatus="pos"
    ><c:if test="${fn:length(runner.name) == 0}"><c:set var="runnerName" value="${runner.runType.displayName}"/></c:if
    ><c:if test="${fn:length(runner.name) > 0}"><c:set var="runnerName" value="${runner.name}"/></c:if
    ><bs:makeBreakable text="${runnerName}" regex=".{60}"/><c:if test="${not pos.last}">, </c:if
    ></c:forEach>