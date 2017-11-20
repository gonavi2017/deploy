<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ attribute name="linkText" required="true"
  %><forms:addButton onclick="BS.EditRequirementDialog.showDialog('', '', ''); return false"><c:out value="${linkText}"/></forms:addButton>
