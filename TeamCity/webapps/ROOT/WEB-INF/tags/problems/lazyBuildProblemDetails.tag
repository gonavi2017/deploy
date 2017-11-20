<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems" %>

<%@ attribute name="uid" type="java.lang.String" required="true" %>
<%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true" %>
<%@ attribute name="expand" type="java.lang.Boolean"%>
<%@ attribute name="url" type="java.lang.String" required="true" %>
<%@ attribute name="parameters" type="java.lang.String"%>
<%@ attribute name="loadingText" type="java.lang.String"%>

<problems:buildProblemDetails uid="${uid}" insertIcons="true" expand="${expand}" buildProblem="${buildProblem}">
  <span id="lazyBuildProblemDetailsLoading_${uid}"><i class="icon-refresh icon-spin"></i>&nbsp;${empty loadingText ? 'Loading...' : loadingText}</span>
  <div id="lazyBuildProblemDetailsContainer_${uid}" data-uid="${uid}" class="lazyBuildProblemDetailsContainer"></div>
</problems:buildProblemDetails>
<script type="text/javascript">
  if (!$j.isFunction(window.loadLazyBuildProblemDetails)) {
    window.loadLazyBuildProblemDetails = function (uid, url, parameters) {
      BS.Util.show('lazyBuildProblemDetailsLoading_' + uid);
      BS.ajaxUpdater($('lazyBuildProblemDetailsContainer_' + uid), url,
                     {
                       method: 'get',
                       evalScripts: true,
                       parameters: parameters && parameters.trim().length > 0 ? parameters : '',
                       onComplete: function () {
                         BS.Util.hide('lazyBuildProblemDetailsLoading_' + uid);
                       }
                     });
    };
  }
  loadLazyBuildProblemDetails('${uid}', '${url}', '${parameters}');
</script>
