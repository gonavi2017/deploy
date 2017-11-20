<%--
  ~ Copyright (c) 2006, JetBrains, s.r.o. All Rights Reserved.
  --%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:viewWorkingDirectory />

<c:choose>
  <c:when test="${empty propertiesBean.properties['use.custom.script']}">
    <div class="parameter">
      Command executable: <props:displayValue name="command.executable" emptyValue="not specified"/>
    </div>
    <div class="parameter">
      Command parameters: <props:displayValue name="command.parameters" emptyValue="not specified"/>
    </div>
  </c:when>
  <c:otherwise>
    <div class="parameter">
      Custom script: <props:displayValue name="script.content" emptyValue="<empty>" showInPopup="true" popupTitle="Script content" popupLinkText="view script content"/>
    </div>
  </c:otherwise>
</c:choose>
