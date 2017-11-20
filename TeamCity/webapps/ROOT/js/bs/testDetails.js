
BS.TestDetails = {
  toggleDetails: function(element, urlToLoad) {
    var parentTr = $(element).up("tr");
    var tdCount = parentTr.select("> td").size();

    var detailsTrId = this._detailsTrId(parentTr);
    if ($(detailsTrId)) {
      // Process case when details block is already available:
      if (!this.hideDetailsRow(parentTr)) {
        // Show available block
        $(detailsTrId).show();
        this.updateTestRow(parentTr, true);
      }
      return;
    }

    this.updateTestRow(parentTr, true);
    var detailsTr = new Template("<tr id='#{rowId}' class='testDetailsRow'><td colspan='#{colspan}' class='data'>#{content}</td></tr>").evaluate(
        {
          colspan: tdCount,
          rowId: detailsTrId,
          content: '<div class="testLoading">' + BS.loadingIcon + ' Loading test details, please wait...' + '</div>'
        }
    );

    parentTr.insert({after: detailsTr});
    BS.ajaxUpdater($(detailsTrId).down("td.data"), window['base_uri'] + urlToLoad, {
      evalScripts: true
    });
  },

  _detailsTrId: function(parentTr) {
    return "testDetails_" + $(parentTr).identify();
  },

  hideDetailsRow: function(parentTr) {
    var detailsTrId = this._detailsTrId(parentTr);

    if (BS.Util.visible(detailsTrId)) {
      $(detailsTrId).hide();
      this.updateTestRow(parentTr, false);
      return true;
    }
    return false;
  },

  updateTestRow: function(tr, detailsOn) {
    tr = $(tr);
    if (detailsOn) {
      BS.Log.debug("expanding stacktrace " + tr.id);
      tr.addClassName("testDetailsShown");

      // Add a listener which runs while stacktrace is expanded
      // When stacktrace becomes non-visible on the page, it is collapsed to enable page refresh, (for BS.canReload() function)
      tr.store('on_hide_listener', setInterval(function() {
        var detailsTrId = this._detailsTrId(tr);
        if ($j(BS.Util.escapeId(detailsTrId) + ":hidden").length > 0) {
          this.hideDetailsRow(tr);
          this.updateTestRow(tr, false);
        }
      }.bind(this), 200));

      BS.BuildResults.stacktraceShown();
    } else {
      var listener = tr.retrieve('on_hide_listener');
      if (listener) {
        BS.Log.debug("collapsing stacktrace " + tr.id);

        tr.removeClassName("testDetailsShown");
        BS.BuildResults.stacktraceHidden();

        clearInterval(listener);
        tr.store('on_hide_listener', null);
      }
    }
  },

  closeDetails: function(element) {
    var detailsTr = $(element).up("tr");
    detailsTr.hide();
    var testRow = $(detailsTr.previousSibling);
    this.updateTestRow(testRow, false);
    BS.Highlight(testRow.down("td"), {duration: 2});
  },

  loadFFIInformation: function(buildId, testId, tableWithData) {

    //BS.Log.debug("loadFFIInformation buildId:" + buildId + " testId:" +testId);

    var that = this;

    // Makes a call to load stacktraceText
    that.changeCurrentRow(tableWithData, tableWithData.down('tr.selectedBuild'));

    BS.ajaxUpdater(tableWithData, "firstFailedInfo.html?buildId=" + buildId + "&testId=" + testId, {
      evalScripts: true,
      onComplete: function() {
        tableWithData.select("tr").each(function(tr) {
          if (tr.getAttribute('data-testId')) {

            tr.addClassName("clickable");
            tr.title = "Click to see stacktrace from this build";

            tr.on("click", "td", function() {
              that.changeCurrentRow(tableWithData, tr);
            })
          }
        });
      }
    });

  },

  changeCurrentRow: function(table, tr_selected) {
    var buildId = tr_selected.getAttribute('data-buildId');
    var testId = tr_selected.getAttribute('data-testId');
    var traceBlock = table.up('div.testBlock').down('.fullStacktrace');
    traceBlock.style.height = traceBlock.getDimensions().height + 'px';
    traceBlock.update();

    this.changeCurrentRowStyle(table, tr_selected);
    this.changeTextForNumberOfRuns(tr_selected);

    BS.BuildResults.expandStacktrace(traceBlock, buildId, testId, function() {
      traceBlock.style.height = 'auto';
    });
  },

  changeCurrentRowStyle: function(table, tr_selected) {
    table.select('tr').each(function(tr) {
      tr.removeClassName('selectedBuild');
    });
    tr_selected.addClassName('selectedBuild');
    var radioselector = tr_selected.down('td.selector input');
    if (radioselector) radioselector.click();
  },

  changeTextForNumberOfRuns: function(tr_selected) {
    var invocationCount = tr_selected.getAttribute('data-invocationCount');
    var failedInvocationCount = tr_selected.getAttribute('data-failedInvocationCount');

    var node = tr_selected.up(".testBlock").down(".testRunsNote");
    // The test was run 100 times in the build, 29 failures

    var text = "";
    if (invocationCount > 1) {
      text += "The test was run <b>" + invocationCount + "</b> times in the build";
      if (failedInvocationCount > 0) {
        text += ", <b>" + failedInvocationCount + "</b> failures";
      }
    }
    if (invocationCount != 0) {
      node.update(text);
    }
  },

  toggleBuildDetails: function(element, event) {
    if (event) {
      element = Event.element(event);
      if (element.tagName == 'A') return;
    }

    $(element).up('.testBlock').select('.rightBlock').invoke('toggle');
  },

  // We don't want this function to run on each AJAX refresh call, and we don't want to expand stacktrace
  // on each refresh for a running build.
  expandTestInfo:  _.once(function () {
    var index = document.location.href.indexOf('#testNameId');
    if (index > 0) {
      var id = document.location.href.substring(index + 11);
      var element = $('testNameId' + id);
      if (element) {

        $j(element.down('a.testWithDetails')).click();

        var parent_table = element.up("table");
        if (parent_table) {
          var parent_group = parent_table.previous("div.group-name");
          if (parent_group && parent_group._simple_block) {
            if (!parent_group._simple_block.isExpanded()) {
              parent_group._simple_block.changeState('', true, true);
            }
          }
        }
      }
      else {
        var attentionComment = $j("div.attentionComment").get(0);
        if (attentionComment) {
          var fullLink = document.location.href.replace("maxFailed", "maxFailedOld");
          fullLink = fullLink.replace("#testNameId", "&maxFailed=-1#testNameId");
          attentionComment.update("Cannot find the test failure, <a href='" + fullLink + "'>try loading this page</a> with all failed tests shown");
        }
      }
    }
  })
};