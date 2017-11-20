<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="basic" type="jetbrains.buildServer.clouds.amazon.parameters.AmazonBasicOptions" scope="request"/>
<jsp:useBean id="cons" class="jetbrains.buildServer.clouds.amazon.parameters.AmazonConstants"/>
<jsp:useBean id="cloudWebCons" class="jetbrains.buildServer.clouds.server.web.CloudWebConstants"/>
<jsp:useBean id="refreshablePath" class="java.lang.String" scope="request"/>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="endpointsBean" scope="request" type="java.util.Collection<com.intellij.openapi.util.Pair<java.lang.String,java.lang.String>>"/>
<jsp:useBean id="agentPools" scope="request" type="java.util.Collection<jetbrains.buildServer.serverSide.agentPools.AgentPool>"/>
<jsp:useBean id="prefetchOnLoad" scope="request" type="java.lang.Boolean"/>
<jsp:useBean id="serverIamRole" scope="request" type="java.lang.String"/>

<c:set var="refreshUrl"><c:url value="${refreshablePath}"/></c:set>
<%--@elvariable id="resPath" type="java.lang.String"--%>
</table>

<script type="text/javascript">
  BS.LoadStyleSheetDynamically("<c:url value='${resPath}amazon-settings.css'/>");
</script>

<c:set var="EC2Link"><a href="https://aws-portal.amazon.com/gp/aws/developer/account/index.html?ie=UTF8&action=access-key" target="_blank">Amazon Web Services Site</a></c:set>
<table class="runnerFormTable">
  <c:if test="${not empty serverIamRole}">
    <tr>
      <th><label for="${cons.useInstanceIamRole}">Use instance IAM role: <l:star/></label></th>
      <td>
        <props:checkboxProperty name="${cons.useInstanceIamRole}" onclick="BS.Clouds.AmazonEC2.updateUseInstanceIamRole();"/>
        <span class="smallNote">Please use this option if the instance is granted with IAM role.</span>
      </td>
    </tr>
  </c:if>
<tr class="credentials-tr">
  <th><label for="secure:${cons.accessIdKey}">Access key ID: <l:star/></label></th>
  <td><props:textProperty name="secure:${cons.accessIdKey}" className="longField"/>
    <span id="error_secure:${cons.accessIdKey}" class="error"></span>
    <span class="smallNote">Your Amazon account Access Key ID. View your access keys at ${EC2Link}</span>
  </td>
</tr>

<tr class="credentials-tr">
  <th><label for="secure:${cons.secretKey}">Secret access key: <l:star/></label></th>
  <td><props:passwordProperty name="secure:${cons.secretKey}" className="longField"/>
    <span id="error_secure:${cons.secretKey}" class="error"></span>
    <span class="smallNote">Your Amazon account Secret Access Key. View your access keys at ${EC2Link}</span>
  </td>
</tr>

<tr>
  <th><label for="${cons.endpointUrl}">Region:</label></th>
  <td>
    <props:selectProperty name="${cons.endpointUrl}" className="longField" onchange="BS.Clouds.AmazonEC2.disableRefreshableElements();" enableFilter="true">
      <c:forEach var="region" items="${endpointsBean}">
        <props:option value="${region.second}"
        ><c:out value="${region.first}"
        /></props:option>
      </c:forEach>
    </props:selectProperty>
    <span id="error_${cons.endpointUrl}" class="error"></span>
  </td>
</tr>

<tr>
  <th><label for="${cons.runningInstancesLimit}">Maximum instances count:</label></th>
  <td><props:textProperty name="${cons.runningInstancesLimit}"/>
    <span id="error_${cons.runningInstancesLimit}" class="error"></span>
    <span class="smallNote">Maximum number of instances that can be started. Use blank to have no limit</span>
  </td>
</tr>
</table>

<div class="buttonsWrapper">
  <span class="error" id="error_${cons.notCheckedId}"></span>
  <span class="error" id="error_${cons.syncFailedId}"></span>
  <span class="error" id="error_fetch_data"></span>

  <div>
    <forms:button id="amazonRefreshableParametersButton" onclick="return BS.Clouds.AmazonEC2.refreshProfilesOptions(false);">Check connection / Fetch parameter values</forms:button>


    <span id="amazonRefreshableParametersLoadingWrapper" class="hidden"><forms:progressRing id="amazonRefreshableParametersLoading" className="progressRingInline"/> <span id="amazonRefreshableParametersLoadingNote">Fetching parameter values from Amazon AWS...</span></span>
    <props:hiddenProperty name="${cons.notCheckedId}" value="true"/>
  </div>
