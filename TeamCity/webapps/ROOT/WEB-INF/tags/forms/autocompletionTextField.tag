<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@

    attribute name="name" required="true" %><%@
    attribute name="id" required="false" %><%@
    attribute name="value" required="false" %><%@
    attribute name="className" required="false" %><%@
    attribute name="style" required="false" %><%@
    attribute name="size" required="false" type="java.lang.Integer"%><%@
    attribute name="maxlength" required="false" type="java.lang.Integer"%><%@
    attribute name="disabled" required="false" type="java.lang.Boolean"%><%@
    attribute name="defaultText" required="false"%><%@

    attribute name="autocompletionSource" required="true"%><%@
    attribute name="autocompletionDelay" required="false"%><%@
    attribute name="autocompletionMinLength" required="false"%><%@
    attribute name="autocompletionSearchAction" required="false"%><%@
    attribute name="autocompletionShowOnFocus" required="false"%><%@
    attribute name="autocompletionShowEmpty" required="false"

%><c:set var="className" value="${fn:length(className) == 0 ? 'textField' : className}"
/><c:set var="showDefault" value="${fn:length(value) == 0 and fn:length(defaultText) > 0}"
/><c:set var="valueToSet" value="${showDefault ? defaultText : value}"
/><input type="text" name="${name}" id="${id != null ? id : name}" size="${size}" maxlength="${maxlength}" value="<c:out value="${valueToSet}"/>" class="${className}" style="margin:0; padding:0; ${style}" <c:if test="${disabled}">disabled</c:if>>
<script type="text/javascript">
  (function($) {
    $(document).ready(function() {
      $("#${id != null ? id : name}").autocomplete({source:      ${autocompletionSource},
                                                    delay:       ${autocompletionDelay != null ? autocompletionDelay : 300},
                                                    minLength:   ${autocompletionMinLength != null ? autocompletionMinLength : 0},
                                                    search:      ${autocompletionSearchAction != null ? autocompletionSearchAction : 'null'},
                                                    showOnFocus: ${autocompletionShowOnFocus != null ? autocompletionShowOnFocus : 'false'},
                                                    showEmpty:   ${autocompletionShowEmpty != null ? autocompletionShowEmpty : 'true'}
                                                   });
      $("#${id != null ? id : name}").placeholder();
    });
  }(jQuery));
</script>