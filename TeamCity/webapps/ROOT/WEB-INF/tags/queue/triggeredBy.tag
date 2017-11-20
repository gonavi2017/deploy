<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@attribute name="queuedBuild" type="jetbrains.buildServer.serverSide.SQueuedBuild" required="true"
  %><%@attribute name="currentUser" type="jetbrains.buildServer.users.SUser" required="true"
  %><%@attribute name="contextProject" type="jetbrains.buildServer.serverSide.SProject" required="false"
  %><c:set var="triggeredBy" value="${queuedBuild.triggeredBy}"
  /><c:set var="personalBuild" value="${queuedBuild.personal}"
  /><c:set var="buildOwner" value="${queuedBuild.buildPromotion.owner}"
  /><c:set var="myBuild" value="${queuedBuild.personal and currentUser == buildOwner}"
  /><c:set var="personalBuildComment">Personal change: <bs:personalBuildComment buildPromotion="${queuedBuild.buildPromotion}"/></c:set
  ><c:set var="text"><jsp:doBody/></c:set
  ><c:set var="triggeredByText"><bs:triggeredByText triggeredBy="${triggeredBy}" hideUser="${personalBuild}"/></c:set
  ><c:if test="${not fn:contains(triggeredByText, '<')}"><c:set var="triggeredByText"><bs:makeBreakable text="${triggeredByText}" regex="[\.,\\/:;@%^]" escape="${false}"/></c:set
  ></c:if><c:set var="content"><span class="triggeredBy__content"><c:choose
  ><c:when test="${not empty text}">${text}</c:when
  ><c:when test="${personalBuild}"
  ><bs:personalBuildPrefix buildPromotion="${queuedBuild.buildPromotion}"/><c:if test="${not empty triggeredByText}">; ${triggeredByText}</c:if></c:when
  ><c:otherwise>${triggeredByText}</c:otherwise
  ></c:choose></span></c:set
  ><c:if test="${empty text and personalBuild}"
  ><c:set var="text">${content}<br/><bs:out resolverContext="${queuedBuild.buildPromotion}" value="${personalBuildComment}"/></c:set
  ><span <bs:tooltipAttrs text="${text}"/> ><bs:personalChangesIcon noTitle="${true}" myChanges="${myBuild}"/></span
  ></c:if><bs:popupControl showPopupCommand="BS.PromoDetailsPopup.showDetailsPopup(this, ${queuedBuild.buildPromotion.id})"
                            hidePopupCommand="BS.PromoDetailsPopup.hidePopup()"
                            stopHidingPopupCommand="BS.PromoDetailsPopup.stopHidingPopup()"
                            controlId="promoDetails:${queuedBuild.buildPromotion.id}">${content}</bs:popupControl>