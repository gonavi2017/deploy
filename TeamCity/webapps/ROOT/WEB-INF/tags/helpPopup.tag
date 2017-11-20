<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="linkText" required="true"
  %><%@ attribute name="helpContent" required="true" fragment="true"
  %><%@ attribute name="helpFile" required="false"
  %><%@ attribute name="helpFileAnchor" required="false"
  %><bs:togglePopup linkText="${linkText}">
<jsp:attribute name="content">
  <div class="helpPopupContent">
    <div class="helpPopupBody"><jsp:invoke fragment="helpContent"/></div>
    <c:if test="${not empty helpFile}">
      <div class="helpPopupFooter">
        <bs:helpLink file="${helpFile}" anchor="${helpFileAnchor}">
          More details in the TeamCity reference
        </bs:helpLink>
      </div>
    </c:if>
  </div>
</jsp:attribute>
</bs:togglePopup>
