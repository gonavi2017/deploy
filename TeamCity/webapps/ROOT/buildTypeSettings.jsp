<%@ page import="jetbrains.buildServer.serverSide.BuildFeature" %>
<%@ page import="jetbrains.buildServer.serverSide.BuildTypeOptions" %>
<%@include file="include-internal.jsp"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ include file="_subscribeToCommonBuildTypeEvents.jspf"
%><div id="buildTypeSettings" class="buildTypeSettings">

    <jsp:useBean id="buildTypeSettings" type="jetbrains.buildServer.controllers.buildType.BuildTypeSettingsBean" scope="request"/>
    <c:set var="title" value="${buildTypeSettings.buildType.fullName} settings"/>

    <c:if test="${buildTypeSettings.buildType.templateBased}">
      <div class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">
        This build configuration settings are based on template:
        <authz:authorize projectId="${buildTypeSettings.buildType.template.project.projectId}" allPermissions="EDIT_PROJECT"
              ><jsp:attribute name="ifAccessGranted"
              ><admin:editTemplateLink templateId="${buildTypeSettings.buildType.template.externalId}"><c:out value="${buildTypeSettings.buildType.template.fullName}"/> &raquo;</admin:editTemplateLink
              ></jsp:attribute
              ><jsp:attribute name="ifAccessDenied"><c:out value="${buildTypeSettings.buildType.template.fullName}"/></jsp:attribute
              ></authz:authorize>
      </div>
    </c:if>
      
    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="0"/>

      <div class="parameter">
        Name: <strong><c:out value="${buildTypeSettings.buildType.name}"/></strong>
      </div>

      <div class="parameter">
        ID: <strong title="Internal id: ${buildTypeSettings.buildType.buildTypeId}"><c:out value="${buildTypeSettings.buildType.externalId}"/></strong>
      </div>

      <div class="parameter">
        Description: <strong><c:out value="${empty buildTypeSettings.buildType.description ? 'none' : buildTypeSettings.buildType.description}"/></strong>
      </div>

      <div class="parameter">
        Build number format: <strong><c:out value="${buildTypeSettings.buildType.buildNumberPattern}"/></strong>, next build number: <strong>#<c:out value="${buildTypeSettings.buildType.buildNumbers.buildNumber}"/></strong>
      </div>

      <div class="parameter">
        Artifact paths:
        <div class="nestedParameter"><strong>
        <c:choose>
          <c:when test="${empty buildTypeSettings.buildType.artifactPaths}">none specified</c:when>
          <c:otherwise><bs:out value="${buildTypeSettings.buildType.artifactPaths}"/></c:otherwise>
        </c:choose></strong>
        </div>
      </div>

      <c:set var="failIfExitCode" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_FAIL_ON_EXIT_CODE)%>"/>
      <c:set var="failIfTestFailed" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_FAIL_IF_TESTS_FAIL)%>"/>
      <c:set var="failIfErrMessage" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_FAIL_ON_ANY_ERROR_MESSAGE)%>"/>
      <c:set var="failIfOOME" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_FAIL_ON_OOME_OR_CRASH)%>"/>
      <c:set var="maxBuildsNum" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_MAX_RUNNING_BUILDS)%>"/>
      <c:set var="hangingBuildsDetection" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_HANGING_BUILDS_DETECTION_ENABLED)%>"/>
      <c:set var="allowPersonalBuilds" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_ALLOW_PERSONAL_BUILD_TRIGGERING)%>"/>

      <div class="parameter">
        Build options:

        <div class="nestedParameter">
          Enable hanging builds detection: <strong>${hangingBuildsDetection ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          Allow triggering personal builds: <strong>${allowPersonalBuilds ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          Enable status widget: <strong>${buildTypeSettings.buildType.allowExternalStatus ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          Limit the number of simultaneously running builds (0 &mdash; unlimited): <strong>${maxBuildsNum == 0 ? 'unlimited' : maxBuildsNum}</strong>
        </div>
      </div>
    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="1"/>

      <div class="parameter">
        VCS checkout mode: <strong><c:out value="${buildTypeSettings.vcsRootsBean.checkoutTypeDescription[buildTypeSettings.vcsRootsBean.checkoutType]}"/></strong>
      </div>

      <div class="parameter">
        Checkout directory:
        <strong>
          <c:choose>
            <c:when test="${not empty buildTypeSettings.vcsRootsBean.checkoutDir}">
              <c:out value="${buildTypeSettings.vcsRootsBean.checkoutDir}"/>
            </c:when>
            <c:otherwise>
              default
            </c:otherwise>
          </c:choose>
        </strong>
      </div>

      <div class="parameter">
        Clean all files before build: <strong>${buildTypeSettings.buildType.cleanBuild ? 'ON' : 'OFF'}</strong>
      </div>

      <div class="parameter">Attached VCS roots:
        <c:if test="${empty buildTypeSettings.vcsRootsBean.vcsRoots}">
          <div class="nestedParameter">There are no VCS roots attached to this build configuration</div>
        </c:if>
        <c:if test="${not empty buildTypeSettings.vcsRootsBean.vcsRoots}">
          <div class="nestedParameter">
          <table class="settings">
            <tr>
              <th class="name">VCS Root</th>
              <th class="name" style="width: 20%">Checkout Rules</th>
            </tr>
            <c:forEach items="${buildTypeSettings.vcsRootEntries}" var="vcsRootEntry">
              <c:set var="vri" value="${vcsRootEntry.vcsRoot}"/>
              <tr>
                <td class="vcsRootName">
                  <admin:vcsRootName vcsRoot="${vri.parent}" editingScope="editProject:${vri.parent.project.externalId}" cameFromUrl="${pageUrl}"/>
                  belongs to <admin:projectName project="${vri.parent.project}"/>
                  <br>
                  <bs:vcsRootInstanceInfo vri="${vri}"/>
                </td>
                <td><c:set var="checkoutRules" value="${vcsRootEntry.checkoutRules.asString}"/><c:choose>
                  <c:when test="${not empty checkoutRules}"><bs:out value="${vcsRootEntry.checkoutRules.asString}"/></c:when>
                  <c:otherwise>not specified</c:otherwise>
                </c:choose></td>
              </tr>
            </c:forEach>
          </table>
          </div>
        </c:if>
      </div>

      <div class="parameter">
        <c:set var="showDepsChanges" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_SHOW_DEPS_CHANGES)%>"/>
        Show changes from snapshot dependencies: <strong>${showDepsChanges ? 'ON' : 'OFF'}</strong>
      </div>

      <div class="parameter">
        <c:set var="excludeDefaultBranchChanges" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_EXCLUDE_DEFAULT_BRANCH_CHANGES)%>"/>
        Exclude default branch changes: <strong>${excludeDefaultBranchChanges ? 'ON' : 'OFF'}</strong>
      </div>

      <div class="parameter">
        <c:set var="buildDefaultBranch" value="<%=buildTypeSettings.getOption(BuildTypeOptions.BT_BUILD_DEFAULT_BRANCH)%>"/>
        Build default branch: <strong>${buildDefaultBranch ? 'ON' : 'OFF'}</strong>
      </div>
    </div>

    <div class="parameterGroup">
      <p:container contextId="runner_parameters_view" JSObject="BS.VewBuildRunnerFormControls">
      <jsp:attribute name="content">

      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="2"/>
      <c:if test="${empty buildTypeSettings.buildRunners}">
      <div class="parameter">
        There are no build steps configured.
      </div>
      </c:if>

      <c:forEach var="runnerBean" items="${buildTypeSettings.buildRunners}" varStatus="pos">
        <c:if test="${runnerBean.enabled}">
        <div class="parameter">

          Step ${pos.index+1}:
          <c:if test="${fn:length(runnerBean.buildStepName) > 0}"><strong><c:out value="${runnerBean.buildStepName}"/></strong></c:if>

          <div class="nestedParameter">
            <div class="parameter">Runner type: <strong><c:out value="${runnerBean.runType.displayName}"/></strong> (<c:out value="${runnerBean.runType.description}"/>)</div>
            <div class="parameter">Execute:<bs:help file="Configuring+Build+Steps"/> <strong><c:out value="${runnerBean.selectedExecutionPolicy.description}"/></strong></div>
            <admin:runnerSettings runnerBean="${runnerBean}"/>
          </div>

        </div>
        </c:if>
      </c:forEach>
      </jsp:attribute>
      </p:container>

    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="3"/>

      <c:set var="buildTriggersBean" value="${buildTypeSettings.buildTriggersBean}"/>

      <div class="parameter">
      <c:if test="${buildTypeSettings.buildType.paused}">
        Build configuration is paused (triggering disabled).
      </c:if>
      <c:if test="${not buildTypeSettings.buildType.paused}">
        Build configuration is active (triggering enabled).
      </c:if>
      </div>

      <div class="parameter">
        <c:set var="triggers">
          <c:forEach items="${buildTriggersBean.triggers}" var="trigger">
            <c:if test="${trigger.enabled}">
              <tr>
                <td style="white-space: nowrap;">
                  <admin:triggerInfo trigger="${trigger}" showDescription="false"/>
                </td>
                <td>
                  <admin:triggerInfo trigger="${trigger}" showName="false"/>
                </td>
              </tr>
            </c:if>
          </c:forEach>
        </c:set>

        <c:if test="${not empty fn:trim(triggers)}">
          <div class="nestedParameter">
            <table class="settings">
              <tr>
                <th class="name" style="width: 30%;">Trigger</th>
                <th class="name" style="width: 70%;">Parameters Description</th>
              </tr>
              ${triggers}
            </table>
          </div>
        </c:if>
      </div>

    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="4"/>

      <div class="parameter">
        Fail build if:
        <div class="nestedParameter">
          process exit code is not zero: <strong>${failIfExitCode ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          at least one test failed: <strong>${failIfTestFailed ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          an error message is logged by build runner: <strong>${failIfErrMessage ? 'ON' : 'OFF'}</strong>
        </div>

        <div class="nestedParameter">
          it runs longer than:
          <strong>
          <c:choose>
            <c:when test="${buildTypeSettings.buildType.executionTimeoutMin <= 0}">no limit</c:when>
            <c:otherwise>${buildTypeSettings.buildType.executionTimeoutMin} minutes</c:otherwise>
          </c:choose>
          </strong>
        </div>

        <div class="nestedParameter">
          out of memory or crash is detected: <strong>${failIfOOME ? 'ON' : 'OFF'}</strong>
        </div>
      </div>

      <c:set var="buildFeaturesBean" value="${buildTypeSettings.buildFeaturesBean}"/>
      <c:set var="place" value="<%= BuildFeature.PlaceToShow.FAILURE_REASON %>"/>
      <c:set var="features">
        <c:forEach items="${buildFeaturesBean.buildFeatureDescriptors}" var="featureDescriptor">
          <c:if test="${featureDescriptor.descriptor.buildFeature.placeToShow == place and featureDescriptor.enabled}">
            <tr>
              <td style="white-space: nowrap;">
                <admin:featureInfo feature="${featureDescriptor}" showDescription="false"/>
              </td>
              <td>
                <admin:featureInfo feature="${featureDescriptor}" showName="false"/>
              </td>
            </tr>
          </c:if>
        </c:forEach>
      </c:set>

      <c:if test="${not empty fn:trim(features)}">
        <div class="parameter">
          Other failure conditions:

          <div class="nestedParameter">
            <table class="settings">
              <tr>
                <th class="name" style="width: 30%;">Type</th>
                <th class="name" style="width: 70%;">Parameters Description</th>
              </tr>
              ${features}
            </table>
          </div>
        </div>
      </c:if>

    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="5"/>

      <c:set var="buildFeaturesBean" value="${buildTypeSettings.buildFeaturesBean}"/>
      <c:set var="place" value="<%= BuildFeature.PlaceToShow.GENERAL %>"/>
      <c:set var="features">
        <c:forEach items="${buildFeaturesBean.buildFeatureDescriptors}" var="featureDescriptor">
          <c:if test="${featureDescriptor.descriptor.buildFeature.placeToShow == place and featureDescriptor.enabled}">
            <tr>
              <td style="white-space: nowrap;">
                <admin:featureInfo feature="${featureDescriptor}" showDescription="false"/>
              </td>
              <td>
                <admin:featureInfo feature="${featureDescriptor}" showName="false"/>
              </td>
            </tr>
          </c:if>
        </c:forEach>
      </c:set>

      <div class="parameter">
      <c:if test="${not empty fn:trim(features)}">
        <div class="nestedParameter">
          <table class="settings">
            <tr>
              <th class="name" style="width: 30%;">Type</th>
              <th class="name" style="width: 70%;">Parameters Description</th>
            </tr>
            ${features}
          </table>
        </div>
      </c:if>
      <c:if test="${empty fn:trim(features)}">
        There are no build features configured.
      </c:if>
      </div>

    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="6"/>

      <c:set var="sourceDependencies" value="${buildTypeSettings.sourceDependenciesBean.dependencies}"/>
      <c:set var="chainId" value="${buildTypeSettings.sourceDependenciesBean.buildChainId}"/>
      <c:if test="${not empty chainId}">
        <c:set value='/viewChain.html?chainId=${chainId}&selectedBuildTypeId=${buildTypeSettings.buildType.buildTypeId}&contextProjectId=${buildTypeSettings.buildType.projectExternalId}' var="relativeViewChainUrl"/>
        <c:url value='${relativeViewChainUrl}' var="viewChainUrl"/>
      </c:if>

      <div class="parameter">
        Snapshot Dependencies<c:if test="${not empty viewChainUrl}"> (<a href="${viewChainUrl}" target="_blank" onclick="BS.stopPropagation(event);" title="Open build chain in a new window"><i class="tc-icon icon16 tc-icon_build-chain"></i>build chain</a>)</c:if>:
        <div class="nestedParameter">
          <c:if test="${empty sourceDependencies}">
          There are no snapshot dependencies.
          </c:if>
          <c:if test="${not empty sourceDependencies}">
            <table class="settings">
              <tr>
                <th class="name">Depends on</th>
                <th class="name">Dependency options</th>
              </tr>
              <c:forEach items="${sourceDependencies}" var="dependency">
                <tr>
                  <td>
                    <c:choose>
                      <c:when test="${dependency.sourceBuildTypeAccessible}">
                        <bs:buildTypeLinkFull buildType="${dependency.sourceBuildType}"/>
                      </c:when>
                      <c:when test="${not dependency.sourceBuildTypeExists}">
                        <em title="Build configuration with ID &quot;${dependency.sourceBuildTypeExternalId}&quot; does not exist">&laquo;build configuration with ID "${dependency.sourceBuildTypeExternalId}" does not exist&raquo;</em>
                      </c:when>
                      <c:otherwise>
                        <em title="You do not have enough permissions for this build configuration">&laquo;inaccessible build configuration&raquo;</em>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <bs:_dependencyDescription dependency="${dependency}"/>
                  </td>
                </tr>
              </c:forEach>
            </table>
          </c:if>
        </div>
      </div>

      <c:set var="dependencies" value="${buildTypeSettings.artifactDependenciesBean.dependencies}"/>
      <c:set var="cleanDestPaths" value="${buildTypeSettings.artifactDependenciesBean.cleanDestinationPaths}" />
      <c:set var="doDependenciesExist" value="${buildTypeSettings.artifactDependenciesBean.enabledDependenciesExist}" />

      <div class="parameter">
        Artifact dependencies:
        <div class="nestedParameter">
          <c:if test="${not doDependenciesExist}">
          There are no artifact dependencies.
          </c:if>
          <c:if test="${doDependenciesExist}">
            <table class="settings">
              <tr>
                <th class="name">Depends on</th>
                <th class="name">Artifacts paths</th>
              </tr>
              <c:forEach items="${dependencies}" var="dependency">
                <c:if test="${dependency.enabled}">
                  <tr>
                    <td>
                      <c:choose>
                        <c:when test="${dependency.sourceBuildTypeAccessible}">
                          <bs:buildTypeLinkFull buildType="${dependency.sourceBuildType}"/>
                        </c:when>
                        <c:when test="${not dependency.sourceBuildTypeExists}">
                          <em title="Build configuration with ID &quot;${dependency.sourceBuildTypeExternalId}&quot; does not exist">&laquo;build configuration with ID "${dependency.sourceBuildTypeExternalId}" does not exist&raquo;</em>
                        </c:when>
                        <c:otherwise>
                          <em title="You do not have enough permissions for this build configuration">&laquo;inaccessible build configuration&raquo;</em>
                        </c:otherwise>
                      </c:choose>
                      <br/>
                      (<bs:_artifactDependencyLink dependency="${dependency}"/>)
                    </td>
                    <td>
                      <bs:out  value="${dependency.artifactsPaths}" multilineOnly="true"/><br/>
                      <c:choose>
                        <c:when test="${dependency.cleanDestination}"><i>Destinations will be cleaned</i></c:when>
                        <c:when test="${dependency.containsTargetPaths(cleanDestPaths)}">
                          <br/><i>Destinations to be cleaned due to other artifact dependencies:
                          <c:set var="delim" value="" />
                          <c:forEach items="${dependency.targetPaths}" var="target" varStatus="status"><c:if test="${cleanDestPaths.contains(target)}"><c:out value="${delim}" /><c:set var="delim" value=", " />
                            <c:choose><c:when test="${target.length() == 0}">[root]</c:when><c:otherwise><c:out value="${target}" /></c:otherwise></c:choose></c:if></c:forEach></i>
                        </c:when>
                      </c:choose>
                    </td>
                  </tr>
                </c:if>
              </c:forEach>
            </table>
          </c:if>
        </div>
      </div>
    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="7"/>
      <c:set var="buildPropertiesBean" value="${buildTypeSettings.buildPropertiesBean}"/>

      <bs:viewBuildParameters buildParameters="${buildPropertiesBean}" nameValueSeparator=":"/>

    </div>

    <div class="parameterGroup">
      <bs:buildTypeSettingsEditLink buildType="${buildTypeSettings.buildType}" num="8"/>
      <c:set var="requirementsBean" value="${buildTypeSettings.requirementsBean}"/>

      <c:if test="${empty requirementsBean.enabledRequirements}"><p>None defined</p></c:if>

      <c:if test="${not empty requirementsBean.enabledRequirements}">
      <div class="nestedParameter">
        <table class="settings">
          <tr>
            <th class="name" style="width: 30%;">Parameter Name</th>
            <th class="name" style="width: 70%;">Condition</th>
          </tr>
          <c:forEach items="${requirementsBean.enabledRequirements}" var="req">
            <tr>
              <td style="white-space: nowrap;"><c:out value="${req.parameterNameWithPrefix}"/></td>
              <td>
                <admin:requirementValue requirementType="${req.type}" parameterValue="${req.parameterValue}"/>
              </td>
            </tr>
          </c:forEach>
        </table>
      </div>
      </c:if>

    </div>

</div>
