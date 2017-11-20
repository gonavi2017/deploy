<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%>
<%@ variable name-given="restSelectorsDisabled" variable-class="java.lang.Boolean" scope="AT_END"%>
<%@ variable name-given="restProjectPopupCacheDisabled" variable-class="java.lang.Boolean" scope="AT_END"%>
<%@ variable name-given="restProjectPopupCacheStrategy" variable-class="java.lang.String" scope="AT_END"%>
<c:set var="webComponentSupport" value="<%= WebUtil.isWebComponentSupportAware(request) %>"></c:set>
<c:set var="restSelectorsDisabled" value="${intprop:getBoolean('teamcity.ui.restSelectors.disabled') || !webComponentSupport}"/>
<c:set var="restProjectPopupCacheDisabled" value="${intprop:getBoolean('teamcity.restProjectsPopup.cache.disabled')}"/>
<c:set var="restProjectPopupCacheStrategy" value="${intprop:getProperty('teamcity.restProjectsPopup.cache.strategy','lzutf8')}"/>

