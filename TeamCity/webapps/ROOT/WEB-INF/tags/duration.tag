<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="buildData" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><span class="progressDuration" title="Build duration">(<span id="build:${buildData.buildId}:duration"><c:out><jsp:attribute name="value"><bs:printTime
  time="${buildData.duration}"/></jsp:attribute></c:out></span>)</span>
