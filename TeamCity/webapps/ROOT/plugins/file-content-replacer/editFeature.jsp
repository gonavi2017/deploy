<%@ include file = "/include-internal.jsp" %>
<jsp:useBean id = "propertiesBean" type = "jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<jsp:useBean id = "ids" class = "jetbrains.buildServer.fileContentReplacer.server.Ids"/>
<jsp:useBean id = "keys" class = "jetbrains.buildServer.fileContentReplacer.server.Keys"/>
<jsp:useBean id = "values" class = "jetbrains.buildServer.fileContentReplacer.server.Values"/>

<%@ page import="jetbrains.buildServer.fileContentReplacer.RegexMode" %>
<c:set var="REGEX"><%=RegexMode.REGEX%></c:set>
<c:set var="FIXED_STRINGS"><%=RegexMode.FIXED_STRINGS%></c:set>
<c:set var="FIXED_STRINGS_ORDINAL"><%=RegexMode.FIXED_STRINGS.ordinal()%></c:set>

<style type = "text/css">
  /**
   * Overrides longField.width (31em) from forms.css. The containing dialog has a
   * width of 60em (see #buildFeaturesDialog in editBuildFeaturesResources.jspf).
   */
  .longerField {
    width: 42em;
  }

  .wideDialog {
    width: 36em;
  }

  .wideDialogField {
    width: 99%;
  }

  div.wideDialogNote {
    margin-top: 0.5em;
  }

  .leftAligned {
    margin-left: 0;
    padding-left: 0;
  }

  .regexp {
    font-weight: bolder;
  }

  .example {
    font-weight: bolder;
  }

  .nobr {
    display: inline !important;
  }

  span.nobr {
    vertical-align: middle;
  }

  /*
   * Makes table footer more concise.
   */
  .footer {
    padding-top: 0 !important;
    padding-bottom: 0 !important;
  }

  #advancedSettingsToggle_${ids.buildFeaturesDialog} {
    margin-bottom: 0;
  }
