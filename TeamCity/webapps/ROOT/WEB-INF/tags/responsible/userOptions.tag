<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="user" uri="/WEB-INF/functions/user"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@attribute name="currentUser" type="jetbrains.buildServer.users.User" required="true"
  %><%@attribute name="selectedUser" type="jetbrains.buildServer.users.User" required="true"
  %><%@attribute name="potentialResponsibles" type="java.util.List" required="true"
  %><%@attribute name="allowNoResponsible" type="java.lang.Boolean" required="false" %>
<c:if test="${allowNoResponsible}">
  <option value="" <c:if test="${empty selectedUser}">selected</c:if>>None</option>
</c:if>
<option value="${currentUser.id}" <c:if test="${empty selectedUser or currentUser.id == selectedUser.id}">selected</c:if>>me</option>
<optgroup label="Committers for the last 5 days">
  <c:forEach items="${potentialResponsibles}" var="user">
    <forms:option value="${user.id}" selected="${not empty selectedUser and user.id == selectedUser.id and currentUser.id != selectedUser.id}"><bs:fullUsername user="${user}"/></forms:option>
  </c:forEach>
</optgroup>
<optgroup label="All registered users">
  <c:forEach items="${user:getAllUsers()}" var="user">
    <c:set var="contains" value="false" />
    <c:forEach items="${potentialResponsibles}" var="potentialResponsible">
      <c:if test="${potentialResponsible.id eq user.id}">
        <c:set var="contains" value="true" />
      </c:if>
    </c:forEach>
    <c:if test="${not contains}">
      <forms:option value="${user.id}" selected="${not empty selectedUser and user.id == selectedUser.id and currentUser.id != selectedUser.id}"><bs:fullUsername user="${user}"/></forms:option>
    </c:if>
  </c:forEach>
</optgroup>
