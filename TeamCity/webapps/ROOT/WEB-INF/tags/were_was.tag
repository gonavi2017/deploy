<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="val" fragment="false"
  %><%@ attribute name="name" fragment="false"
  %><span id="${name}"><c:if test="${val > 1 or val == 0}"> were</c:if><c:if test="${val == 1}"> was</c:if></span>