<table class="infoBanner">
  <tr>
    <td><jsp:doBody/></td>
    <td><a href="#" class="closeButton" title="Close this tooltip">&nbsp;</a></td>
  </tr>
</table>

<script type="text/javascript">
  $j('.closeButton').click(function () {
    $j(this).parents('.infoBanner').hide();
    $j(this).unbind('click');
  });
</script>