<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  attribute name="pools" required="true" type="java.util.List"%><%@
  attribute name="poolId" required="true" type="java.lang.Integer"
%><c:set var="first" value="${true}"
/><c:forEach items="${pools}" var="poolBox"
  ><c:set var="pool" value="${poolBox.agentPool}"
  /><c:if test="${pool.agentPoolId != poolId}"
    ><c:if test="${!first}"><br/></c:if
    ><c:set var="first" value="${false}"
    /><bs:agentPoolLink agentPoolId="${pool.agentPoolId}" agentPoolName="${pool.name}" hidePoolWord="${true}"
  /></c:if
></c:forEach>