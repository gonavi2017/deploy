<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@attribute name="rolesList" type="java.util.List" required="true" %>
<c:set var="rolesParam" value=""/>
<c:forEach items="${rolesList}" var="roleBean">
  <c:if test="${not fn:contains(rolesParam, roleBean.role.id)}"><c:set var="rolesParam">${rolesParam}&role=${roleBean.role.id}</c:set></c:if>
</c:forEach>
<c:url var="showPermsUrl" value="/rolesDescription.html?${rolesParam}"/>
<div class="grayNote rolesDescription">View roles <a href="#" onclick="BS.Util.popupWindow('${showPermsUrl}', '_blank', {width: 550, height: 600}); return false" title="View permissions">permissions</a></div>
