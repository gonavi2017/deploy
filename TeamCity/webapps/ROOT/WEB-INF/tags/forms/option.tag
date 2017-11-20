<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ attribute name="value" required="true"
    %><%@ attribute name="className" required="false" type="java.lang.String"
    %><%@ attribute name="selected" required="false" type="java.lang.Boolean"
    %><%@ attribute name="disabled" required="false" type="java.lang.Boolean"
    %><%@ attribute name="title" required="false" type="java.lang.String"
    %><%@ attribute name="data" required="false" type="java.lang.String"
    %><%@ attribute name="htmlTitle" required="false" type="java.lang.String"

%><option <c:if test="${not empty className}"
    >class="${className}" </c:if
    >value="<c:out value="${value}"/>"<c:if test="${selected}"> selected="selected"</c:if
    ><c:if test="${disabled}"> disabled="disabled" </c:if
    > <c:if test="${not empty htmlTitle}"> title="${htmlTitle}" </c:if
    > data-title="<c:out value='${title}'/>" <c:if test="${not empty data}">data-filter-data="${data}"</c:if
    > ><jsp:doBody/></option>