</div>

<div class="buttonsWrapper">
  <div class="imagesTableWrapper hidden">
    <table id="amazonImagesTable" class="settings imagesTable hidden">
      <tbody>
      <tr>
        <th class="name">Source</th>
        <th class="name">Instance Type</th>
        <th class="name">VPC</th>
        <th class="name">Key Pair</th>
        <th class="name">Spot instance</th>
        <th class="name">Max #</th>
        <th class="name" colspan="2"></th>
      </tr>
      </tbody>
    </table>
    <%--<props:hiddenProperty name="images_data"/>--%>
    <%--<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>--%>
    <%--<c:set var="imagesData" value="${propertiesBean.properties['images_data']}"/>--%>
    <c:set var="sourceImagesJson" value="${propertiesBean.properties['source_images_json']}"/>
    <input type="hidden" class="jsonParam" name="prop:source_images_json" id="source_images_json" value="<c:out value='${sourceImagesJson}'/>"/>
    <input type="hidden" id="initial_images_list"/>
  </div>
  <forms:addButton title="Add image" id="amazonShowDialogButton">Add image</forms:addButton>
</div>

<bs:dialog dialogId="AmazonImageDialog" title="Edit Image" closeCommand="BS.AmazonImageDialog.close()"
           dialogClass="AmazonImageDialog" titleId="AmazonDialogTitle">
  <table class="runnerFormTable">
    <tr>
      <th>
        <span id="label_${cons.sourceId}">Source:</span><l:star/>
      </th>
      <td>
        <div>
          <select class="inline-block longField configParam" id="${cons.sourceId}" data-err-id="${cons.sourceId}">

          </select>
        </div>
        <span class="smallNote">AMI Image or EBS Instance.</span>
        <c:set var="note">
          List of Amazon machine image ids (ami-) or EBS instance ids (i-) with preinstalled build agent
          <bs:help file="Setting+Up+TeamCity+for+Amazon+EC2"/>separated by comma, space or new line
        </c:set>
        <span class="error option-error option-error_${cons.sourceId}"></span>
      </td>
    </tr>
    <tr id="tr_${cons.sourceId}-custom" class="hidden">
      <th><label for="${cons.sourceId}-custom">Public AMI:</label></th>
      <td><input type="text" id="${cons.sourceId}-custom" class="longField configParam"/>
        <span id="error_${cons.sourceId}-custom" class="error option-error option-error_${cons.sourceId}-custom"></span>
        <span class="smallNote">Please provide a public AMI name</span>
      </td>
    </tr>
    <tr class="advancedSetting">
      <th><label for="${cons.imageNamePrefix}">Agent name prefix:</label></th>
      <td><input type="text" id="${cons.imageNamePrefix}" class="longField configParam"/>
        <span id="error_${cons.imageNamePrefix}" class="error option-error option-error_${cons.imageNamePrefix}"></span>
        <span class="smallNote">If no or incorrect prefix provided, default value <strong>EC2</strong> will be used</span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.subnetIdKey}">VPC subnet ID:</label></th>
      <td>
        <select id="${cons.subnetIdKey}" class="longField configParam" onchange="BS.Clouds.AmazonEC2.updateVPCSubnets();">
<%--
          <c:choose>
            <c:when test="${not empty propertiesBean.properties[cons.subnetIdKey]}">
              <props:option value="${propertiesBean.properties[cons.subnetIdKey]}" selected="${true}"><c:out value="${propertiesBean.properties[cons.subnetIdKey]}"/></props:option>
            </c:when>
            <c:otherwise>
              <props:option value="" selected="${true}">(no VPC)</props:option>
            </c:otherwise>
          </c:choose>
--%>
        </select>
        <span id="error_${cons.subnetIdKey}" class="error"></span>
        <span class="smallNote">Subnet Id of <a href="http://aws.amazon.com/vpc/" target="_blank">Amazon Virtual Private Cloud (VPC)</a> subnet id</span>
        <div id="${cons.autoAssignPublicIp}">
          <c:if test="${cons.allowAutoIp4VPC}">
            <props:checkboxProperty name="${cons.autoAssignPublicIp}"/>
            <label for="${cons.autoAssignPublicIp}">Auto-assign public ip:</label>
            <span class="smallNote">Auto-assign public ip for instances launched in VPC</span>
          </c:if>
        </div>
      </td>
    </tr>

    <tr class="advancedSetting amiOnly">
      <th><label for="${cons.iamInstanceProfile}">IAM profile:<bs:help file="Setting+Up+TeamCity+for+Amazon+EC2#SettingUpTeamCityforAmazonEC2-IAMprofiles"/></label></th>
      <td>
    <span class='info hidden' id='iam-profile-disabled'>IAM profiles configuration is not available.
      <span class="smallNote">Additional permissions must be granted to use IAM profiles.<bs:help file="Setting+Up+TeamCity+for+Amazon+EC2#SettingUpTeamCityforAmazonEC2-IAMprofiles"/></span>
    </span>
        <select id="${cons.iamInstanceProfile}" class="longField configParam">
