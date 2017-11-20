<%@ include file="/include-internal.jsp" %>
<%--@elvariable id="currentProject" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="keyUsages" type="jetbrains.buildServer.ssh.web.SshKeyUsages"--%>
<%--@elvariable id="key" type="jetbrains.buildServer.ssh.TeamCitySshKey"--%>
<%--@elvariable id="cameFromUrl" type="java.lang.string"--%>
<bs:popup_static controlId="ssh_keys_agent_${util:forJSIdentifier(currentProject.externalId)}_${util:forJSIdentifier(key.name)}"
                linkOpensPopup="false" popup_options="shift: {x: 0, y: 20}">
  <jsp:attribute name="content">
    <ul class="menuList">
      <c:forEach items="${keyUsages.sshAgentUsages}" var="buildType">
        <l:li>
          <span style="white-space: nowrap">
            <admin:editBuildTypeLink buildTypeId="${buildType.externalId}"
                                     cameFromUrl="${cameFromUrl}"
                                     step="buildFeatures">
              <c:out value="${buildType.extendedName}"/>
            </admin:editBuildTypeLink>
          </span>
        </l:li>
      </c:forEach>
    </ul>
  </jsp:attribute>
  <jsp:body>${fn:length(keyUsages.sshAgentUsages)} build configuration<bs:s val="${fn:length(keyUsages.sshAgentUsages)}"/></jsp:body>
</bs:popup_static>
