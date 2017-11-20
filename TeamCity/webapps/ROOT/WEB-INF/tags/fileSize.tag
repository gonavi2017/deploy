<%@ attribute name="value" type="java.lang.Long" required="true"
%><%@ attribute name="decimals" type="java.lang.Long" required="false"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><c:if test="${empty decimals}"><c:set var="decimals" value="2"/></c:if>${util:formatFileSize(value, decimals)}