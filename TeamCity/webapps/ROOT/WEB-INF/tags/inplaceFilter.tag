<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="containerId" required="true"
  %><%@attribute name="filterText" required="false"
  %><%@attribute name="style" required="false" 
  %><%@attribute name="afterApplyFunc" required="false"
  %><%@attribute name="activate" required="false" type="java.lang.Boolean"
  %><%@attribute name="className" required="false"
  %><%@attribute name="initManually" required="false" type="java.lang.Boolean" %>
<div class="inplaceFilterDiv ${className}" style="${style}">
  <input type="text" id="${containerId}_filter" value="" autocomplete="off"/>
</div>
<script type="text/javascript">
  (function($) {
    var initFunction = function () {
      var input = $('#${containerId}_filter');
      input.placeholder({text: '${empty filterText ? "<filter>" : filterText}'});
      input.inplaceFilter('${containerId}'<c:if test="${not empty afterApplyFunc}">, ${afterApplyFunc}</c:if>);
      BS.InPlaceFilter.prepareFilter('${containerId}');
      <c:if test="${activate}">
      input.trigger('focus');
      </c:if>
    };
    <c:choose><c:when test="${empty initManually or !initManually}">$(initFunction);</c:when
    ><c:otherwise>BS.InPlaceFilter.storeInitFunction('${containerId}', initFunction)</c:otherwise></c:choose>
  })(jQuery);
</script>
