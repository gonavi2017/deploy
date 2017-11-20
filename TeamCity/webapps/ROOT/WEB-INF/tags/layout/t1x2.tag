<%@ attribute name="b1" fragment="true"
%><%@ attribute name="b2" fragment="true"
%><table class="userSettingsTable">
  <tr>
    <td class="t">
      <jsp:invoke fragment="b1"/>
    </td>
    <td class="t">
      <jsp:invoke fragment="b2"/>
    </td>
  </tr>
</table>


