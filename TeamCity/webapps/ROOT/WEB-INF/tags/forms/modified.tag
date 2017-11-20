<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="style" required="false" %>
<%@ attribute name="modifiedText" required="false" %>
<%@ attribute name="buttonCaption" required="false" %>
<%@ attribute name="onSave" required="false" %>

<c:set var="id" value="${empty id ? 'modifiedMessage' : id}"/>
<div id="${id}" class="modifiedMessage" style="${style}">
  <div class="messageBody">
    <c:set var="messageBody"><jsp:doBody/></c:set>
    <c:if test="${empty messageBody}">
      <c:set var="messageBody">
        <form action="#" id="${id}Form">
          <span class="messageText"><c:out value="${empty modifiedText ? 'The changes are not yet saved.' : modifiedText}"/></span>
          <input class="btn btn_primary submitButton" type="button" value="${empty buttonCaption ? 'Save' : buttonCaption}" name="save" <c:if test="${not empty onSave}">onclick="${onSave}"</c:if>/>
        </form>
      </c:set>
    </c:if>
    ${messageBody}
  </div>
</div>
