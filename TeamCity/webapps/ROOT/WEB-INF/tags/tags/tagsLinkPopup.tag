<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
  %><%@ attribute name="buildPromotion" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
  %>
<c:set var="id" value="${buildPromotion.id}"/>
<bs:popup_static controlId="tags:${id}" popup_options="shift:{x:-20, y:20}" popupClass="tagsPopup">
  <jsp:attribute name="content">
    <c:set var="editTagsButton">&nbsp;<tags:editTagsLink className="btn btn_mini" buildPromotion="${buildPromotion}" doNotAddAvailableTags="${true}">Edit</tags:editTagsLink></c:set>
    <tags:showBuildPromotionTags buildPromotion="${buildPromotion}" hidePrivateTags="${true}">
      <jsp:attribute name="onNoTags">There are no tags${editTagsButton}</jsp:attribute>
      <jsp:attribute name="afterTags">${editTagsButton}</jsp:attribute>
    </tags:showBuildPromotionTags>
  </jsp:attribute>
  <jsp:body><jsp:doBody/></jsp:body>
</bs:popup_static>