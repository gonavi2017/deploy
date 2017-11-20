<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="ufn" uri="/WEB-INF/functions/user"
  %><%@attribute name="propertyKey" required="true"
  %><%@attribute name="labelText" required="true"
  %><%@attribute name="progress" required="false"
  %><%@attribute name="afterComplete" required="false"
  %><%@attribute name="controlId" required="false"
  %>
<c:if test="${empty progress}">
  <c:set var="progress" value="${propertyKey}_progress"/>
  <forms:saving id="${progress}" className="progressRingInline"/>
</c:if>
<c:set var="afterComplete"><c:if test="${not empty afterComplete}">afterComplete: function() {${afterComplete}},</c:if></c:set>
<c:set var="options">{${afterComplete} progress:'${progress}'}</c:set>

<c:set var="val" value="${ufn:booleanPropertyValue(currentUser, propertyKey)}"/>
<forms:checkbox id="${controlId}" name="${propertyKey}" checked="${val}" onclick="BS.User.setBooleanProperty('${propertyKey}', this.checked, ${options})"/> <label class="rightLabel" for="${empty controlId ? propertyKey : controlId}"><c:out value="${labelText}"/></label>
