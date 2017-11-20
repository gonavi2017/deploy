<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ attribute name="name" required="true" type="java.lang.String"%>
<%@ attribute name="title" required="true" type="java.lang.String"%>
<%@ attribute name="note" required="false" type="java.lang.String"%>
<%@ attribute name="id" required="false" type="java.lang.String"%>
<%@ attribute name="showNone" required="false" type="java.lang.Boolean"%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<%@ variable name-given="idPrefix" scope="AT_BEGIN" %>
<%@ variable name-given="jsPrefix" scope="AT_BEGIN"  %>

<c:set var="idValue" value="${id != null ? id : name}"/>
<c:set var="idPrefix" value="${idValue}_Block" scope="request"/>
<c:set var="jsPrefix" value="${util:forJSIdentifier(idPrefix)}_js" scope="request"/>
<c:set var="idGlobalBlockStart" value="${idPrefix}_gs"/>
<c:set var="idGlobalBlockEnd" value="${idPrefix}_ge"/>

<tr>
  <th><label for="${idValue}">${title}</label></th>
  <td>
    <c:set var="onChangeSelect">BS.SelectSectionProperty_${jsPrefix}.onChange(this);</c:set>
    <props:selectProperty name="${name}" id="${idValue}" onchange="${onChangeSelect}" enableFilter="true" className="mediumField"/>
    <c:if test="${not empty note}">${note}</c:if>
    <span id="error_${name}" class="error"></span>
  </td>
</tr>

<tr id="${idGlobalBlockStart}" class="noBorder" style="display:none;">
  <td colspan="2"></td>
</tr>

<style>
  .select-section_hidden {
    display: none;
  }
</style>
<script type="text/javascript">
  BS.SelectSectionProperty_${jsPrefix} = {
      _foreachBlock: function(start, end, action) {
        $(start).nextSiblings().each(
          function(el) {
            if (el.id == end) {
              throw $break;
            }
            if (el.id.startsWith("${idPrefix}")) return;

            action(el, 'select-section_hidden');
         });
    },

    ranges : [],

    addRange: function(value, start, stop, caption) {
      this.ranges.push({
                         value: value,
                         start: start,
                         end : stop,
                         addOption: function(i, el) {
                           el.options[i] = (new Option(caption,
                                                     value,
                                                     false,
                                                     "${util:forJS(propertiesBean.properties[name], true, false)}" == value));
                         }
                       });
    },

    onRendered: function() {
      var selector = $("${idValue}");
      for(var i = 0; i < this.ranges.length; i++) {
        this.ranges[i].addOption(i, selector);
      }
      this.onChange(selector);
    },

    onChange: function(e) {
      var selection = e.options[e.selectedIndex].value;
      this._foreachBlock("${idGlobalBlockStart}", "${idGlobalBlockEnd}", selection != '' ? Element.removeClassName : Element.addClassName);

      for(var i = 0; i < this.ranges.length; i++) {
        var item = this.ranges[i];
        var id = item.value;
        this._foreachBlock(item.start, item.end, selection == id ? Element.removeClassName : Element.addClassName);
      }

      BS.MultilineProperties.updateVisible();
    }
  };
</script>

<jsp:doBody/>

<tr id="${idGlobalBlockEnd}" class="noBorder" style="display:none;">
  <td colspan="2"></td>
</tr>

<script type="text/javascript">
  BS.SelectSectionProperty_${jsPrefix}.onRendered();
  BS.jQueryDropdown($('${idValue}')).ufd("changeOptions");
</script>
