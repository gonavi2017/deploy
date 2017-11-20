/**
 * Json received from the server is compressed - fields names are represented by one letter.
 * See RunBuildsStatusManager.
 */
BS.RunningBuilds = {

  subscribeOnBuild: function (buildId) {
    BS.SubscriptionManager.subscribe('rb/' + buildId, function(message) {
      var buildNode = JSON.parse(message);
      if (!buildNode) return;

      var buildId = buildNode.a;
      var buildTypeId = buildNode.b;

      BS.RunningBuilds.processNode(buildNode, buildId);

      if (BS.ProblemsSummary) {
        BS.ProblemsSummary.requestBuildTypeUpdate(buildTypeId);
      }
    })
  },

  unsubscribeFromBuild: function (buildId) {
    BS.SubscriptionManager.unsubscribe('rb/' + buildId);
  },

  processNode: function(node, buildId) {
    this.updateStatusIcon(node, buildId);
    this.updateDescription(node, buildId);
    this.updateDuration(node, buildId);
    this.updateProgress(node, buildId);
    this.updateArtifactsLink(node, buildId);
    this.updateBuildTypeStatus(node);
  },

  findNestedDiv: function(element) {
    return $(element.getElementsByTagName("div")[0]);
  },

  updateStatusIcon: function(node, buildId) {
    var getMod = function (elem, blockName) {
          var _prefix = blockName + '_',
              RE = new RegExp(_prefix + '[^ ]+', 'g');

          return (elem.className.match(RE) || []).map(function(className) {
            return className.replace(_prefix, '');
          })[0] || null;
        },
        setMod = function (elem, blockName, modName) {
          var _prefix = blockName + '_',
              className = elem.className;

          elem.className = className.replace(new RegExp(_prefix  + '[^ ]+', 'g'), '') +
                           ' ' + _prefix + modName;
        },
        icon = $('build:' + buildId + ":img");

    if (icon) {
      var successful = node.d;
      var personal = node.f;
      var currentMod = getMod(icon, 'build-status-icon');
      var newMod = currentMod;

      if (personal) {
        newMod = newMod.split('-')[0] + '-running' + (successful ? '' : '-failing');
      } else {
        newMod = "running-" + (successful ? "green" : "red") + "-transparent";
      }

      if (currentMod != newMod) {
        setMod(icon, 'build-status-icon', newMod);
      }
    }
  },

  updateDescription: function(node, buildId) {
    var txtNode = $('build:' + buildId + ":text");

    if (txtNode) {
      var textContent = node.c;
      textContent = textContent.escapeHTML();
      if (textContent.length > 100) {
        textContent = textContent.substring(0, 100) + "&hellip;";
      }
      txtNode.innerHTML = textContent;
    }
  },

  updateDuration: function(node, buildId) {
    var elapsedTime = node.m;
    var durationNode = $('build:' + buildId + ":duration");

    if (durationNode) {
      durationNode.innerHTML = elapsedTime;
    }
  },

  updateProgress: function(node, buildId) {
    this.doUpdateProgress(
      buildId,
      true,
      node.m, //elapsedTime
      node.j, //totalEstimate
      node.k, //remainingTime
      node.l, //exceededEstimatedDurationTime
      node.h, //showOvertimedIcon
      node.g, //showAsExceeded
      node.i, //showTimeLeft
      node.d, //successful
      node.n  //completedPercent
    );
  },

  doUpdateProgress: function(buildId, updateNestedDiv, elapsedTime, totalEstimate, remainingTime, exceededDurationTime, showOvertimedIcon, showOvertimedOnBar, showTimeLeft, successful, completedPercent) {
    var holderNode = $('build:' + buildId);

    if (holderNode == null) return;

    var progressNode = holderNode.select(".progress")[0];
    var dateNode = holderNode.select(".start_date")[0];

    if (progressNode && dateNode) {

      var title = "Started: " + dateNode.innerHTML + "<br>" + elapsedTime + " passed";

      if (totalEstimate != 'N/A') {
        title += " of " + totalEstimate + " initially estimated";
      }

      var nestedDiv = this.findNestedDiv(progressNode);

      if (nestedDiv) {
        if ('N/A' == remainingTime) {
          if (updateNestedDiv) {
            nestedDiv.style.width = "100%";
          }
        }
        else {
          if (showOvertimedIcon) {
            BS.Util.show($('build:' + buildId + ':overtime_icon'));
          } else {
            BS.Util.hide($('build:' + buildId + ':overtime_icon'));
          }

          if (showTimeLeft) {
            title += "<br>" + (showOvertimedIcon ? "more than " : "") + remainingTime + " left";
          }

          if (showOvertimedIcon) {
            title += "<br>" + exceededDurationTime + " overtime";
          }

          if (updateNestedDiv) {
            if (showOvertimedOnBar) {
              nestedDiv = this.setTextInProgress(progressNode, "overtime: " + exceededDurationTime);
            } else {
              nestedDiv = this.setTextInProgress(progressNode, remainingTime + " left");
            }

            nestedDiv.removeClassName('progressInnerSuccessful');
            nestedDiv.removeClassName('progressInnerFailed');
            nestedDiv.addClassName(successful ? 'progressInnerSuccessful' : 'progressInnerFailed');
            nestedDiv.style.width = completedPercent + "%";
          }
        }
      }

      var agentLink = $('aLink:' + buildId);
      if (agentLink && agentLink.innerHTML != '') {
        title += "<br>Agent: " + agentLink.innerHTML;
      }

      var progressId = progressNode.id;
      progressNode._title = title;
      if (!progressNode._eventsBound) {
        holderNode.on("mouseenter", function() {
          BS.Tooltip.showMessage($(progressId), {shift:{x:10,y:20}}, $(progressId)._title);
        });
        holderNode.on("mouseleave", function() {
          BS.Tooltip.hidePopup();
        });
        progressNode._eventsBound = true;
      }
    }
  },

  setTextInProgress: function(progressNode, text) {
    var t = "&nbsp;&nbsp;" + text.replace(/ /g, "&nbsp;");
    progressNode.innerHTML = t + "<div class='progressInner'>" + t + "</div>";

    return this.findNestedDiv(progressNode); // refresh after HTML change
  },

  updateArtifactsLink: function(node, buildId) {
    var hasArtifacts = node.o === true;

    if (hasArtifacts) {
      var artifactsLink = $('build:' + buildId + ':artifactsLink');
      var noArtifactsText = $('build:' + buildId + ':noArtifactsText');
      if (artifactsLink && noArtifactsText) {
        artifactsLink.style.display = 'inline';
        noArtifactsText.style.display = 'none';
      }
    }
  },

  updateBuildTypeStatus: function(node) {
    var buildTypeId = node.b;
    var breadcrumbNode = $j('#mainNavigation').children('.buildType');

    if (breadcrumbNode.attr('data-buildTypeId') == buildTypeId) {
      breadcrumbNode.toggleClass('failed', !node.e);
    }
  }
};


