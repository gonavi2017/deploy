<%--
  ~ Copyright 2000-2015 JetBrains s.r.o.
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="eclipseUpdatePath" type="java.lang.String" scope="request"/>
<jsp:useBean id="eclipsePluginResourcesPath" type="java.lang.String" scope="request"/>

<style type="text/css">
    p.eclipse {
        background-image: url("<c:url value="${eclipsePluginResourcesPath}"/>img/eclipse-logo.svg");
        background-repeat: no-repeat;
        background-size: 17px;
    }
</style>
<p class="toolTitle eclipse">Eclipse Plugin<bs:help style="display:inline;" file="Eclipse Plugin"/></p>
<a showdiscardchangesmessage="false" title="Copy the link location and use it as Eclipse update site" href="<c:url value="${eclipseUpdatePath}"/>" target="_blank">update site link</a>