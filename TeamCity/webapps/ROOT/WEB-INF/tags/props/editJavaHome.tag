<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ attribute name="minVersion" type="java.lang.String" required="false" %> <!-- 1.5, 1.6. 1.7 etc -->

<jsp:include page="/admin/jdkChooser.html?minVersion=${minVersion}"/>

