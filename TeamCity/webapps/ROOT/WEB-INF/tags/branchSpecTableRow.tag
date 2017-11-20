<%--
Branch spec should be placed closer to the branch field.
Branch field location is vcs-plugin specific. This tag
is needed to not edit markup in each plugin.
--%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<tr class="advancedSetting">
  <th><label>Branch specification:</label></th>
  <td><bs:branchSpecProperty/></td>
</tr>
