<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
%><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotionEx"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><c:if test="${afn:permissionGrantedForProjectWithId(buildPromotion.projectId, 'TAG_BUILD') && afn:permissionGrantedGlobally('CHANGE_OWN_PROFILE')}"><jsp:doBody/></c:if>
