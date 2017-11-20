<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="sequenceBuildInfo" type="jetbrains.buildServer.controllers.promotionGraph.SequenceBuildInfo" scope="request"/>

<c:if test="${empty buildPromotion}">
  Cannot find build data, it seems that build is already deleted.
  <script language="text/javascript">
    BS.StopBuildDialog.handleBuildNotFound();
  </script>
</c:if>
<c:if test="${not empty buildPromotion}">
<jsp:useBean id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion" scope="request"/>

<c:if test="${not buildPromotion.partOfBuildChain or buildPromotion.numberOfDependedOnMe == 0}">
<c:if test="${(not buildIsInQueue or buildIsInQueue == false) and (not empty operationKind && operationKind == '2')}">
  <div id="reAddSection">
    <forms:checkbox name="readd" id="stopBuildReadd"/><label for="stopBuildReadd">Re-add build to the queue</label>
    <br/>
  </div>
</c:if>
</c:if>
<c:if test="${buildPromotion.partOfBuildChain}">

<br/>
This build is part of a build chain. <bs:help file="Build+Chain" />

<c:set var="buildsToShow" value="${not empty operationKind && operationKind == '3' ?
                                   sequenceBuildInfo.buildsToRemove : sequenceBuildInfo.buildsToStop}"/>


<c:choose>
  <c:when test="${not empty buildsToShow and not sequenceBuildInfo.hasUnavailable}">
    <br/>
    Stop<c:if test="${not empty operationKind && operationKind == '3'}"> or remove</c:if> other parts:
    <br/>
    <c:if test="${fn:length(buildsToShow) > 1}">
      <label for="killAll"><forms:checkbox name="killAll" id="killAll"/><strong>All builds</strong></label>
    </c:if>
    <div class="clr"></div>
  </c:when>
  <c:when test="${not empty buildsToShow and sequenceBuildInfo.hasUnavailable}">
    <!--You may also want to stop the following builds from the sequence (you don't have access rights for all the builds):-->
    <div class="icon_before icon16 attentionComment">You don't have access rights to see some of its parts.</div>
    Select builds to stop:
    <br/>
  </c:when>
  <c:when test="${empty buildsToShow and sequenceBuildInfo.hasUnavailable}">
    <div class="icon_before icon16 attentionComment">You don't have access rights to see its other parts.</div>
  </c:when>
</c:choose>


<c:forEach items="${buildsToShow}" var="buildInfo">
  <c:set var="canKill" value="${not empty operationKind && operationKind == '3' ?
                                          buildInfo.canRemove : buildInfo.canStop}"/>

  <c:if test="${canKill}">
    <forms:checkbox id="bi${buildInfo.id}" name="kill" value="${buildInfo.promotion.id}" checked="${buildInfo.checked}"/>
  </c:if>
  <c:if test="${not canKill}">
    <forms:checkbox name="" className="checkboxPlaceholder"/>
  </c:if>

  <bs:queueDependencyState dependency="${buildInfo.promotion}"/>
</c:forEach>



</c:if>
  <c:if test="${not empty operationKind && operationKind == '3'}">
    <div id="leaveStatisticData">
      <forms:checkbox id="statsCB" name="stats"/><label for="statsCB">Leave statistic data</label>
    </div>
  </c:if>
</c:if>