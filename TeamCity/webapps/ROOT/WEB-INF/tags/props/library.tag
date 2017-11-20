<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ attribute name="libraryKey" type="java.lang.String" required="true"
  %><%@ attribute name="pathName" type="java.lang.String" required="true"
  %><%@ attribute name="pathTitle" type="java.lang.String" required="true"
  %><%@ attribute name="pathValue" type="java.lang.String" required="true"
  %><%@ attribute name="patternName" type="java.lang.String" required="true"
  %><%@ attribute name="patternValue" type="java.lang.String" required="true"
  %><%@ attribute name="patternTitle" type="java.lang.String" required="true"
  %><%@ attribute name="helpAnchor" type="java.lang.String" required="true"
  %>
<label for="${libraryKey}_path" style="width: 11em;">${pathTitle}: <bs:help file="IntelliJ+IDEA+Project" anchor="${helpAnchor}"/></label>
<input type="text" name="${pathName}" id="${libraryKey}_path" value="${pathValue}" class="textProperty libraryPath"/>
<span class="error" id="error_${libraryKey}_path"></span>

<props:textarea name="${libraryKey}_pattern" textAreaName="${patternName}" value="${patternValue}"
                linkTitle="${patternTitle}" cols="30" rows="3" style="margin-top: 5px;"  className="longField"/>
