<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="text" type="java.lang.String" required="true" rtexprvalue="true" %>
<c:forEach var="ch" items="<%=text.toCharArray()%>" varStatus="pos">
  <c:if test="${not pos.first}"><br/></c:if>
  <c:out value="${ch}"/>
</c:forEach>