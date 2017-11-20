<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="tags" tagdir="/WEB-INF/tags/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ attribute name="label" required="false" type="java.lang.String"
  %><%@ attribute name="formId" required="true" type="java.lang.String"
  %><%@ attribute name="note" type="java.lang.String"
  %><%@attribute name="type" type="java.lang.String" required="false" %>
<c:set var="name" value="buildTagsInfo"/>
<c:set var="textFieldId" value="${name}${type}"/>
<c:if test="${not empty label}"><label class="textLabel" for="${name}">${label}:</label></c:if><forms:textField name="${name}" className="commentTextArea" expandable="${true}" id="${textFieldId}" minheight="40"/>
<div id="${formId}_availableTags" class="available-tags-container"></div>
<span class="note">${note}</span>