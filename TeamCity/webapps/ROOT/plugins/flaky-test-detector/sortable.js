BS.FlakyTestDetector = {
  /**
   * @param {String} tableId
   * @param {String} clientOrderStoreId
   * @param {String} requestParameterName
   * @param {Array.<String>} columnIds
   * @constructor
   * @struct
   * @final
   */
  TableDescriptor: function(tableId,
                            clientOrderStoreId,
                            requestParameterName,
                            columnIds) {
    "use strict";
    this.tableId = tableId;
    this.clientOrderStoreId = clientOrderStoreId;
    this.requestParameterName = requestParameterName;
    this.columnIds = columnIds;
  },

  /**
   * @param {String} refreshableId
   * @param {Object} httpRequestParameters
   */
  refreshSortables: function(refreshableId, httpRequestParameters) {
    "use strict";
    var /**String*/ httpRequestParametersAsString = $j.map(httpRequestParameters, function(/**String*/ value, /**String*/ key) {
      return key + "=" + value;
    }).join("&");
    $j("#" + refreshableId).get(0).refresh("", httpRequestParametersAsString);
  },

  /**
   * @param {String} refreshableId
   * @param {Array.<TableDescriptor>} tableDescriptors
   * @param {Object} [extraParameters] an optional map of extra HTTP parameters
   *                                   (keys are HTTP parameter names, values
   *                                   are ids of HTML elements which store
   *                                   parameter values).
   */
  makeSortable: function(refreshableId, tableDescriptors, extraParameters) {
    "use strict";
    var /**BS.FlakyTestDetector*/ flakyTestDetector = this;
    $j(tableDescriptors).each(function(/**Number*/ index, /**TableDescriptor*/ tableDescriptor) {
      var /**String*/ columnIds = $j.map(tableDescriptor.columnIds, function(/**String*/ columnId) {
        return "#" + tableDescriptor.tableId + " #" + columnId;
      }).join(", ");
      $j(columnIds).each(function(/**Number*/ index, /**HTMLElement*/ column) {
        var /**jQuery*/ $clientOrderStore = $j("#" + tableDescriptor.clientOrderStoreId);
        /*
         * Current sort ordering.
         */
        var /**String*/ order = $clientOrderStore.text();
        if (order.replace(/ASC/, "DESC") === column.id.replace(/ASC/, "DESC")) {
          /*
           * Currently sorted column.
           */
          var /**Boolean*/ orderAscending = order.indexOf("_DESC") === -1;
          /*
           * $j(this) will select HTMLTableCellElement instead of HTMLSpanElement.
           */
          $j(column).addClass(orderAscending ? "sortedAsc" : "sortedDesc");
        }

        $j(column.parentNode).click(function() {
          /*
           * Current sort ordering.
           */
          var /**String*/ oldOrder = $clientOrderStore.text();
          var /**Boolean*/ oldOrderAscending = oldOrder.indexOf("_DESC") === -1;
          var /**String*/ newOrder;
          if (oldOrder.replace(/ASC/, "DESC") === column.id.replace(/ASC/, "DESC")) {
            /*
             * Currently sorted column.
             */
            newOrder = oldOrderAscending
                ? oldOrder.replace(/ASC/, "DESC")
                : oldOrder.replace(/DESC/, "ASC");
          } else {
            newOrder = column.id;
          }
          var /**Boolean*/ newOrderAscending = newOrder.indexOf("_DESC") === -1;

          $j(columnIds).removeClass("sortedAsc");
          $j(columnIds).removeClass("sortedDesc");
          /*
           * $j(this) will select HTMLTableCellElement instead of HTMLSpanElement.
           */
          $j(column).addClass(newOrderAscending ? "sortedAsc" : "sortedDesc");

          $clientOrderStore.html(newOrder);

          var /**Object*/ httpRequestParameters = {};
          $j(tableDescriptors).each(function(/**Number*/ index, /**TableDescriptor*/ tableDescriptor) {
            httpRequestParameters[tableDescriptor.requestParameterName] = $j("#" + tableDescriptor.clientOrderStoreId).text();
          });
          if (typeof extraParameters === "object") {
            for (var /**String*/ requestParameter in extraParameters) {
              if (extraParameters.hasOwnProperty(requestParameter)) {
                httpRequestParameters[requestParameter] = $j("#" + extraParameters[requestParameter]).text();
              }
            }
          }
          flakyTestDetector.refreshSortables(refreshableId, httpRequestParameters);
        });
      });
    });
  }
};
