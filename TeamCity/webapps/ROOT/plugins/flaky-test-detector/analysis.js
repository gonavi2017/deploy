BS.FlakyTestDetector = $j.extend({}, BS.FlakyTestDetector, {
  /**
   * <p>Shows or hides flaky tests with active investigations assigned.</p>
   *
   * @param {Boolean} visible
   */
  setInvestigationsVisible: function(visible) {
    "use strict";
    var /**jQuery*/ $tableHeader = $j("table.analysis > thead > tr");
    var /**jQuery*/ $flakyTests = $j("table.analysis tr.analysis");
    var /**jQuery*/ $investigatedTests = $flakyTests.filter("tr.activeInvestigation");

    if (visible) {
      $tableHeader.show();
      $investigatedTests.show();
      /*
       * Additionally, add the ellipsis button ([...]) to the newly-displayed
       * flaky reasons.
       */
      $j("table.analysis div.flakyReason, table.analysis ul.flakyReason").installEllipsis();
    } else {
      var /**Number*/ flakyTestCount = $flakyTests.length;
      var /**Number*/ investigatedTestCount = $investigatedTests.length;
      /*
       * Hide table header if all tests are investigated and hidden.
       */
      if (flakyTestCount === investigatedTestCount) {
        $tableHeader.hide();
      }
      $investigatedTests.hide();
    }

    /*
     * Enable or disable checkboxes which correspond to investigated tests
     * (see testGroup.js).
     */
    var /**jQuery*/ $investigatedTestCheckboxes = $investigatedTests.find(".custom-checkbox .custom-checkbox_input");
    $investigatedTestCheckboxes.prop("disabled", !visible);
    if (visible) {
      /*
       * Remove the "disabled" class from parent <span/> elements, too
       * (see forms.js).
       */
      $investigatedTestCheckboxes.parent().removeClass("custom-checkbox_disabled");
    } else {
      /*
       * Un-check all hidden checkboxes.
       */
      $investigatedTestCheckboxes.prop("checked", false);
      $investigatedTestCheckboxes.parent().removeClass("custom-checkbox_checked");
      $investigatedTestCheckboxes.parent().removeClass("custom-checkbox_focused");
    }

    BS.Log.info("Active investigations " + (visible ? "shown" : "hidden"));
  },

  /**
   * <p>Shows or hides the controls.</p>
   *
   * @param {Boolean} visible
   */
  setControlsVisible: function(visible) {
    "use strict";
    var /**jQuery*/ $checkbox = $j(BS.Util.escapeId(this.investigationsHiddenId));
    var /**jQuery*/ $label = $checkbox.nextAll("label[for='" + this.investigationsHiddenId + "']");
    $j.merge($checkbox, $label).each(function() {
      if (visible) {
        $j(this).show();
      } else {
        $j(this).hide();
      }
    });
    BS.Log.info("Controls " + (visible ? "shown" : "hidden"));
  },

  /**
   * <p>Refreshes the table using a locally-stored sort key.</p>
   */
  refreshSortablesNoArgs: function() {
    "use strict";
    var /**String*/ order = $j("#order").text();
    var /**Object*/ httpRequestParameters = {
      order: order
    };
    this.refreshSortables(this.blockContentId, httpRequestParameters);
    BS.Log.info("Flaky tests refreshed; ordering is " + order);
  },

  /**
   * <p>Updates tab title with the new flaky test count.</p>
   *
   * @param {Number} flakyTestCount
   * @param {Number} testLimit
   */
  setFlakyTestCount: function(flakyTestCount, testLimit) {
    "use strict";

    var /**String*/ displayedTextCount = flakyTestCount <= testLimit
        ? flakyTestCount
        : testLimit + "+";

    var /**jQuery*/ $counter = $j("#flakyTests_Tab .tabCounter");
    if ($counter.length === 0) {
      /*
       * Counter element not yet injected.
       */
      var /**String*/ tabSelector = "#flakyTests_Tab .tabs";
      var /**jQuery*/ $tab = $j(tabSelector);
      var /**String*/ tabName = $tab.text();
      $tab.text(tabName + " (" + displayedTextCount + ")");
      new TabbedPane.Tab().extractCountForElements(tabSelector);
    } else {
      $counter.text(displayedTextCount);
    }
  },

  /**
   * <p>Updates the investigated tests counter.</p>
   *
   * @param {Number} investigatedTestCount
   */
  setInvestigatedTestCount: function(investigatedTestCount) {
    "use strict";
    var /**Text*/ text = $j(BS.Util.escapeId(this.investigationsHiddenId))
        .nextAll("label[for='" + this.investigationsHiddenId + "']")
        .contents()
        .filter(function() {
          return this.nodeType === 3 && this.textContent.trim().length;
        })[0];
    var /**RegExp*/ regex = /(\ \()\d+(\)$)/;
    text.nodeValue = regex.test(text.wholeText)
        ? text.wholeText.replace(regex, "$1" + investigatedTestCount + "$2")
        : text.wholeText + " (" + investigatedTestCount + ")";
  },

  /**
   * @param {Boolean} monitoringEnabled
   * @param {Number} flakyTestCount
   * @param {Number} testLimit
   * @param {Number} investigatedTestCount
   * @param {Object} testGroup
   * @param {String} testGroup.id the unique <code>id</code> of the test
   *        group.
   * @param {Array.<Array.<String>>} testGroup.nameIds array of string pairs.
   *        The CAR in each pair is <code>testNameId</code>, while the CDR is
   *        the comma-separated list of <code>buildId</code>'s the test is
   *        failing in, e.&nbsp;g.: <code>[["-105815409583110515", "1088179,"],
   *        ["-7691647651072431595", "1088179,1088180"]]</code>. Build
   *        <code>id</code>'s are optional (used to determine the context
   *        project and/or build configuration if this information is
   *        otherwise unavailable).
   * @param {String} testGroup.projectExternalId the external <code>id</code>
   *        of the parent project.
   */
  onrefresh: function(monitoringEnabled,
                      flakyTestCount,
                      testLimit,
                      investigatedTestCount,
                      testGroup) {
    if (monitoringEnabled && flakyTestCount > 0) {
      /*
       * Focus a particular table row if testNameId was specified in the URL.
       */
      var hash = window.location.hash;
      if (hash.length > 1) {
        var trId = BS.Util.escapeId(hash.substring(1));
        $j(trId).addClass("focus");
      }

      /*
       * Show/hide active investigations.
       */
      this.setInvestigationsVisible(!$j(BS.Util.escapeId(this.investigationsHiddenId)).is(":checked"));

      /*
       * Make the table sortable.
       */
      var /**BS.FlakyTestDetector.TableDescriptor*/ analysis = new BS.FlakyTestDetector.TableDescriptor(
          "analysis",
          "order",
          this.paramOrder,
          [this.orderByTestNameAsc, this.orderByFailureRateDesc, this.orderByFlipRateDesc]);
      this.makeSortable(this.blockContentId, [analysis]);

      /*
       * Install the ellipsis button ([...]) if there's more than one flaky
       * reason.
       */
      $j("table.analysis div.flakyReason, table.analysis ul.flakyReason").installEllipsis();

      /*
       * Click handler for the select-all checkbox.
       */
      $j("#select-" + testGroup.id).click(function (/**Object*/ e) {
        BS.TestGroup.toggleSelectAll("#" + testGroup.id, this);
        /*
         * Do not propagate click events to the
         * underlying sortable table header.
         */
        e.stopPropagation();
      });

      /*
       * Create a test group for bulk selection.
       */
      BS.Util.runWithElement(testGroup.id, function() {
        BS.TestGroup.initialize(testGroup.id, testGroup.nameIds, testGroup.projectExternalId);
      });

      /*
       * "Fix...", "Investigate / Mute..." and "Cancel" buttons.
       */
      $j(".bulk-operations-toolbar .bulk-operation-link").addClass("btn");
    }

    this.setFlakyTestCount(flakyTestCount, testLimit);
    this.setInvestigatedTestCount(investigatedTestCount);

    /*
     * Show or hide the controls when this fragment is refreshed.
     * The argument will be re-evaluated each time.
     */
    this.setControlsVisible(monitoringEnabled && investigatedTestCount > 0);
  }
});