</style>
<script type = "text/javascript">
  BS.FileContentReplacer = {
    templates: ${values.templatesAsJson},

    /**
     * Updates the dialog fields with the properties of the selected template.
     */
    fireTemplateSelected: function() {
      var select = $("${ids.template}");
      var /**String*/ templateName = select.value;
      if (templateName.length === 0) {
        /*
         * Prevent selection of a non-existent template.
         */
        return;
      }

      /**
       * @type {{wildcards: String,
       *         fileEncoding: String,
       *         pattern: String,
       *         patternCaseSensitive: Boolean,
       *         regexMode: String,
       *         initialReplacement: String}}
       */
      var selectedTemplate = this.templates[templateName];

      $("${keys.wildcards}").value = selectedTemplate.wildcards;
      /*
       * Expand the textArea if not already expanded.
       */
      BS.MultilineProperties.setVisible('${keys.wildcards}', true);
      BS.MultilineProperties.updateVisible();

      var fileEncodingComboBox = $("${ids.fileEncoding}");
      fileEncodingComboBox.value = selectedTemplate.fileEncoding;
      var fileEncodingOption = fileEncodingComboBox.options[fileEncodingComboBox.selectedIndex];
      var fileEncodingDescription = fileEncodingOption.label;
      if (fileEncodingDescription === "") {
        fileEncodingDescription = fileEncodingOption.text;
      }
      /*
       * UFD 0.6: change the displayed encoding value of the HTMLInputElement
       * which covers the combo box. The other workaround:
       *
       * $j("#encoding").ufd("destroy");
       * $j("#encoding").ufd();
       *
       * - doesn't honor z-order.
       *
       * Test if upgrading to a newer UFD version.
       */
      var fileEncodingTextField = $("-ufd-teamcity-ui-${ids.fileEncoding}");
      if (fileEncodingTextField !== null && typeof fileEncodingTextField !== "undefined") {
        fileEncodingTextField.value = fileEncodingDescription;
      } else {
        $("error_${keys.fileEncoding}").textContent = "File encoding set to "
                                                      + fileEncodingDescription
                                                      + ". Close and re-open the dialog to see the changes.";
      }
      this.fireEncodingChanged();

      $("${ids.pattern}").value = selectedTemplate.pattern;
      $("${keys.patternCaseSensitive}").checked = selectedTemplate.patternCaseSensitive;
      $("${keys.regexMode}").checked = selectedTemplate.regexMode != "${FIXED_STRINGS}";
      this.fireRegexModeChanged();
      $("${ids.replacement}").value = selectedTemplate.initialReplacement;
    },

    /**
     * Closes the template selection dialog and calls {@link #fireTemplateSelected}.
     */
    fireTemplateSelectedExt: function() {
      var select = $("${ids.template}");
      var /**String*/ templateName = select.value;
      if (templateName.length === 0) {
        /*
         * No template is selected; button disabled.
         */
        return;
      }

      this.templateDialog.close();
      this.fireTemplateSelected();
    },

    /**
     * Enables the "Load" button if a valid template is selected and disables it
     * otherwise.
     */
    fireTemplateChanged: function() {
      var select = $("${ids.template}");
      var /**String*/ templateName = select.value;
      var okButton = $j("#${ids.okButton}");
      if (templateName.length === 0) {
        okButton.attr("disabled", "disabled");
      } else {
        okButton.removeAttr("disabled");
      }
    },

    fireEncodingChanged: function() {
      var fileEncodingComboBox = $("${ids.fileEncoding}");
      var encoding = fileEncodingComboBox.value;
      var fileEncodingCustomTextField = $j(BS.Util.escapeId("${ids.fileEncodingCustom}"));
      var fileEncodingCustomSmallNote = $j(BS.Util.escapeId("encoding.custom.smallNote"));
      if (encoding == "${values.fileEncodingCustom}") {
        /*
         * Default to UTF-8.
         */
        fileEncodingCustomTextField
            .val("UTF-8")
            .prop('disabled', false)
            .removeClass('hidden');
        fileEncodingCustomSmallNote.css("display", "inline");
      } else {
        fileEncodingCustomTextField
            .val(encoding)
            .prop('disabled', true)
            .addClass('hidden');
        fileEncodingCustomSmallNote.css("display", "none");
      }
    },

    /**
     * <p>Conditionally shows or hides mode-specific help hints based on the
     * current regex mode.</p>
     *
     * @since 2017.1
     */
    fireRegexModeChanged: function() {
      "use strict";
      var /**Boolean*/ regexMode = $j(BS.Util.escapeId("${keys.regexMode}")).is(":checked");
      if (regexMode) {
        $j("span.regexMode").show();
        $j("span.fixedStringsMode").hide();
      } else {
        $j("span.regexMode").hide();
        $j("span.fixedStringsMode").show();
      }
    },

    /**
     * Removes the "valueChanged" class from <em>wildcard</em>, <em>pattern</em>
     * and <em>replacement</em> fields (they don't have any default values anyway).
     */
    markUnchanged: function() {
      var className = "valueChanged";
      /*
       * The id contains dots, so we need to properly escape them.
       */
      $j("#${keys.wildcards}".replace(/\./g, "\\.")).removeClass(className);
      $j("#${ids.pattern}").removeClass(className);
      $j("#${ids.replacement}").removeClass(className);

      /*
       * Do not highlight the checked "Regex" box as modified when migrating
       * from 9.1/10.0.
       */
      var /**jQuery*/ $regexModeCheckbox = $j(BS.Util.escapeId("${keys.regexMode}"));
      var /**Boolean*/ regexMode = $regexModeCheckbox.is(":checked");
      if (regexMode) {
        $regexModeCheckbox.removeClass(className);
      }
    },

    templateDialog: OO.extend(BS.AbstractModalDialog, {
      getContainer: function() {
        return $("${ids.templateDialog}");
      },

      /**
       * "Overrides" <code>showCentered()</code> so that initially:
       * <ul>
       *   <li>"Load" button is disabled, and</li>
       *   <li>no template is selected.</li>
       * </ul>
       */
      showCenteredExt: function() {
        this.showCentered();

        var okButton = $j("#${ids.okButton}");
        okButton.attr("disabled", "disabled");

        var select = $("${ids.template}");
        select.value = "";

        var selectedTemplate = select.options[select.selectedIndex];
        var templateName = selectedTemplate.label;
        if (templateName === "") {
          templateName = selectedTemplate.text;
        }
        /*
         * UFD 0.6: make sure the UFD text field is in sync with the selected
         * value. The other workaround:
         *
         * $j("#template").ufd("destroy");
         * $j("#template").ufd();
         *
         * - doesn't honor z-order.
         *
         * Test if upgrading to a newer UFD version.
         */
        var templateTextField = $("-ufd-teamcity-ui-template");
        if (templateTextField !== null && typeof templateTextField !== "undefined") {
          templateTextField.value = templateName;
        }
      }
    })
  };

  /*
   * Executed each time the dialog is shown.
   */
  $j(document).ready(function() {
    BS.FileContentReplacer.markUnchanged();
    BS.FileContentReplacer.fireRegexModeChanged();

    /*
     * Highlight all changed fields in yellow, not just the visible ones
     * (this behaviour is different from that of admin:highlightChangedFields).
     */
    var container = $j("#${ids.buildFeaturesDialog}");
    var className = "valueChanged";
    var valueChanged = container.find("." + className);
    valueChanged.closest("tr").addClass(className);
  });
