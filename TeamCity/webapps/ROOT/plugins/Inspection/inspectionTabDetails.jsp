<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %>
<div class="details">
<c:forEach items="${details}" var="detail">
  <div class="detail"><c:if test="${detail[0]>=0}"><a href="#" title="Click to open in the active IDE"
  onclick="IB.doActivate('${fn:replace(file,'\\','/')}','${detail[0]}'); return false">${detail[0]}</a>:</c:if> <span class="loc">${fn:escapeXml(detail[1])}</span> ${fn:escapeXml(detail[2])}</div>
</c:forEach>
</div>
