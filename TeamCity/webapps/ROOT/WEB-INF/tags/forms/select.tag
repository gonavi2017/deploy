<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="name" required="true"
  %><%@attribute name="id" required="false"
  %><%@attribute name="style" required="false"
  %><%@attribute name="className" required="false"
  %><%@attribute name="onchange" required="false"
  %><%@attribute name="onclick" required="false"
  %><%@attribute name="tabindex" required="false"
  %><%@attribute name="disabled" required="false" type="java.lang.Boolean"
  %><%@attribute name="multiple" required="false" type="java.lang.Boolean"
  %><%@attribute name="size" required="false"
  %><%@attribute name="enableFilter" required="false" type="java.lang.Boolean"
  %><%@attribute name="filterOptions" required="false" type="java.lang.String"
  %><c:set var="id" value="${not empty id ? id : name}"
  /><c:set var="filterOptions" value="${not empty filterOptions ? filterOptions : '{}'}"/><select name="${name}" id="${id}" style="${style}" class="${className}" tabindex="${tabindex}" ${disabled ? "disabled='disabled'" : ''} <c:if test="${not empty onchange}">onchange="${onchange}"</c:if> <c:if test="${not empty onclick}">onclick="${onclick}"</c:if> <c:if test="${not empty multiple and multiple}">multiple="multiple" <c:if test="${not empty size}">size="${size}"</c:if> </c:if> ><jsp:doBody/></select
><c:if test="${enableFilter}"><script type="text/javascript">
  BS.enableJQueryDropDownFilter('${id}', ${filterOptions});
</script></c:if>
