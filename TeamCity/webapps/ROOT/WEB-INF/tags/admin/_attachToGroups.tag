<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="attachToGroupsBean" required="true" type="jetbrains.buildServer.controllers.admin.groups.AttachToGroupsBean"
    %><%@attribute name="formId" required="true" %>
<c:set var="name"><c:choose>
  <c:when test="${attachToGroupsBean.attachNewGroup}">the new group</c:when>
  <c:when test="${attachToGroupsBean.attachUsers and fn:length(attachToGroupsBean.usersToAttach) > 1}">the <strong><c:out value="${fn:length(attachToGroupsBean.usersToAttach)}"/></strong> selected users</c:when>
  <c:when test="${attachToGroupsBean.attachUsers}"><strong><c:out value="${attachToGroupsBean.firstUserToAttach.descriptiveName}"/></strong></c:when>
  <c:otherwise><strong><c:out value="${attachToGroupsBean.groupToAttach.name}"/></strong></c:otherwise>
</c:choose></c:set>
<c:set var="entries" value="<%=attachToGroupsBean.getAvailableGroups().entrySet()%>"/>
<c:choose>
  <c:when test="${attachToGroupsBean.numberOfGroups == 0}">
    <div class="attachToNote">There are no groups.</div>
  </c:when>
  <c:when test="${attachToGroupsBean.superTopGroup}">
    <div class="attachToNote">This is a top level group which contains all other groups. This group cannot be attached to other groups.</div>
    <div class="attachToGroupsContainer custom-scroll">
      <bs:printTree treePrinter="${attachToGroupsBean.readOnlyGroupTree}"/>
    </div>
  </c:when>
  <c:when test="${empty entries}">
    <div class="attachToNote">You do not have enough permissions to change this group parents.</div>
    <div class="attachToGroupsContainer custom-scroll">
      <bs:printTree treePrinter="${attachToGroupsBean.readOnlyGroupTree}"/>
    </div>
  </c:when>
  <c:otherwise>
    <div class="attachToNote">Select parent group(s) for ${name}:</div>
    <c:if test="${not empty attachToGroupsBean.groupToAttach and attachToGroupsBean.numberOfGroups > 1 + fn:length(entries)}">
      <bs:smallNote>Note: subgroups of ${name} are not shown</bs:smallNote>
    </c:if>
    <div class="attachToGroupsContainer custom-scroll">
      <ul class="availableGroupsList">
        <c:forEach items="${entries}" var="groupEntry">
          <c:set var="group" value="${groupEntry.key}"/>
          <c:set var="id" value="attachTo_${group.key}_${formId}"/>
          <li><forms:checkbox name="attachTo" value="${group.key}" id="${id}" checked="${groupEntry.value}" disabled="${attachToGroupsBean.attachUsers and group.key == 'ALL_USERS_GROUP'}" onclick="this.form.showWarning()"/> <label for="${id}"><c:out value="${group.name}"/> <c:if test="${not empty group.description}">(<bs:trimWithTooltip maxlength="40">${group.description}</bs:trimWithTooltip>)</c:if></label></li>
        </c:forEach>
      </ul>
    </div>
    <div class="topLevel">
    <c:if test="${not attachToGroupsBean.attachUsers}">
      <a href="#" onclick="$('${formId}').uncheckAll(); return false">Uncheck all</a> to make ${name} a top level group
    </c:if>
    <c:if test="${attachToGroupsBean.attachUsers and fn:length(attachToGroupsBean.usersToAttach) == 1}">
      <a href="#" onclick="$('${formId}').uncheckAll(); return false">Uncheck all</a> to unassign ${name} from all groups
    </c:if>
    </div>
    <c:if test="${not empty attachToGroupsBean.groupToAttach}">
    <c:set var="numAffected" value="${fn:length(attachToGroupsBean.groupToAttach.allUsers)}"/>
    <c:if test="${numAffected > 0}">
    <div class="icon_before icon16 attentionComment" style="display:none;" id="numAffectedWarning_${formId}">
      This operation will affect ${numAffected} <bs:plural txt="user" val="${numAffected}"/>.
    </div>
    </c:if>
    </c:if>
    <span class="error" id="error_attachToGroups_${formId}" style="margin-left: 0;"></span>
    <script type="text/javascript">
      (function() {
        var form = $('${formId}');

        form.getAttachTo = function() {
          return $A(this.elements).filter(function(element) { return element.type=='checkbox' && element.name == 'attachTo'});
        };

        form.uncheckAll = function() {
          var attachToInputs = this.getAttachTo();
          for (var i =0; i<attachToInputs.length; i++) {
            if (attachToInputs[i].disabled) continue;
            attachToInputs[i].checked = false;
          }
        };

        form.showWarning = function() {
          var elem = $('numAffectedWarning_${formId}');
          if (elem) {
            BS.Util.show(elem);
          }
        };
      })();
    </script>
  </c:otherwise>
</c:choose>
