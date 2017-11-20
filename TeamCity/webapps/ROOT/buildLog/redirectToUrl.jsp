<%@ include file="../include-internal.jsp" %>
<jsp:useBean id="url" type="java.lang.String" scope="request"/>
<bs:refreshable containerId="queuedBuildContainer" pageUrl="${pageUrl}">
<script type="text/javascript">
  document.location.href = '${url}';
</script>
</bs:refreshable>