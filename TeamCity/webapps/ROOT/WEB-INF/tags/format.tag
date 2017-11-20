<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="source" required="true" type="java.lang.String"
%><%@ attribute name="key" required="true" type="java.lang.String"
%><%@ attribute name="replacement" fragment="true" required="true"
%><c:set var="replacementText"><jsp:invoke fragment="replacement"/></c:set
><bs:doFormat source="${source}" key="${key}" replacementText="${replacementText}"/>