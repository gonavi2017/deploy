<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="problems" type="java.util.Collection" rtexprvalue="true" required="true"
  %><%@ attribute name="controlId" type="java.lang.String"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %>
<c:if test="${not empty problems}">
  <c:set var="id" value="${controlId}_problem_popup"/>

  <script type="text/javascript">
    BS.Clouds.registerProblem('${id}');
  </script>

  <div class="popupDiv" style="display:none;" id="${id}">
    <bs:showSystemProblems systemProblems="${problems}"/>
  </div>
</c:if>