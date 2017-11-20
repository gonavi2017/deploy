<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="txt"  %><%@
    attribute name="word" %><c:choose><c:when test="${txt == '*'}"></c:when><c:when test="${txt == ''}"><no ${word}></c:when><c:otherwise>${txt}</c:otherwise></c:choose>