<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
    %><c:set var="txt"><jsp:doBody/></c:set><c:set var="newline" value="\n"/><c:out value='${fn:replace(txt, newline , "")}' escapeXml="false"/>