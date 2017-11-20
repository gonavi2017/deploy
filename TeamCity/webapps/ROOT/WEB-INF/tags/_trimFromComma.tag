<%@ attribute name="value" required="true" type="java.lang.String"
%><%
  final int commaPos = value.indexOf(',');
  if (commaPos == -1) {
    out.write(value.trim());
  }
  else {
    out.write(value.substring(0, commaPos).trim());
  }
%>