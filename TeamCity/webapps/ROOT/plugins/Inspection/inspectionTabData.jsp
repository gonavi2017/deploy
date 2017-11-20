<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
/* ${buildId} */
[
<c:forEach items="${inspections}" var="inspection" varStatus="inspectionIteration">
{s:${inspection[0]},g:"${fn:escapeXml(inspection[1])}",i:"${inspection[2]}",n:"${fn:escapeXml(inspection[3])}",c:${inspection[4]},w:${inspection[6]}}<c:if test="${!inspectionIteration.last}">,</c:if></c:forEach>
];
