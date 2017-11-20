<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="val" fragment="false"
  %><%@ attribute name="name" fragment="false"
  %><%@ attribute name="short1" fragment="false"
  %><%--short attr is not used anymore, left for compatibility--%><span id="${name}"><c:if test="${val > 1 or val == 0}"> are</c:if><c:if test="${val == 1}"> is</c:if> </span>