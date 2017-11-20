<%-- Unsubsribes all listeners for eventNames --%>
<%@ tag import="jetbrains.buildServer.serverSide.tracker.EventTracker"
%><%@ tag import="jetbrains.buildServer.serverSide.tracker.TrackerEventType"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="eventNames" required="true" fragment="true"
%><%@ attribute name="buildTypeId" required="true" %><jsp:useBean id="__tc_eventTracker" type="jetbrains.buildServer.serverSide.tracker.EventTracker" scope="request"
/><c:set var="events"><jsp:invoke fragment="eventNames"/></c:set
><c:set var="eventsList" value='<%=((String)jspContext.getAttribute("events")).split("[\n\r]+")%>'
/><script type="text/javascript">(function() {<c:forEach items="${eventsList}" var="ename"
><c:set var="trimmed" value="${fn:trim(ename)}"/><c:if test="${fn:length(trimmed) > 0}"
><c:set var="event" value='<%=TrackerEventType.valueOf((String)jspContext.getAttribute("trimmed"))%>'
/>BS.EventTracker.unsubscribeBuildTypeEventSubscription('${event.shortCode}', '${buildTypeId}');</c:if
></c:forEach>})();</script>