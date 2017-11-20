<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ attribute name="caption" required="true" type="java.lang.String" %>

<c:set var="idSectionStart" value="${idPrefix}_${value}_start"/>
<c:set var="idSectionContentRow" value="${idPrefix}_${value}_contentRow"/>
<c:set var="idSectionContentTable" value="${idPrefix}_${value}_contentTable"/>
<c:set var="idSectionEnd" value="${idPrefix}_${value}_end"/>

<script type="text/javascript">
  BS.SelectSectionProperty_${jsPrefix}.addRange("<bs:forJs>${value}</bs:forJs>", "${idSectionStart}", "${idSectionEnd}", "<bs:forJs>${caption}</bs:forJs>");
</script>

<tr id="${idSectionStart}" class="noBorder" style="display:none;">
  <td colspan="2"></td>
</tr>

<tr id="${idSectionContentRow}">
  <td style="display:none;">
    <table id="${idSectionContentTable}">
      <jsp:doBody/>
    </table>
  </td>
</tr>

<tr id="${idSectionEnd}" class="noBorder" style="display:none;">
  <td colspan="2"></td>
</tr>

<script type="text/javascript">
  var tempRow = $(document).getElementById("${idSectionContentRow}");
  var baseTable = tempRow.parentElement;
  var tempTable = $(document).getElementById("${idSectionContentTable}");
  while (tempTable.rows.length > 0)
  {
    var row = tempTable.rows[0];
    tempTable.deleteRow(0);
    row.addClassName("select-section_hidden");
    baseTable.insertBefore(row, tempRow);
  }

  baseTable.removeChild(tempRow);
</script>

