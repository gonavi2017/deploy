<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"  %>
<jsp:useBean id="context" scope="request" type="jetbrains.buildServer.controllers.parameters.ParameterEditContext"/>
<jsp:useBean id="itemsList" scope="request" type="java.lang.String"/>

<tr>
  <th><label for="multiple">Allow multiple:</label></th>
  <td>
    <props:checkboxProperty name="multiple"/>
    <label for="multiple">Allow multiple selection</label>
  </td>
</tr>

<tr id="multiselectSeparator">
  <th><label for="valueSeparator">Value separator:</label></th>
  <td>
    <props:textProperty name="valueSeparator" className="longField"/>
    <span class="smallNote">Specify multiple selected items separator. Leave blank to use ','.</span>
  </td>
</tr>

<tr>
  <th><label for="itemsList">Items:<l:star/></label></th>
  <td><c:set var="note">Specify items for the control. Each item on a new line. Use <em>label => value</em> or <em>value</em></c:set
    ><props:multilineProperty
        name="itemsList"
        linkTitle="Edit items"
        cols="50"
        rows="5"
        value="${itemsList}"
        expanded="${true}"
        note="${note}"/>
  </td>
</tr>

<script type="text/javascript">
  (function(){
    var update = function() {
      if ($('multiple').checked) {
        BS.Util.show('multiselectSeparator');
      } else {
        BS.Util.hide('multiselectSeparator');
      }
    };

    $('multiple').on('change', update);
    update();
  })();
</script>