</script>
<tr>
  <td colspan = "2">
    <em>Processes text files by performing regular expression replacements
      before a build. Restores the file content to the original state after the
      build, e.g.&nbsp;can be used to patch files with the build number.
      <bs:help file = "File+Content+Replacer"/></em>
  </td>
</tr>
<tr>
  <th>
    Template (optional):<bs:help file = "File+Content+Replacer" anchor="Pre+defined+templates"/>
  </th>
  <td>
    <forms:button
        onclick = "BS.FileContentReplacer.templateDialog.showCenteredExt();"
        className = "btn_mini">Load template...</forms:button>
  </td>
</tr>
<tr>
  <th><label for = "${keys.wildcards}">Process files:<bs:help file = "File+Content+Replacer" anchor = "Wildcards"/></label></th>
  <td>
    <props:multilineProperty
        name = "${keys.wildcards}"
        linkTitle = "Edit file list"
        cols = "40"
        rows = "2"
        className = "longerField"
        note = "Newline- or comma-separated set of rules in the form of <span
        class = \"example\">+|-:[path relative to the checkout directory]</span>.<br/>
        Ant-style wildcards are supported, e.g.&nbsp;<span class = \"example\">dir/**/*.cs</span>."/>
  </td>
</tr>
<tr class = "advancedSetting">
  <th><label for = "${ids.fileEncoding}">File encoding:<bs:help file = "File+Content+Replacer" anchor = "File+encoding"/></label></th>
  <td>
    <props:selectProperty
        id = "${ids.fileEncoding}"
        name = "${keys.fileEncoding}"
        enableFilter = "true"
        onclick = "BS.FileContentReplacer.fireEncodingChanged();"
        onchange = "BS.FileContentReplacer.fireEncodingChanged();">
      <c:forEach var = "fileEncoding" items = "${values.fileEncodings}">
        <props:option value = "${fileEncoding.name}"><c:out value="${fileEncoding.description}"/></props:option>
      </c:forEach>
      <props:option value = "${values.fileEncodingCustom}"><c:out value = "<Custom>"/></props:option>
    </props:selectProperty>
    <c:set var = "customFileEncoding" value = "${propertiesBean.properties[keys.fileEncoding] == values.fileEncodingCustom}"/>
    <%--@elvariable id="customFileEncoding" type="java.lang.Boolean"--%>
    <props:textProperty
        id = "${ids.fileEncodingCustom}"
        name = "${keys.fileEncodingCustom}"
        disabled = "${!customFileEncoding}"
        className = "disableBuildTypeParams ${customFileEncoding ? '' : ' hidden'}"/>
    <span class = "error" id = "error_${keys.fileEncoding}"></span>
    <span id = "encoding.custom.smallNote" class = "smallNote" style =
        "display: ${customFileEncoding ? "inline" : "none"};">
      When using a Custom encoding, make sure it is <a href = "<c:url value =
      "https://docs.oracle.com/javase/8/docs/technotes/guides/intl/encoding.doc.html"/>"
        rel = "help" target = "_blank">supported</a> by the agent.</span>
  </td>
</tr>
<tr>
  <th><label for = "${ids.pattern}">Find what:<bs:help file = "File+Content+Replacer" anchor = "Pattern"/></label></th>
  <td>
    <props:textProperty
        id = "${ids.pattern}"
        name = "${keys.pattern}"
        className = "longerField"/>
    <span class = "error" id = "error_${keys.pattern}"></span>
    <%-- The "hidden" CSS class can't be used here, as the display property is
    already overridden for span.smallNote. --%>
    <span class="smallNote regexMode" style="display: none">Pattern to search
      for, in the <a href="<c:url
    value="https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#sum"
    />" rel="help" target="_blank">regular expression</a> format. <a href="<c:url
    value="https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#MULTILINE"
    />" rel="help" target="_blank" title="(?m)">MULTILINE</a> mode is on by default.</span>
    <span class="smallNote fixedStringsMode" style="display: none">Pattern to
      search for. Interpreted literally.</span>
  </td>
