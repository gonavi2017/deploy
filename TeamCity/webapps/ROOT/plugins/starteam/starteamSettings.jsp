<%--@elvariable id="serverPaths" type="jetbrains.buildServer.serverSide.ServerPaths"--%>
<%@ page import="java.io.File" %>
<%@ page import="jetbrains.buildServer.buildTriggers.vcs.starteam.StarteamSDKDetector" %>
<%@ page import="jetbrains.buildServer.buildTriggers.vcs.starteam.props.StarteamProps" %>
<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<c:set var="libDir" value='<%=application.getRealPath("WEB-INF/lib")%>'/>
<style type="text/css">
  table.checkoutMode {
    margin: 0;
    padding: 0;
  }

  table.checkoutMode td {
    padding: 0;
    border-bottom: none;
  }

  table.checkoutMode td.label {
    width: 11em;
  }
</style>
<table class="runnerFormTable">
  <c:set var="isSDKPresent"><%=StarteamSDKDetector.detectSDKVersion() != null%></c:set>
  <c:set var="url"><%=StarteamProps.URL%></c:set>
  <c:set var="user"><%=StarteamProps.USERNAME%></c:set>
  <c:set var="password"><%=StarteamProps.PASSWORD%></c:set>
  <c:set var="label"><%=StarteamProps.LABEL%></c:set>
  <c:set var="promoState"><%=StarteamProps.PROMOSTATE%></c:set>

  <c:set var="checkoutMode"><%=StarteamProps.CHECKOUT_MODE%></c:set>
  <c:set var="byLabel"><%=StarteamProps.CHECKOUT_MODE_BY_LABEL%></c:set>
  <c:set var="byPromoState"><%=StarteamProps.CHECKOUT_MODE_BY_PROMOSTATE%></c:set>
  <c:set var="head"><%=StarteamProps.CHECKOUT_MODE_HEAD%></c:set>

  <c:set var="eolConversion"><%=StarteamProps.EOL_CONVERSION%></c:set>
  <c:set var="asIs"><%=StarteamProps.EOL_CONVERSION_AS_IS%></c:set>
  <c:set var="patformDefault"><%=StarteamProps.EOL_CONVERSION_PLATFORM_DEFAULT%></c:set>

  <c:set var="pathBuildingMethod"><%=StarteamProps.PATH_BUILDING_METHOD%></c:set>
  <c:set var="byFolderName"><%=StarteamProps.PATH_BUILDING_METHOD_BY_FOLDER_NAME%></c:set>
  <c:set var="byWorkingFolderName"><%=StarteamProps.PATH_BUILDING_METHOD_BY_WORKING_FOLDER_NAME%></c:set>

  <c:set var="changeDetectionPolicy"><%=StarteamProps.CHANGE_DETECTION_POLICY%></c:set>
  <c:set var="cdpAuto"><%=StarteamProps.CHANGE_DETECTION_POLICY_AUTO%></c:set>

  <c:set var="fileSeparator"><%=File.separator%></c:set>

  <l:settingsGroup title="Starteam Connection Settings">
  <c:if test="${not isSDKPresent}">
  <tr>
    <td colspan="2">
      <div class="icon_before icon16 attentionComment">
        <font color='red'>StarTeam integration could not find StarTeam SDK class library.</font>
        <br><br>
        This file can be found at &lt;StarTeam SDK location&gt;${fileSeparator}lib.
        It is named <strong>starteam##.jar</strong> where <strong>##</strong> are digits corresponding to SDK version.
        Copy this file into &apos;${libDir}&apos; folder and restart TeamCity.
        <br><br>
        If you have no StarTeam SDK installed you can find the related information on its <a href='http://starteam.borland.com/starteam/sdk.asp' target="_blank" showdiscardchangesmessage="false">site</a>.
      </div>
    </td>
  </tr>
  </c:if>
  <tr>
    <th><label for="${url}">URL: <l:star/></label></th>
    <td>
      <props:textProperty name="${url}" className="longField" />
      <span class="smallNote">example: "starteam://host:49201/Project/View/Folder1/Folder2".<br>
        The name of the default view is the same as the project name.</span>
      <span class="error" id="error_${url}"></span>
    </td>
  </tr>
  <tr>
    <th><label for="${user}">Username: <l:star/></label></th>
    <td>
      <props:textProperty name="${user}" className="longField" />
      <span class="error" id="error_${user}"></span>
    </td>
  </tr>
  <tr>
    <th><label for="${password}">Password: <l:star/></label></th>
    <td>
      <props:passwordProperty name="${password}" className="longField" />
      <span class="smallNote">must not contain '@' character</span>
      <span class="error" id="error_${password}"></span>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th>
      <label for="${eolConversion}">EOL conversion:</label>
    </th>
    <td>
      <props:selectProperty name="${eolConversion}" enableFilter="true" className="longField">
        <props:option value="${asIs}" selected="${propertiesBean.properties[eolConversion] == asIs
                                          or empty propertiesBean.properties[eolConversion]}">As stored in repository</props:option>
        <props:option value="${patformDefault}" selected="${propertiesBean.properties[eolConversion] == patformDefault}">Agent's platform default</props:option>
      </props:selectProperty>
    </td>
  </tr>
  <tr class="advancedSetting">
    <th>
      <label for="${pathBuildingMethod}">Directory naming:</label>
    </th>
    <td>
      <props:selectProperty name="${pathBuildingMethod}" enableFilter="true" className="longField">
        <props:option value="${byWorkingFolderName}" selected="${propertiesBean.properties[pathBuildingMethod] == byWorkingFolderName
                                          or empty propertiesBean.properties[pathBuildingMethod]}">Using working folders</props:option>
        <props:option value="${byFolderName}" selected="${propertiesBean.properties[pathBuildingMethod] == byFolderName}">Using StarTeam folder names</props:option>
      </props:selectProperty>
    </td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('${label}').disabled = true;
      $('${promoState}').disabled = true;
      BS.VisibilityHandlers.updateVisibility('vcsRootProperties');
    </c:set>
    <th>
      <label for="checkoutMode_${head}">Checkout mode:</label>
    </th>
    <td>
      <props:radioButtonProperty name="${checkoutMode}" id="checkoutMode_${head}" value="${head}"
                                 checked="${propertiesBean.properties[checkoutMode] == head
                                          or empty propertiesBean.properties[checkoutMode]}" onclick="${onclick}"/>
      <label for="checkoutMode_${head}">tip revision</label>
    </td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('${promoState}').disabled = true;
      $('${label}').disabled = false;
      $('${label}').focus();
      BS.VisibilityHandlers.updateVisibility('vcsRootProperties');
    </c:set>
    <th>
    </th>
    <td>
      <table class="checkoutMode">
        <tr>
          <td class="label">
            <props:radioButtonProperty name="${checkoutMode}" id="checkoutMode_${label}" value="${byLabel}"
                                       checked="${propertiesBean.properties[checkoutMode] == byLabel}" onclick="${onclick}"/>
            <label for="checkoutMode_${label}">by view label:</label>
          </td>
          <td>
            <props:textProperty name="${label}" size="30" disabled="${propertiesBean.properties[checkoutMode] != byLabel}" className="mediumField"/>
          </td>
        </tr>
      </table>
      <span class="error" id="error_${label}"></span>
    </td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('${label}').disabled = true;
      $('${promoState}').disabled = false;
      $('${promoState}').focus();
      BS.VisibilityHandlers.updateVisibility('vcsRootProperties');
    </c:set>
    <th>
    </th>
    <td>
      <table class="checkoutMode">
        <tr>
          <td class="label">
            <props:radioButtonProperty name="${checkoutMode}" id="checkoutMode_${promoState}" value="${byPromoState}"
                                       checked="${propertiesBean.properties[checkoutMode] == byPromoState}" onclick="${onclick}"/>
            <label for="checkoutMode_${promoState}">by promotion state:</label>
          </td>
          <td>
            <props:textProperty name="${promoState}" size="30" disabled="${propertiesBean.properties[checkoutMode] != byPromoState}" className="mediumField"/>
          </td>
        </tr>
      </table>
      <span class="error" id="error_${promoState}"></span>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <span class="smallNote">
        Please note that when checkout mode is set to "by view label" or "by promotion state", no change detection is possible.
        In this case no triggering by changes is done even if you set it.
        Also, each time a build is triggered the full checkout is performed.
      </span>
    </td>
  </tr>

  <props:hiddenProperty name="changeDetectionPolicy"/>

  </l:settingsGroup>

</table>
