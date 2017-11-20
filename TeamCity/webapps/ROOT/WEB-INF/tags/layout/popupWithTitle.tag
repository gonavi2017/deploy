<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="id" required="true"
  %><%@ attribute name="title" required="true"
  %>
<div id="${id}" class="popupDiv popupWithTitle">
  <h3 class="popupWithTitleHeader">
    <div class="closeWindow">
      <a class="closeWindowLink" showdiscardchangesmessage="false" href="#" onclick="BS.Hider.hideDiv('${id}'); return false">&#xd7;</a>
    </div>
    <c:out value="${title}"/>
  </h3>

  <div class="contentWrapper"><jsp:doBody/></div>
</div>
