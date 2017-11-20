<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"  %>
<jsp:useBean id="context" scope="request" type="jetbrains.buildServer.controllers.parameters.ParameterEditContext"/>
<jsp:useBean id="cns" class="jetbrains.buildServer.controllers.parameters.types.TestFieldParameterConstants"/>
<jsp:useBean id="regexp" scope="request" type="java.lang.String"/>
<jsp:useBean id="validationMode" scope="request" type="java.lang.String"/>

<tr>
  <th><label for="textFieldMode">Allowed Value:</label></th>
  <td>
    <props:selectProperty id="textFieldMode" name="${cns.mode}" className="longField" >
      <props:option value="${cns.modeAny}" selected="${validationMode eq cns.modeAny}">Any</props:option>
      <props:option value="${cns.modeNotEmpty}" selected="${validationMode eq cns.modeNotEmpty}">Not Empty</props:option>
      <props:option value="${cns.modeRegex}" selected="${validationMode eq cns.modeRegex}">Regex</props:option>
    </props:selectProperty>
  </td>
</tr>

<tr class="textFieldModeRegex">
  <th><label for="${cns.regexName}">Pattern:</label></th>
  <td>
    <props:textProperty name="${cns.regexName}" className="longField" value="${regexp}"/>
    <span class="smallNote">Specify a Java-style regular expression to validate field value</span>
    <span id="error_${cns.regexName}" class="error"></span>
  </td>
</tr>

<tr class="textFieldModeRegex">
  <th><label for="${cns.validationName}">Validation Message:</label></th>
  <td>
    <props:textProperty name="${cns.validationName}" className="longField"/>
    <span class="smallNote">Specify text to show if regexp validation fails</span>
    <span id="error_${cns.validationName}" class="error"></span>
  </td>
</tr>

<script type="text/javascript">
  jQuery(function($){
    var regexValue = "<bs:forJs>${cns.modeRegex}</bs:forJs>";
    var onTextFieldModeChange = function() {
      var val = $("#textFieldMode").val();
      if (val == regexValue) {
        $(".textFieldModeRegex").show();
      } else {
        $(".textFieldModeRegex").hide();
      }
    };
    $("#textFieldMode").change(onTextFieldModeChange);
    onTextFieldModeChange();
  });
</script>
