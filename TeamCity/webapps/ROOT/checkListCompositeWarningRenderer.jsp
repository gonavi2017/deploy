<%@ include file="include-internal.jsp"%>
<c:choose>
  <c:when test="${_warning.count == 1}">
    <bs:format source="${_warning.singleObjectWarningText}" key="object">
      <jsp:attribute name="replacement"><c:set var="_object" value="${_warning.firstObject}" scope="request"/><jsp:include page="${_warning.objectRendererPage}"/></jsp:attribute>
    </bs:format>
  </c:when>
  <c:otherwise>
    <bs:format source="${_warning.severalObjectsWarningText}" key="popup">
      <jsp:attribute name="replacement">
        <bs:simplePopup controlId="${_warning.controlId}" popup_options="shift: {x: 0, y: 20}">
          <jsp:attribute name="content">
            <c:forEach var="object" items="${_warning.objects}">
              <c:set var="_object" value="${object}" scope="request"/>
              <div><jsp:include page="${_warning.objectRendererPage}"/></div>
            </c:forEach>
          </jsp:attribute>
          <jsp:body>${_warning.severalObjectsPopupText}</jsp:body>
        </bs:simplePopup>
      </jsp:attribute>
    </bs:format>
  </c:otherwise>
</c:choose>
