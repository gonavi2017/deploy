<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ attribute name="jdk" type="jetbrains.buildServer.ideaSettings.Sdk" required="true"
  %><%@ attribute name="pathTitle" type="java.lang.String"
  %><%@ attribute name="patternTitle" type="java.lang.String"
  %><%@ attribute name="libraryKey" type="java.lang.String" %>
<c:if test="${empty libraryKey}"><c:set var="libraryKey" value="${jdk.name}_jdk"/></c:if>
<c:if test="${empty pathTitle}"><c:set var="pathTitle" value="JDK Home"/></c:if>
<c:if test="${empty patternTitle}"><c:set var="patternTitle" value="JDK Jar Files Patterns"/></c:if>
<props:library libraryKey="${libraryKey}" pathName="iprInfo.sdks[${jdk.name}].pathToJdk"
               pathTitle="${pathTitle}" pathValue="${jdk.pathToJdk}"
               patternName="iprInfo.sdks[${jdk.name}].patternsText"
               patternValue="${jdk.patternsText}" patternTitle="${patternTitle}"
               helpAnchor="projectJdk"
    />
<c:if test="${jdk.sdkType == 'JavaSDK'}">
  <input type="hidden" name="iprInfo.sdks[${jdk.name}].externalAnnotationsPatternsText" id="${libraryKey}_extAnnotationsPatterns" value="%teamcity.tool.idea%/lib/jdkAnnotations.jar"/>
</c:if>