<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><c:set var="seed"><%= Math.abs(request.getAttribute("pageUrl").hashCode())%></c:set
    ><c:set var="_next_tc_id" value="${empty _next_tc_id ? seed : _next_tc_id + 1}" scope="request"
    />${_next_tc_id}