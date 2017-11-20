<%@ include file="/include.jsp" %>
<jsp:useBean id="status" scope="request" type="jetbrains.buildServer.serverSide.ldap.LdapStatusBean"/>

<bs:linkScript>
  /plugins/ldap/js/ldapStatus.js
</bs:linkScript>
<bs:linkCSS>
  /plugins/ldap/css/ldapStatus.css
</bs:linkCSS>
<bs:refreshable containerId="ldapSectionContainer" pageUrl="${pageUrl}">

<div class="clearfix">
    <form action="#" onsubmit="return false;">
      <input class="submitButton btn" type="submit" value="Synchronize now" id="ldapSubmit"
             <c:if test="${not status.idle}">disabled="disabled"</c:if>
             onclick="LdapTrigger.start();">
      State: <strong><c:out value="${status.state}"/></strong><bs:help file="LDAP+Integration"/>
      <c:if test="${not status.idle and not status.disabled}">
        <span id="ldapProgress"></span>
      </c:if>
    </form>
  <c:if test="${status.idle}">
    <p>
      Last synchronization time:
      <c:set var="lastSync" value="${status.lastSynchronizationTime}"/>
      <span id="ldapTime">
        <c:choose>
          <c:when test="${not status.idle}">
            &nbsp;
          </c:when>
          <c:when test="${lastSync != null}">
            <strong><bs:date value="${lastSync}"/></strong>,
            lasted <strong><bs:printTime time="${status.lastDuration / 1000}" showIfNotPositiveTime="&lt; 1s"/></strong>.
          </c:when>
        </c:choose>
      </span>
    </p>
    <c:set var="nextSync" value="${status.nextSynchronizationTime}"/>
    <c:if test="${status.idle and nextSync != null}">
      <p>Next synchronization is scheduled for: <strong><bs:date value="${nextSync}"/></strong>.</p>
    </c:if>
    <p>
      Last synchronization summary:
      found <b><c:out value="${status.usersInLdapNumber}"/></b> users in LDAP,
            <b><c:out value="${status.usersMatchedNumber}"/></b> are matched with TeamCity users.
    </p>
    <p>
      TeamCity users:
      <c:set var="created" value="${status.usersCreatedNumber > 0}"/>
      <c:set var="deleted" value="${status.usersDeletedNumber > 0}"/>
      <c:set var="updated" value="${status.usersUpdatedNumber > 0}"/>
      <c:choose>
        <c:when test="${created or deleted or updated}">
          <c:if test="${created}"><b><c:out value="${status.usersCreatedNumber}"/></b> created</c:if>
          <c:if test="${created and (updated or deleted)}">, </c:if>
          <c:if test="${updated}"><b><c:out value="${status.usersUpdatedNumber}"/></b> updated</c:if>
          <c:if test="${updated and deleted}">, </c:if>
          <c:if test="${deleted}"><b><c:out value="${status.usersDeletedNumber}"/></b> deleted</c:if>
        </c:when>
        <c:otherwise>
          no users modified.
        </c:otherwise>
      </c:choose>

    <c:if test="${status.hasErrors}">
      <p>
        Encountered <strong><c:out value="${status.lastErrorsNumber}"/></strong> errors during
        users synchronization.
      </p>
      <bs:changeRequest key="status" value="${status}">
        <jsp:include page="errors.jsp"/>
      </bs:changeRequest>
    </c:if>
  </c:if>
  <c:if test="${status.disabled and status.hasErrors}">
    <p>
      Encountered <strong><c:out value="${status.lastErrorsNumber}"/></strong> errors during
      LDAP plugin initialization.
    </p>
    <bs:changeRequest key="status" value="${status}">
      <jsp:include page="errors.jsp"/>
    </bs:changeRequest>
  </c:if>

</div>

<c:choose>
  <c:when test="${not status.idle and not status.disabled}">
    <script type="text/javascript">
      $('ldapProgress').innerHTML = BS.loadingIcon;
      window.setTimeout(function () {
        BS.reload(false, function () {
          $('ldapSectionContainer').refresh();
        });
      }, 2000);
    </script>
  </c:when>
</c:choose>

</bs:refreshable>
