<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"
%><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><%@attribute name="containerId" required="true"
%><%@attribute name="optsKey" required="true" %>
<c:if test="${intprop:getBooleanOrTrue('teamcity.ui.showAdvancedOptionsToggle')}">
<div class="advancedSettingsToggle" id="advancedSettingsToggle_${containerId}"><i class="icon-wrench"></i><a href="javascript://" showdiscardchangesmessage="false">Show advanced options</a></div>
<c:set var="propKey">showAdvancedOpts_<c:out value="${optsKey}"/></c:set>
<c:set var="showAdvanced" value="${ufn:booleanPropertyValue(currentUser, propKey)}"/>
<script type="text/javascript">
  BS.bindShowHideAdvancedOptions('${containerId}', '${propKey}', ${showAdvanced});
</script>
</c:if>
