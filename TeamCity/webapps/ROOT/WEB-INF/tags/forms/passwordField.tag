<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="encryptedPassword" required="false" %>
<%@ attribute name="className" required="false" %>
<%@ attribute name="style" required="false" %>
<%@ attribute name="size" required="false" type="java.lang.Integer"%>
<%@ attribute name="maxlength" required="false" type="java.lang.Integer"%>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean"%>
<%@ attribute name="onfocus" required="false"%>
<%@ attribute name="onchange" required="false"%>
<%@ attribute name="onkeyup" required="false"%>
<%@ attribute name="publicKey" required="false" type="java.lang.String" %>
<%@ attribute name="autofill" required="false" type="java.lang.Boolean"%>

<c:set var="className" value="${fn:length(className) == 0 ? 'textField' : className}"/>
<%
  String random = String.valueOf(Math.random());
  request.setAttribute("randomValue", random);
%>
<c:set var="actualId" value="${empty id ? name : id}"/>
<c:set var="newValue" value="${empty encryptedPassword ? '' : requestScope['randomValue']}"/>
<c:set var="onfocusAttr" value="${empty onfocus ? 'this.select()' : onfocus}"/>
<c:if test="${not autofill}"><!-- These fake fields are a workaround to disable chrome autofill -->
<input style="visibility:hidden;height:0;width:1px;position:absolute;left:0;top:0" type="text" value=" "/>
<input style="visibility:hidden;height:0;width:1px;position:absolute;left:0;top:0" type="password" value=" " autocomplete="new-password"/>
</c:if>
<input type="password" name="${name}" id="${actualId}" size="${size}" maxlength="${maxlength}"
       value="${newValue}" class="${className}" style="margin:0; padding:0; ${style}"
       <c:if test="${disabled}">disabled</c:if> onfocus="${onfocusAttr}" onchange="${onchange}"
       onkeyup="${onkeyup}" autocomplete="new-password">
<script type="text/javascript">
  $('${actualId}').getEncryptedPassword = function(pubKey) {
    if (this.value == '${newValue}') return '${encryptedPassword}';
    return BS.Encrypt.encryptData(this.value, pubKey != null ? pubKey : '${publicKey}');
  };

  $('${actualId}').maskPassword = function() {
    this.value = '${newValue}';
  };
</script>