<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="currentProject" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="keyUsages" type="jetbrains.buildServer.ssh.web.SshKeyUsages"--%>
<%--@elvariable id="key" type="jetbrains.buildServer.ssh.TeamCitySshKey"--%>
<%--@elvariable id="cameFromUrl" type="java.lang.string"--%>
<bs:popup_static controlId="ssh_keys_root_${util:forJSIdentifier(currentProject.externalId)}_${util:forJSIdentifier(key.name)}"
                linkOpensPopup="false" popup_options="shift: {x: 0, y: 20}">
  <jsp:attribute name="content">
    <ul class="menuList">
      <c:forEach items="${keyUsages.rootUsages}" var="root">
        <l:li>
          <span style="white-space: nowrap">
            <admin:editVcsRootLink editingScope="editProject:${currentProject.externalId}"
                                   vcsRoot="${root}"
                                   cameFromUrl="${cameFromUrl}">
              <c:out value="${root.name}"/>
            </admin:editVcsRootLink>
          </span>
        </l:li>
      </c:forEach>
    </ul>
  </jsp:attribute>
  <jsp:body>${fn:length(keyUsages.rootUsages)} VCS root<bs:s val="${fn:length(keyUsages.rootUsages)}"/></jsp:body>
</bs:popup_static>
