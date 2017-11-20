<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@

    attribute name="buildData" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="alt" required="false" %><%@
    attribute name="style" required="false" %><%@
    attribute name="attrs" required="false" %><%@
    attribute name="simpleTitle" required="false" type="java.lang.Boolean" %><%@
    attribute name="imgId" required="false" %><%@
    attribute name="imgOnly" required="false"

%><c:set var="personalBuildComment"><c:if test="${buildData.personal and not simpleTitle}"><br/>Personal change: <bs:out resolverContext="${buildData.buildPromotion}"><bs:personalBuildComment buildPromotion="${buildData.buildPromotion}"/></bs:out></c:if></c:set
 ><c:set var="myBuild" value="${buildData.personal and currentUser == buildData.owner}"
/><c:set var="icon_class_modifier_prefix" value="${myBuild ? 'my-' : buildData.personal ? 'personal-' : ''}"
/><c:set var="personalBuildPrefix"><bs:personalBuildPrefix buildPromotion="${buildData.buildPromotion}"/></c:set
 ><c:choose
  ><c:when test="${not buildData.finished}"
    ><c:choose><c:when test="${buildData.buildStatus.successful}"
      ><c:set var="icon_class_modifier" value="running-green-transparent"
      /><c:set var="icon_text" value="Build is running"

      /><c:if test="${buildData.personal}"
         ><c:set var="icon_class_modifier" value="running"
        /><c:set var="icon_text">${personalBuildPrefix} is running${personalBuildComment}</c:set
      ></c:if

    ></c:when
    ><c:otherwise
      ><c:set var="icon_class_modifier" value="running-red-transparent"
     /><c:set var="icon_text" value="Build is failing"

     /><c:if test="${buildData.personal}"
        ><c:set var="icon_class_modifier" value="running-failing"
       /><c:set var="icon_text">${personalBuildPrefix} is failing${personalBuildComment}</c:set
      ></c:if
    ></c:otherwise
    ></c:choose
  ></c:when

  ><c:when test="${not empty buildData.canceledInfo}"
    ><c:set var="icon_class_modifier" value="cancelled"
    /><c:set var="canceled_info"
      ><c:if test="${buildData.canceledInfo.canceledByUser}"
        >by <c:choose><c:when test="${buildData.canceledInfo.userId == currentUser.id}">you</c:when><c:otherwise><bs:userName server="${serverTC}" userId="${buildData.canceledInfo.userId}"/></c:otherwise></c:choose
      ></c:if
      ><c:if test="${not empty buildData.canceledInfo.comment}"> with comment: <c:out value="${buildData.canceledInfo.comment}"/></c:if
    ></c:set
    ><c:set var="icon_text">Build cancelled ${canceled_info}</c:set

    ><c:if test="${buildData.personal}"
      ><c:set var="icon_class_modifier" value="cancelled"
     /><c:set var="icon_text">${personalBuildPrefix} canceled ${canceled_info}${personalBuildComment}</c:set
    ></c:if
  ></c:when

  ><c:when test="${buildData.buildStatus.successful}"
    ><c:set var="icon_class_modifier" value="successful"
   /><c:set var="icon_text" value="Build was successful"

   /><c:if test="${buildData.personal}"
      ><c:set var="icon_class_modifier" value="finished"
     /><c:set var="icon_text">${personalBuildPrefix} was successful${personalBuildComment}</c:set
   ></c:if

    ></c:when
    ><c:when test="${buildData.buildStatus.failed}"
      ><c:set var="icon_class_modifier" value="failed"
     /><c:set var="icon_text" value="Build failed"

     /><c:if test="${buildData.personal}"
        ><c:set var="icon_class_modifier" value="finished-failed"
       /><c:set var="icon_text">${personalBuildPrefix} failed${personalBuildComment}</c:set
      ></c:if

      ><c:if test="${buildData.internalError}"
        ><c:set var="icon_class_modifier" value="red-sign"
       /><c:set var="icon_text">Failed to start build</c:set
      ></c:if

      ><c:if test="${buildData.internalError and buildData.personal}"
        ><c:set var="icon_class_modifier" value="crashed"
       /><c:set var="icon_text">${personalBuildPrefix} failed to start${personalBuildComment}</c:set
      ></c:if
    ></c:when
    ><c:otherwise
      ><c:set var="icon_class_modifier" value="gray"
     /><c:set var="icon_text" value="Unknown status"
   /></c:otherwise
 ></c:choose

><c:if test="${not empty buildData.agentName and empty buildData.canceledInfo and not simpleTitle}"
    ><c:set var="icon_text_add"><br/>Build agent: <bs:agentDetailsFullLink agent="${buildData.agent}"/></c:set
></c:if

><c:if test="${not empty buildData.agentName and empty buildData.canceledInfo and simpleTitle}"
    ><c:set var="icon_text_add">&nbsp;(build agent: <c:out value="${buildData.agentName}"/>)</c:set
></c:if

><c:if test="${not empty alt}"
    ><c:set var="icon_text" value="${alt}${icon_text_add}"
/></c:if

><c:if test="${empty alt}"
    ><c:set var="icon_text" value="${icon_text}${icon_text_add}"
/></c:if

><c:set var="containerId" value="dataHover_${buildData.buildId}"

/><span class="icon icon16 buildDataIcon build-status-icon build-status-icon_${icon_class_modifier_prefix}${icon_class_modifier}" id="${imgId}" <c:if test="${not empty style}">style="${style}" </c:if> <bs:tooltipAttrs containerId="${containerId}"
                                                                                                                                                                                                     useHtmlTitle="${simpleTitle}"/> ></span><c:if test="${not imgOnly}"
    ><div id="${containerId}" style="display: none;">${icon_text}</div></c:if>