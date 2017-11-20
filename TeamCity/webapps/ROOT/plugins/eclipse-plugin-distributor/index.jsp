<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%--
  ~ Copyright 2000-2014 JetBrains s.r.o.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<jsp:useBean id="serverBaseUrl" scope="request" type="java.lang.String"/>
<jsp:useBean id="eclipseUpdatePath" scope="request" type="java.lang.String"/>
<html>
<head>
  <title>Eclipse Plugin -- TeamCity</title>
  <bs:linkCSS>
    /css/main.css
  </bs:linkCSS>
</head>
<body>
<div id="mainContent" class="fixedWidth">
  <p class="note">
    To install the plugin, use "Help | Install New Software..." in Eclipse.
  </p>

  <p class="note">
    <c:set var="url"><c:url value="${serverBaseUrl}${eclipseUpdatePath}"/></c:set>
    Use the following URL as the Eclipse update site: <a href="${url}">${url}</a>
  </p>

  <p class="note">
    See the TeamCity <bs:helpLink file="Eclipse Plugin" anchor="InstallingthePlugin">online help</bs:helpLink> for more details.
  </p>

  <p class="note">
    <button class="btn btn_mini" onclick="window.location='<c:url value="${serverBaseUrl}"/>'">Back to TeamCity</button>
  </p>
</div>
</body>
</html>