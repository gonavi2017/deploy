<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<tr>
  <td colspan="2"><em>Retry Build Trigger adds a new build to the queue if the previous build failed.</em></td>
</tr>
<tr>
  <td style="vertical-align: top;">
    <label for="enqueueTimeout">Seconds to wait:</label>
  </td>
  <td style="vertical-align: top;">
    <props:textProperty name="enqueueTimeout"/>
    <span class="error" id="error_enqueueTimeout"></span>
    <span class="smallNote">Seconds to wait before starting new build.</span>
  </td>
</tr>
<tr>
  <td style="vertical-align: top;">
    <label for="retryAttempts">Number of attempts to retry build:</label>
  </td>
  <td style="vertical-align: top;">
    <props:textProperty name="retryAttempts"/>
    <span class="error" id="error_retryAttempts"></span>
    <span class="smallNote">Leave blank for unlimited re-try.</span>
  </td>
</tr>
