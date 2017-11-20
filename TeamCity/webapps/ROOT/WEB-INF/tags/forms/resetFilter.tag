<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="resetUrl" required="false" %><%@
    attribute name="resetHandler" required="false" %><%@
    attribute name="hidden" required="false" type="java.lang.Boolean"

%><c:set var="title" value="Reset the filter"
/><c:set var="clazz" value="reset${hidden ? ' hidden' : ''}"
/><c:choose
  ><c:when test="${not empty resetUrl}"><a class="${clazz}" title="${title}" href="${resetUrl}">&#xd7;</a></c:when
  ><c:otherwise><a class="${clazz}" title="${title}" href="#" onclick="${resetHandler}; return false">&#xd7;</a></c:otherwise
></c:choose>