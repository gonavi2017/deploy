<%@ include file="/include-internal.jsp" %>

<%--@elvariable id="entries" type="java.util.List"--%>
<c:url var="pageUrl" value="/admin/resetCacheActions.html"/>

<style type="text/css">
  table.cachesTable td.cachename {
    font-weight: bold;
    padding-right: 2em;
  }

  table.cachesTable td.action {
    text-align: left;
    font-size: 90%;
  }
</style>
<script type="text/javascript">
  function submitReset(cacheName) {
    BS.ajaxRequest('${pageUrl}', {
      method: "post",
      parameters: "name=" + cacheName,
      onComplete: function(transport) {
        var errors = BS.XMLResponse.processErrors(transport.responseXML);
        if (!errors) {
          var elem = $('cachesContainer');
          if (elem) {
            elem.refresh();
          }
        }
      }
    });
  }
</script>

<div class="icon_before icon16 attentionComment" style="margin-top: 1em;">
  This is mostly internal stuff. Please do not touch it unless you are advised to do so by a TeamCity team member.
</div>

<p>List of TeamCity caches:</p>

<bs:refreshable containerId="cachesContainer" pageUrl="${pageUrl}">
  <table class="cachesTable">
    <c:forEach items="${entries}" var="entry">
      <tr>
        <td class="cachename"><c:out value="${entry.name}"/></td>
        <td class="action">
          <c:choose>
            <c:when test="${entry.isEmpty}">
              empty
            </c:when>
            <c:otherwise>
              <a href="#" title="Reset this cache"
                 onclick="submitReset('${entry.name}'); return false">Reset</a>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </table>
</bs:refreshable>