</tr>
<tr class = "advancedSetting">
  <th><label for = "${keys.patternCaseSensitive}">Match case:<bs:help file = "File+Content+Replacer" anchor = "Pattern"/></label></th>
  <td>
    <props:checkboxProperty
        name = "${keys.patternCaseSensitive}"
        checked = "${propertiesBean.properties[keys.patternCaseSensitive] != 'false'}"
        uncheckedValue = "false"/>
    <span class = "smallNote nobr">Uncheck for case-insensitive languages
      (e.g.&nbsp;Visual Basic).</span>
    <span class = "error" id = "error_${keys.patternCaseSensitive}"></span>
  </td>
</tr>
<tr class="advancedSetting">
  <th><label for="${keys.regexMode}">Regex:</label></th>
  <td>
    <c:set var="regexMode" value="${propertiesBean.properties[keys.regexMode]}"/>
    <props:checkboxProperty
        name="${keys.regexMode}"
        value="${REGEX}"
        uncheckedValue="${FIXED_STRINGS}"
        checked="${empty regexMode || (regexMode != FIXED_STRINGS_ORDINAL && fn:toUpperCase(regexMode) != FIXED_STRINGS)}"
        onclick="BS.FileContentReplacer.fireRegexModeChanged();"/>
    <span class="smallNote nobr">Uncheck to perform a fixed strings search.
    </span>
    <span class="error" id="error_${keys.regexMode}"></span>
  </td>
</tr>
<tr>
  <th>
    <label for = "${ids.replacement}">Replace with:<bs:help file = "File+Content+Replacer" anchor = "Replacement"/></label>
  </th>
  <td>
    <props:textProperty
        id = "${ids.replacement}"
        name = "${keys.replacement}"
        className = "longerField"/>
    <span class = "error" id = "error_${keys.replacement}"></span>
    <%-- The "hidden" CSS class can't be used here, as the display property is
    already overridden for span.smallNote. --%>
    <span class="smallNote regexMode" style="display: none">Replacement text.
      <span class="regexp">$N</span>&nbsp;sequence references <span
          class="regexp">N</span>-th&nbsp;capturing group. All
      backslashes&nbsp;(<span class="regexp">\</span>) and
      dollar&nbsp;signs&nbsp;(<span class="regexp">$</span>) without a special
      meaning should be quoted (as <span class="regexp">\\</span> and <span
          class="regexp">\\$</span>, respectively).</span>
    <span class="smallNote fixedStringsMode" style="display: none">Replacement
      text. Backslashes&nbsp;(<span class="regexp">\</span>) and
      dollar&nbsp;signs&nbsp;(<span class="regexp">$</span>) have no special
      meaning.</span>
  </td>
</tr>
<bs:dialog
    dialogId = "${ids.templateDialog}"
    title = "Load Template"
    closeCommand = "BS.FileContentReplacer.templateDialog.close();"
    dialogClass = "wideDialog">
  <div>
    <forms:select
        id = "${ids.template}"
        name = "${ids.template}"
        enableFilter = "true"
        onclick = "BS.FileContentReplacer.fireTemplateChanged();"
        onchange = "BS.FileContentReplacer.fireTemplateChanged();"
        className = "wideDialogField">
      <forms:option value = "">-- Choose a template --</forms:option>
      <c:forEach var = "entry" items = "${values.groupedTemplates}">
        <optgroup label = "${entry.key}">
          <c:forEach var = "template" items = "${entry.value}">
            <forms:option value = "${template.name}">${template.name}</forms:option>
          </c:forEach>
        </optgroup>
      </c:forEach>
    </forms:select>
  </div>
  <div>
    <div class = "smallNote wideDialogNote leftAligned">Start typing to filter templates
      by language, file or attribute&nbsp;(e.g.&nbsp;<span class = "example">AssemblyVersion</span>).
    </div>
  </div>
  <div class = "popupSaveButtonsBlock">
    <forms:submit
        id = "${ids.okButton}"
        onclick = "BS.FileContentReplacer.fireTemplateSelectedExt();"
        label = "Load"
        type = "button"/>
    <forms:cancel
        onclick = "BS.FileContentReplacer.templateDialog.close();"/>
  </div>
</bs:dialog>
