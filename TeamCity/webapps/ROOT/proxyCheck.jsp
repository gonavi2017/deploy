<%@ include file="/include-internal.jsp" %>

<bs:linkScript>
  /js/bs/proxyChecker.js
</bs:linkScript>

<script type="application/javascript">
  $j(document).ready(function() {
      BS.ProxyChecker.check();
  });
</script>