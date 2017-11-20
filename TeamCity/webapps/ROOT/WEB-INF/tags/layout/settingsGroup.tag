<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ attribute name="title" fragment="false" required="true"
  %><%@ attribute name="mandatory" fragment="false" type="java.lang.Boolean" required="false"
  %><%@ attribute name="className" fragment="false" type="java.lang.String" required="false"%>
<tr class="groupingTitle ${className}">
  <td colspan="2">${title}<c:if test="${mandatory}"> <l:star/></c:if></td>
</tr>
<jsp:doBody/>