<%--
          <c:choose>
            <c:when test="${not empty propertiesBean.properties[cons.iamInstanceProfile]}">
              <props:option value="${propertiesBean.properties[cons.iamInstanceProfile]}" selected="${true}"><c:out
                  value="${propertiesBean.properties[cons.iamInstanceProfile]}"/></props:option>
            </c:when>
            <c:otherwise>
              <props:option value="" selected="${true}">(no IAM profile)</props:option>
            </c:otherwise>
          </c:choose>
--%>
        </select>
        <span id="error_${cons.iamInstanceProfile}" class="error"></span>
      </td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="${cons.availabilityZone}">Availability zone:</label></th>
      <td>
        <div id="availabilityZoneContainerVPC">
          VPC Availability zone will be used: <strong><span id="amazonVPCZone"></span></strong>
        </div>
        <div id="availabilityZoneContainerNoVPC">
          <select id="${cons.availabilityZone}" class="longField configParam">
<%--
            <c:if test="${not empty propertiesBean.properties[cons.availabilityZone]}">
              <props:option value="${propertiesBean.properties[cons.availabilityZone]}" selected="${true}"><c:out
                  value="${propertiesBean.properties[cons.availabilityZone]}"/></props:option>
            </c:if>
--%>
          </select>
          <span class="smallNote"></span>
          <span id="error_${cons.availabilityZone}" class="error"></span>
        </div>
      </td>
    </tr>

    <tr>
      <th><label for="${cons.keyPairName}">Key pair name: <l:star/></label></th>
      <td>
        <select id="${cons.keyPairName}" class="longField configParam">
<%--
          <c:if test="${not empty propertiesBean.properties[cons.keyPairName]}">
            <props:option value="${propertiesBean.properties[cons.keyPairName]}" selected="${true}"><c:out value="${propertiesBean.properties[cons.keyPairName]}"/></props:option>
          </c:if>
