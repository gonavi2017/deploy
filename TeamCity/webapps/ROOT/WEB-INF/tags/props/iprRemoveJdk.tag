<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="key" required="true" type="java.lang.String"
  %><%@ attribute name="shouldShow"
  %><%@ attribute name="typeName" required="true" type="java.lang.String"%>

<c:if test="${shouldShow}">
  <div>
    <bs:icon icon="../attentionComment.png"/>
    Cannot find usages of this ${typeName}.
  </div>

  <forms:checkbox id="remove_${key}" name="iprInfo.removedJdkAndLibraries" value="${key}"/>
  <label for="remove_${key}" class="removeJdk">
    Remove on save
  </label>
</c:if>