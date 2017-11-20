<%@ include file="../include-internal.jsp"

%><bs:page
  ><jsp:attribute name="page_title">Changes</jsp:attribute>
    <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/progress.css
      /css/filePopup.css
      /css/overviewTable.css
      /css/viewModification.css

      /css/changes.css
      /css/buildQueue.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/tree/tree_model.js
      /js/tree/tree_selection.js
      /js/bs/async.js
      /js/raphael-min.js
      /js/raphael.pieChart.js

      /js/bs/pieChartStatus.js
      /js/bs/changes.js
      /js/bs/buildResultsDiv.js
      /js/bs/testDetails.js
      /js/bs/hideSuccessfulBuildTypes.js

      /js/bs/blocks.js
      /js/bs/blockWithHandle.js
      /js/bs/testGroup.js

      /js/bs/queueLikeSorter.js
      /js/bs/buildQueue.js

      /js/bs/collapseExpand.js
      /js/bs/projectHierarchy.js

      /js/bs/runningBuilds.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
        {title: "Changes", selected:true}
      ];

      BS.topNavPane.setActiveCaption('changes');
    </script>

  <et:subscribeOnEvents>
    <jsp:attribute name="eventNames">
      BUILD_FINISHED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.ChangePage.updateChanges();
    </jsp:attribute>
  </et:subscribeOnEvents>
  <et:subscribeOnUserEvents userId="${currentUser.id}">
    <jsp:attribute name="eventNames">
      CHANGE_ADDED
      PERSONAL_BUILD_CHANGED_STATUS
      PERSONAL_BUILD_STARTED
      PERSONAL_BUILD_FINISHED
      PERSONAL_BUILD_ADDED_TO_QUEUE
      PERSONAL_BUILD_INTERRUPTED
    </jsp:attribute>
    <jsp:attribute name="eventHandler">
      BS.ChangePage.updateChanges();
    </jsp:attribute>
  </et:subscribeOnUserEvents>

  </jsp:attribute
  ><jsp:attribute name="body_include">

    <div class="actionBar">
      <div id="projectsFilter"></div>

      <label>Show changes by:</label>
      <input type="text" id="userIdSelector" value="${currentUser.id > 0 ? "<me>" : "<all>"}"/>

      <label for="filterBuildConfigurations" class="rightLabel"><input type="checkbox" id="filterBuildConfigurations"/> Hide configurations excluded from my Projects dashboard</label>
    </div>

    <c:url var="vcsLink" value="/profile.html?item=vcsUsernames&init=1"></c:url>
    <div class="icon_before icon16 attentionComment" style="display: none;" id="no_regular_changes">
        <span id="anotherUserChanges" style="display: none;">
          We didn't find any VCS changes committed by this user.
        </span>
        <span id="noneChangesAvailable" style="display: none;">
          We didn't find any available VCS changes.
        </span>
        <span id="thisUserChanges" style="display: none;">
          We didn't find any VCS changes committed by you.
          Please make sure <a href="${vcsLink}">your VCS username settings</a> are correct and you have permissions to view relevant projects.
        </span>
    </div>

    <div id="loadingProgress"></div>

    <div id="updatableChangesContainer"></div><%-- container for changes not older than UPDATABLE_DAYS_COUNT (3) --%>
    <div id="moreChangesContainer"></div>

    <div id="showMoreChanges" style="display: none;">
      <a class="btn showMoreChangesLink" title="Load more change records" href="#" onclick="BS.ChangePage.showMoreChanges(); return false">More</a>
      <forms:progressRing id="showMoreChangesProgress" className="showMoreChangesProgress" style="display: none;"/>
    </div>

    <script>
      (function() {
        <%@ include file="updateFilter.jspf"%>

        function initialize_user_autocompletion() {
          var userSelector = $j("#userIdSelector");
          userSelector.autocomplete({
                                      source: BS.ChangePageFilter.createFindUserFunction('#userIdSelector', window['base_uri']),
                                      delay: 300,
                                      minLength: 1,
                                      search: null,
                                      showOnFocus: true,
                                      showEmpty: true,
                                      onEnterWhenInactive: function(event) {

                                        var that = this,
                                            ul = this.menu.element,
                                            currentText = userSelector.val();

                                        ul.children("li").each(function() {
                                          var li = $j(this);
                                          var exactUserMatch = (li.text() == currentText) || li.text().indexOf('(' +currentText+ ')') > 0;
                                          if (exactUserMatch) {
                                            that.activateItem(li);
                                            event.preventDefault();
                                          }
                                        })

                                      }
                                    });

          userSelector.on("focus", function() {
            setTimeout(function() {
              userSelector.select()
            }, 100);
          });
          userSelector.on("autocompleteselect", function(event, selectedItem) {
            BS.Log.info("Set user filter to: " + selectedItem.item.value + " " + selectedItem.item.userId);
            var that = BS.ChangePageFilter;
            if (that.changesOwnerId != selectedItem.item.userId) {
              that.resetProjects();
            }
            that.changesOwnerId = selectedItem.item.userId;
            that.refresh();
            userSelector.blur();
          });
        }

        setTimeout(initialize_user_autocompletion, 42);


        BS.UserBuildTypes = ${userBuildTypesJson};
        BS.UserBuildTypesMap = {};
        for(var i = 0; i < BS.UserBuildTypes.length; i ++) {
          BS.UserBuildTypesMap[BS.UserBuildTypes[i].id] = BS.UserBuildTypes[i];
        }
        BS.ChangePageFilter.refresh();

        $('filterBuildConfigurations').on("click", function() {
          setTimeout(function() {
            if ($('filterBuildConfigurations').checked) {
              BS.ChangePage.showUsingFilter();
            }
            else {
              BS.ChangePage.showAll();
            }
          }, 10);
        });

      })();
    </script>
  </jsp:attribute>
</bs:page>
