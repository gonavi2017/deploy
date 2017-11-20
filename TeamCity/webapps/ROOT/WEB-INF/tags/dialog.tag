<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="dialogId" type="java.lang.String" required="true" %><%@
    attribute name="dialogClass" type="java.lang.String" required="false" %><%@
    attribute name="title" type="java.lang.String" required="true" %><%@
    attribute name="titleId" type="java.lang.String" required="false" %><%@
    attribute name="closeAttrs" type="java.lang.String" required="false" %><%@
    attribute name="closeCommand" type="java.lang.String" required="true"

%><div id="${dialogId}" class="${dialogClass} modalDialog">
  <div class="dialogHeader">
    <div class="closeWindow">
      <a class="closeWindowLink" title="Close dialog window" href="#" onclick="${closeCommand}; return false" ${closeAttrs}>&#xd7;</a>
    </div>
    <div class="dialogHandle">
      <c:set var="escapedTitle"><c:out value="${title}"/></c:set
      ><h3 class="dialogTitle" id="${titleId}" title="${escapedTitle}">${escapedTitle}</h3>
    </div>
  </div>
  <div class="modalDialogBody">
    <jsp:doBody/>
  </div>
</div>