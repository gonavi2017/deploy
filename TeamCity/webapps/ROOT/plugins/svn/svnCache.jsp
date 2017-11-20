<%@ include file="/include.jsp"
%><jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"
/><c:set var="pageTitle" value="SVN Caches" scope="request"
/><bs:page>
<jsp:attribute name="head_include">
  <style type="text/css">
    table.svnCache {
      margin-top: 1em;
    }

    .svnCache tr td {
      border-bottom: 1px dashed #ddd;
      vertical-align: top;
    }
    .d {
      font-size: 80%;
    }
  </style>

  <script type="text/javascript">
    BS.Navigation.items = [
      {title: "Administration", url: "<c:url value='/admin/admin.html'/>"},
      {title: "SVN Caches", selected: true}
    ];

    BS.clearSvnCache = function(path) {
      BS.ajaxRequest("<c:url value='/admin/svnCache.html'/>", {
        parameters: ( path ? "clearPath=" + encodeURIComponent(path): "clearAllCaches=true"),
        onComplete: function() {
          BS.reload(true);
        }
      })
    };
  </script>
</jsp:attribute>

<jsp:attribute name="body_include">
  <jsp:useBean id="externals" type="java.util.Collection< jetbrains.buildServer.buildTriggers.vcs.svn.externals.PathExternals >" scope="request"/>
  <c:if test="${empty externals}">
    No SVN externals were used/detected yet. 
  </c:if>
  
  <c:if test="${not empty externals}">

    <button class="btn btn_mini" onclick="if (window.confirm('Are you sure?')) BS.clearSvnCache(); return false;">Clear SVN externals cache</button>

    <table class="dark svnCache">
      <tr>
        <th>SVN path/version</th>
        <th>Collected externals</th>
        <th>Clear cache</th>
      </tr>
      
    <c:forEach items="${externals}" var="ex">
      <c:set var="path" value="${ex.path}"/>
      <c:set var="newPath" value="${true}"/>

      <c:set var="prevExternals" value="${null}"/>
      <c:forEach items="${ex.rev2Externals}" var="revData">

        <c:if test="${revData.value ne prevExternals}">
            <c:set var="prevExternals" value="${revData.value}"/>
            <tr>
              <td><c:out value="${path}"/>@<c:out value="${revData.key}"/></td>
              <td>
                <c:if test="${revData.value.size > 0}">
                  <a href="#" onclick="this.nextSibling.style.display=''; this.style.display='none';return false;"
                      >${revData.value.size}</a><span class="d" style="display: none;"><l:br val="${revData.value}"/></span>
                </c:if>
              </td>
              <td>
                <c:if test="${newPath}">
                  <a href="#" onclick="BS.clearSvnCache('${path}'); return false;">clear cache for path</a>
                </c:if>
                &nbsp;
              </td>
            </tr>
        </c:if>
        <c:if test="${revData.value eq prevExternals}">
            <tr>
              <td colspan="3">...@<c:out value="${revData.key}"/></td>
            </tr>
        </c:if>
        <c:set var="newPath" value="${false}"/>

      </c:forEach>

    </c:forEach>
    </table>
    
  </c:if>
  
</jsp:attribute>
</bs:page>