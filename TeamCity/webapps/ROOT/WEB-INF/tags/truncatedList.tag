<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="id" required="true" type="java.lang.String"
%><%@ attribute name="elements" required="true" type="java.lang.Iterable"
%><%@ attribute name="elemHTML" required="true" fragment="true"
%><%@ variable name-given="elem"
%><ul id="${id}">
  <c:forEach items="${elements}" var="elem" varStatus="loop">
    <li class="${loop.index >= 5 ? 'hidden' : ''}">
      <jsp:invoke fragment="elemHTML"/>
    </li>
  </c:forEach>
  <c:if test="${fn:length(elements) > 5}"><a href="#" onclick="$j('#${id} li.hidden').toggleClass('hidden'); $j(this).hide(); return false;">view all (${fn:length(elements)}) &raquo;</a></c:if>
</ul>