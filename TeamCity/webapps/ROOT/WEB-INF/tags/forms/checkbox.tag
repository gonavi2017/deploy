<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ attribute name="custom" required="false" type="java.lang.Boolean"
    %><%@ attribute name="name" required="true"
    %><%@ attribute name="id" required="false"
    %><%@ attribute name="style" required="false" type="java.lang.String"
    %><%@ attribute name="className" required="false" type="java.lang.String"
    %><%@ attribute name="checked" required="false" type="java.lang.Boolean"
    %><%@ attribute name="onclick" required="false"
    %><%@ attribute name="onmouseover" required="false"
    %><%@ attribute name="onmouseout" required="false"
    %><%@ attribute name="value" required="false"
    %><%@ attribute name="attrs" required="false"
    %><%@ attribute name="title" required="false"
    %><%@ attribute name="disabled" required="false" type="java.lang.Boolean"
    %><c:set var="idVal" value="${empty id ? name : id}"
    /><c:set var="title"><c:out value="${title}"/></c:set
    ><c:set var="value">${empty value ? 'true' : value}</c:set
><c:choose>
  <c:when test="${custom}">
    <span class="custom-checkbox<c:if test="${not empty className}"> ${className}</c:if>"
          <c:if test="${not empty onmouseover}">onmouseover="${onmouseover}"</c:if>
          <c:if test="${not empty onmouseout}">onmouseout="${onmouseout}"</c:if>>
      <input type="checkbox" class="custom-checkbox_input" ${attrs}
             name="${name}"
             id="${idVal}"
             <c:if test="${not empty style}">style="${style}"</c:if>
             <c:if test="${not empty onclick}">onclick="${onclick}"</c:if>
             <c:if test="${not empty title}">title="${title}"</c:if>
             <c:if test="${checked == true}">checked</c:if>
             <c:if test="${disabled == true}">disabled</c:if>
             value="${value}">
      <span class="custom-checkbox_bg">
        <span class="custom-checkbox_tick tc-icon tc-icon__tick"></span>
      </span>
    </span>
  </c:when>
  <c:otherwise>
    <input type="checkbox" ${attrs}
           name="${name}"
           id="${idVal}"
           <c:if test="${not empty className}">class="${className}"</c:if>
           <c:if test="${not empty style}">style="${style}"</c:if>
           <c:if test="${not empty onclick}">onclick="${onclick}"</c:if>
           <c:if test="${not empty onmouseover}">onmouseover="${onmouseover}"</c:if>
           <c:if test="${not empty onmouseout}">onmouseout="${onmouseout}"</c:if>
           <c:if test="${not empty title}">title="${title}"</c:if>
           <c:if test="${checked == true}">checked</c:if>
           <c:if test="${disabled == true}">disabled</c:if>
           value="${value}">
    <input type="hidden" name="_${name}" value="">
  </c:otherwise>
</c:choose>
