<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="tableModel" required="true" type="jetbrains.buildServer.controllers.compatibility.CompatibilityTableModel" %><%@
    attribute name="active" required="true" type="java.lang.Boolean" %>
<table class="agentsCompatibilityTable">
  <tr>
    <th class="compatible">Compatible agents (${tableModel.compatibleColumn.numberOfEntries})</th>
    <th class="empty">&nbsp;</th>
    <th class="incompatible">Incompatible agents (${tableModel.incompatibleColumn.numberOfEntries})</th>
  </tr>
  <tr>
    <td class="compatible">
      <bs:_groupedCompatibility tableColumn="${tableModel.compatibleColumn}" active="${active}" />
    </td>
    <td class="empty">&nbsp;</td>
    <td class="incompatible">
      <bs:_groupedCompatibility tableColumn="${tableModel.incompatibleColumn}" active="${active}" />
    </td>
  </tr>
</table>
