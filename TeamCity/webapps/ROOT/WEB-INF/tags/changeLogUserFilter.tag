<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@attribute name="changeLogBean" required="true" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean"
  %><c:set var="curUserId" value="id:${currentUser.id}"
/><forms:select name="userId" id="userDropDown" className="userDropDown actionInput" onchange="BS.ChangeLog.submitFilter();" enableFilter="true"
><option ${changeLogBean.userId == "" ? "selected='selected'" : ''} value="">&lt;All users&gt;</option
><option ${changeLogBean.userId == curUserId ? "selected='selected'" : ''} value="${curUserId}">&lt;me&gt;</option
><c:forEach items="${changeLogBean.sortedUsers}" var="user"
><forms:option value="${user.id}" selected="${changeLogBean.userId == user.id}"><c:out value='${user.extendedName}'/></forms:option
></c:forEach
></forms:select>