--%>
        </select>
        <span id="error_${cons.keyPairName}" class="error option-error option-error_${cons.keyPairName}"></span>
      </td>
    </tr>

    <tr>
      <th><label for="${cons.instanceType}">Instance type:</label></th>
      <td>
        <select id="${cons.instanceType}" class="longField configParam">
          <c:forEach var="ep" items="${basic.instanceTypes}">
            <option value="${ep.instanceType}"
                    data-ebs-optimized="<c:out value="${ep.ebsOptimizedByDefault}"/>"
                    data-ebs-customizable="<c:out value="${ep.ebsOptimizationCustomizable}"/>">
              <c:out value="${ep.name}"/>
            </option>
          </c:forEach>
        </select>
        <span class="smallNote">See <a href="http://aws.amazon.com/ec2/instance-types/" target="_blank">Amazon EC2 Instances</a> for details</span>
        <span id="error_${cons.instanceType}" class="error"></span>
        <span id="span-${cons.ebsOptimized}">
          <input type="checkbox" id="${cons.ebsOptimized}" class="configParam"/>
          EBS optimized
        </span>
      </td>
    </tr>


    <tr>
      <th><label for="securityGroupsUI">Security groups: <l:star/></label></th>
      <td>
        <input type="hidden" id="${cons.securityGroupIdsKey}"/>
        <select id="securityGroupsUI" class="longField" multiple="multiple" style="height:10em;">
        </select>
        <span id="error_${cons.securityGroupIdsKey}" class="error option-error option-error_${cons.securityGroupIdsKey}"></span>
        <span id="error_${cons.securityGroupsKey}" class="error"></span>
      </td>
    </tr>
    <tr class="advancedSetting amiOnly hidden">
      <th><label for="${cons.userScript}">User script:</label></th>
      <td>
        <props:multilineProperty expanded="${false}" name="${cons.userScript}" rows="10" cols="58" linkTitle="Edit the script content" className="longField"/>
        <span id="error_${cons.userScript}" class="error option-error option-error_${cons.userScript}"></span>
        <span class="smallNote">Script to be executed on OS start. Size limit - ${cons.maxUserScriptLength/1024}kb.
          <a target="_blank" href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html">More information</a>.
        </span>
      </td>
    </tr>
    <tr class="advancedSetting amiOnly hidden">
      <th>Spot instances:</th>
      <td>
        <input type="checkbox" id="${cons.useSpotInstances}" onclick="BS.Clouds.AmazonEC2.updateSpotPricingField();" class="configParam" value="true"/> <label for="${cons.useSpotInstances}">Use spot instances</label>
        <div id="spotInstancePriceDiv">
          <label for="${cons.spotInstancePrice}">Bid price: $</label><input type="text" id="${cons.spotInstancePrice}"/>
          <span id="error_${cons.spotInstancePrice}" class="error option-error option-error_${cons.spotInstancePrice}"></span>
        </div>
      </td>
    </tr>

    <tr class="advancedSetting amiOnly hidden">
      <th><label for="${cons.userTags}">Instance tags:</label></th>
      <td><input type="text" id="${cons.userTags}" class="configParam longField"/>
        <span id="error_${cons.userTags}" class="error option-error option-error_${cons.userTags}"></span>
        <span class="smallNote">Format: <strong>&lt;key1&gt;=&lt;value1&gt;,&lt;key2&gt;=&lt;value2&gt;</strong> <br/>Please also consider Amazon
          <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-restrictions">tags restrictions</a></span>
      </td>
    </tr>

    <tr class="advancedSetting amiOnly hidden">
      <th><label for="${cons.imageInstancesLimit}">Max instances:</label></th>
      <td><input type="text" id="${cons.imageInstancesLimit}" class="configParam longField"/>
        <span id="error_${cons.imageInstancesLimit}" class="error option-error option-error_${cons.imageInstancesLimit}"></span>
        <span class="smallNote">Leave blank to have no limit</span>
      </td>
    </tr>

    <tr class="advancedSetting">
      <th><label for="${cloudWebCons.agentPoolIdField}">Agent pool:<bs:help file="Agent+Pools"/></label></th>
      <td>
        <select id="${cloudWebCons.agentPoolIdField}" class="longField configParam">
          <c:forEach var="ap" items="${agentPools}">
            <props:option value="${ap.agentPoolId}"><c:out value="${ap.name}"/></props:option>
          </c:forEach>
        </select>
        <span id="error_${cloudWebCons.agentPoolIdField}" class="error"></span>
        <span class="smallNote">The agents will be assigned to the selected pool</span>
      </td>
    </tr>
  </table>

  <admin:showHideAdvancedOpts containerId="AmazonImageDialog" optsKey="buildTypeVcsSettings"/>
  <admin:highlightChangedFields containerId="AmazonImageDialog"/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Add" id="addImageButton"/>
    <forms:button title="Cancel" id="amazonCancelDialogButton">Cancel</forms:button>
  </div>
</bs:dialog>

<bs:dialog dialogId="RemoveImageDialog" title="Confirm Removing" closeCommand="BS.RemoveImageDialog.close()"
           dialogClass="RemoveImageDialog" titleId="RemoveImageDialogTitle">
  <input type="hidden" id="removeSourceIds"/>

  <div>
    <label for="images2Remove">You removed the following sources: </label><ul id="images2Remove"></ul>
  </div>
  <div id="terminateInstancesDiv">
    <input type="checkbox" id="terminateInstances" class="configParam" value="true"/>
    <label for="terminateInstances">Do you want to terminate the following instances:</label>
    <ul id="instances2Terminate">

    </ul>
  </div>
  <div class="popupSaveButtonsBlock">
    <forms:submit label="Remove" id="removeImageConfirmButton"/>
    <forms:button title="Cancel" id="removeImageCancelButton">Cancel</forms:button>
  </div>
</bs:dialog>

<script type="text/javascript">
  $j('#amazonShowDialogButton').attr('disabled', 'disabled');
  $j.ajax({
            url: "<c:url value="${resPath}amazon-settings.js"/>",
            dataType: "script",
            success: function() {
              BS.Clouds.AmazonEC2.updateUseInstanceIamRole();
              BS.Clouds.AmazonEC2.init('${prefetchOnLoad}', '${refreshUrl}');
            },
            cache: true
          });
</script>

<table class="runnerFormTable" style="margin-top: 3em;">