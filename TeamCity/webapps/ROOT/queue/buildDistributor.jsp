<%--@elvariable id="distributor" type="jetbrains.buildServer.serverSide.impl.buildDistribution.BuildDistributor"--%>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %>
<c:set var="pageTitle" value="Build Distributor Details" scope="request"/>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>

<bs:page>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/agentsInfoPopup.css
      /css/buildQueue.css
      /css/filePopup.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/queueLikeSorter.js
      /js/bs/buildQueue.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
        {title: "Build Queue with Distributor Changes", selected: true}
      ];
      BS.topNavPane.setActiveCaption('queue');
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <style type="text/css">
      .info {
        margin-top: 10px;
      }

      .buildDistributor {
        padding-top: 20px;
        width: 100%;
      }

      .buildDistributor thead tr td {
        color: white;
      }

      .orderMark {
        width: 20px;
      }
    </style>
    <authz:authorize allPermissions="CHANGE_SERVER_SETTINGS">
      <jsp:attribute name="ifAccessGranted">

    <div class="info">Actual distributor: ${distributor}</div>
        <%--@elvariable id="orderedQueue" type="java.util.Map<DistributorConfig.Rule,jetbrains.buildServer.controllers.queue.OrderBuildPresenter> "--%>
        <c:forEach items="${orderedQueue}" var="o" varStatus="i">
          <div class="info">${o.key.description}</div>
          <br/>
          <table class="buildDistributor dark borderBottom">
            <thead>
            <tr>
              <td>&nbsp;</td>
              <td>Changes made by distributor</td>
              <td>Tracked<br/> time<br/> in project</td>
              <td>Build type</td>
              <td>Queued build</td>
              <td>Time to start</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${o.value}" var="ob" varStatus="i">
            <tr>
                <%--@elvariable id="ob" type="jetbrains.buildServer.controllers.queue.OrderBuildPresenter"--%>
              <c:set var="queuedBuild" value="${ob.queuedBuildInfo}"/>
                <%--@elvariable id="queuedBuild" type="jetbrains.buildServer.serverSide.impl.QueuedBuildImpl"--%>
              <c:set var="promo" value="${queuedBuild.buildPromotion}"/>
              <c:set var="orderInfo" value="${ob.orderInfo}"/>
              <td class="orderNum">
                #${i.index+1}&nbsp;
              </td>
              <td class="orderMark">
                <c:choose>
                  <c:when test="${not empty orderInfo && i.index<orderInfo.index}">
                    <span style="cursor: pointer; color: #008000;" title="up from ${orderInfo.index+1}">&nbsp;&#8593;</span>
                  </c:when>
                  <c:when test="${not empty orderInfo && i.index>orderInfo.index}">
                    <span style="cursor: pointer; color: red;" title="down from ${orderInfo.index+1}">&nbsp;&#8595;</span>
                  </c:when>
                </c:choose>
              </td>
              <td>
                 <c:if test="${not empty orderInfo}">
                   <bs:printTime time="${orderInfo.buildTime/1000}"/> in <bs:projectLink project="${orderInfo.project}"/>
                 </c:if>
              </td>

              <bs:queuedBuild queuedBuild="${queuedBuild}" showBuildType="true" showNumber="true"/>
            </tr>
        </c:forEach>
      </table>
    </c:forEach>
      </jsp:attribute>
      <jsp:attribute name="ifAccessDenied">
        You don't have permissions to view information on this page
      </jsp:attribute>
    </authz:authorize>

  </jsp:attribute>
</bs:page>
