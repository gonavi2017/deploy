<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="changeStatus" type="jetbrains.buildServer.vcs.ChangeStatus" required="true"
  %><%@ attribute name="hideSuccessful" type="java.lang.Boolean" required="true"
  %><%@ attribute name="jsBuildTypes" type="java.lang.String" required="true"
  %>
<div class="hideSuccessfulBlock">
  <c:set var="change_id"><bs:_csId changeStatus="${changeStatus}"/></c:set>
  <c:set var="cb_handler">BS.HideSuccessfulSupport.setSuccessfulVisible(this, '${change_id}', ${jsBuildTypes});</c:set>

  <c:set var="cb_name" value="cb${util:uniqueId()}"/>
  <forms:checkbox name="${cb_name}" checked="${hideSuccessful}" onclick="${cb_handler}"/>
  <label for="${cb_name}">Hide successful and pending configurations</label>

</div>
