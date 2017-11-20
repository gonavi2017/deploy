<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="containerId" required="true" type="java.lang.String" %>
<%@attribute name="closestParentSelector" required="false" type="java.lang.String" %>
<c:if test="${empty closestParentSelector}"><c:set var="closestParentSelector" value="tr"/></c:if>
<script type="text/javascript">
  $j(document).ready(function() {
    var container = $j('#' + '${containerId}');
    var valueChanged = container.find('.valueChanged:visible');
    valueChanged.closest('${closestParentSelector}').addClass('valueChanged');
  });
</script>
