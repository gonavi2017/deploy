<table class="runnerFormTable" style="margin-top: 1em">
  <tr class="groupingTitle">
    <td>Overall status</td>
  </tr>
  <tr>
    <td><div id="status">Openining...</div></td>
  </tr>
  <tr class="groupingTitle">
    <td>Additional info</td>
  </tr>
  <tr>
    <td>
      <div>Servlet Container: ${serverInfo}</div>
      <div>WebSocket Enabled: ${websocketEnabled}</div>
      <div>User Agent: <span id="userAgent"></span></div>
    </td>
  </tr>
  <tr class="groupingTitle">
    <td>Detailed log</td>
  </tr>
  <tr>
    <td>
      <div id="log"></div>
    </td>
  </tr>
</table>

<style type="text/css">
  #status {
    font-size: 110%;
  }

  #log {
    width: 99%;
    margin-top: 1em;
    border: 1px solid #ddd;
    background-color: #fbfbfb;
    padding: 1em 0 1em 1em;
  }
</style>

<script type="text/javascript">

  $j('#userAgent').html(navigator.userAgent);

  BS.Socket.checkSocketAvailable(function(available) {
    if (available) {
      $j('#status').html("WebSocket connection works!");
      $j('#status').css("color", "green");
    } else {
      $j('#status').html("WebSocket connection fails!");
      $j('#status').css("color", "red");
    }

    var refreshLog = function() {
      var newLogHtml ="";
      BS.Socket.getLog().forEach(function(message) {
        newLogHtml += message + "</br>";
      });
      $j('#log').html(newLogHtml);
    };
    refreshLog();
    setInterval(refreshLog, 1000);
  });
</script>