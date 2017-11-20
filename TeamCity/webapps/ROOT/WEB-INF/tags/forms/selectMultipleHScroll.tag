<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="name" required="true"
  %><%@attribute name="id" required="false"
  %><%@attribute name="size" required="false"
  %><%@attribute name="className" required="false"
  %><%@attribute name="wrapperClassName" required="false"
  %><%@attribute name="tabindex" required="false"
  %><%@attribute name="disabled" required="false" type="java.lang.Boolean"
  %><c:set var="id" value="${not empty id ? id : name}"/><div class="select-multiple__wrapper ${wrapperClassName}">
  <forms:select name="${name}" id="${id}" multiple="true" disabled="${disabled}" className="select-multiple__inner ${className}" size="10"
      ><jsp:doBody/></forms:select></div><script>BS.expandMultiSelect($j('#${id}'));</script>
