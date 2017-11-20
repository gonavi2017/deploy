<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="linkText" required="true"
  %><%@ attribute name="title" required="false"
  %><%@ attribute name="content" required="true" fragment="true"
  %>
<a href="#" onclick="return BS.TogglePopup.toggle(this);"
   <c:if test="${not empty title}">title="${title}"</c:if>>${linkText}</a><div style="display:none;">
  <div class="togglePopupContent"><jsp:invoke fragment="content"/></div>
</div>
