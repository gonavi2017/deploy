<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="patchUrl" required="true"
  %><%@ attribute name="showMode" required="true"   
  %>
<c:choose>
  <c:when test="${showMode == 'compact'}">
    <a class="noUnderline" href="#" onclick="BS.Activator.doOpen('patch?file=${patchUrl}'); return false"
       title="Download patch to IDE"><jsp:doBody/>
      <span class="icon icon16 icon_open-in-ide"></span>
    </a>  
  </c:when>
  <c:otherwise>
    <span class="icon icon16 icon_open-in-ide"></span>
    <a href="#" onclick="BS.Activator.doOpen('patch?file=${patchUrl}'); return false" title="Download patch to IDE">Download patch to IDE<jsp:doBody/></a>
  </c:otherwise>
</c:choose>


