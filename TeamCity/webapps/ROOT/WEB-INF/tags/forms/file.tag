<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="name" type="java.lang.String" required="true" %><%@
    attribute name="size" type="java.lang.Integer" required="false" %><%@
    attribute name="attributes" type="java.lang.String" required="false"

%><c:set var="fileName" value="file:${name}"
/><c:if test="${not empty size}"
    ><c:set var="attributes" value="${attributes} size='${size}'"
/></c:if
><input type="file" name="${fileName}" id="${fileName}" ${attributes}/>