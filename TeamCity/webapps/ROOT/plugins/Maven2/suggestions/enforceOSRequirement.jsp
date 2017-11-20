<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="buildType" type="jetbrains.buildServer.serverSide.SBuildType" scope="request"/>
<c:set var="osName" value="${healthStatusItem.additionalData['name']}"/>
<c:set var="osArch" value="${healthStatusItem.additionalData['arch']}"/>
<c:set var="osVersion" value="${healthStatusItem.additionalData['version']}"/>
<div class="suggestionItem">
  <admin:editBuildTypeLinkFull buildType="${buildType}"/> runs Maven builds with specific OS requirements.
  <p>
    To avoid build failures caused by wrong OS, you should add Agent Requirements to select only compatible agents.<bs:help file="Agent+Requirements"/>
  </p>
  <div class="suggestionAction">
    <c:set var="editRequirementsUrl"><admin:editBuildTypeLink buildTypeId="${buildType.externalId}" withoutLink="true" step="requirements"/></c:set>
    <c:if test="${not empty osName}">
      <div>
        <forms:addLink href="${editRequirementsUrl}#addRequirement=teamcity.agent.jvm.os.name&value=${osName}&type=contains">Add OS name "${osName}" requirement</forms:addLink>
      </div>
    </c:if>
    <c:if test="${not empty osArch}">
      <div>
        <forms:addLink href="${editRequirementsUrl}#addRequirement=teamcity.agent.jvm.os.arch&value=${osArch}&type=contains">Add OS arch "${osArch}" requirement</forms:addLink>
      </div>
    </c:if>
    <c:if test="${not empty osVersion}">
      <div>
        <forms:addLink href="${editRequirementsUrl}#addRequirement=teamcity.agent.jvm.os.version&value=${osVersion}&type=contains">Add OS version "${osVersion}" requirement</forms:addLink>
      </div>
    </c:if>
  </div>
</div>
