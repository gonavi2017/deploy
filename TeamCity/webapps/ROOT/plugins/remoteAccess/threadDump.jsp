<%@ include file="/include.jsp" %>
<jsp:useBean id="remoteAccessAgent" scope="request" type="jetbrains.buildServer.serverSide.SBuildAgent"/>
<div>
  <forms:saving id="threaddumpAgentLoader"/>
  <div id="threaddumpAgentLoaderResult" class="successMessage" style="display:none; text-align:left; margin: 1em 0;"></div>
  <a onclick="{
      $('threaddumpAgentLoader').show();
      BS.ajaxRequest('<c:url value="/remoteAccess/threaddump.html?agent=${remoteAccessAgent.id}"/>',
      {
        onComplete: function(transport) {
          $('threaddumpAgentLoaderResult').innerHTML = transport.responseText;
          $('threaddumpAgentLoaderResult').show();
          $('threaddumpAgentLoader').hide();
        }
      });

      return false;
    };" href="#">Dump threads on agent</a>
</div>
