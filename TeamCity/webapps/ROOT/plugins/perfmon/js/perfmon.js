// Charts are implemented using Flot library (http://code.google.com/p/flot/), distributed under MIT license.
//
// Useful links:
// Flot API:        http://people.iola.dk/olau/flot/API.txt
// Flot examples:   http://people.iola.dk/olau/flot/examples/

if (!window.$j) {
  window.$j = window.jQuery;
}

BS.Perfmon = {
  COLORS: {
    cpu: "#CB4B4B",
    disk: "#EDC240",
    memory: "#AFD8F8"
  },

  setBuildId: function(buildId) {
    this.buildId = buildId;
  },

  init: function(chartElem, legendElem, chartData) {
    chartElem = $j(chartElem);
    legendElem = $j(legendElem);

    this.initPlot(chartElem, chartData);
    this.initLegend(legendElem);
    this.initTooltip(chartElem);
    this.initClick(chartElem);
    this.initCrosshair(chartElem, legendElem);
  },

  initPlot: function(chartElem, chartData) {
    var cpuData = [],
        diskData = [],
        memoryData = [];
    for (var i = 0; i < chartData.labels.length; i++) {
      var time = chartData.labels[i];
      cpuData.push([time, chartData.cpu[i]]);
      diskData.push([time, chartData.disk[i]]);
      memoryData.push([time, chartData.memory[i]]);
    }

    // Note: using "label_" instead of "label" causes the plot not to show the legend.
    // But the label value is still available on hover.
    this.chartData = [
      { data: cpuData, label_: "CPU", color: this.COLORS.cpu },
      { data: diskData, label_: "Disk", color: this.COLORS.disk },
      { data: memoryData, label_: "Memory", color: this.COLORS.memory }
    ];

    chartElem.css({
      width: 650,
      height: 400
    });

    this.plot = $j.plot(chartElem, this.chartData, {
      series: {
        lines: { show: true },
        points: { show: true, radius: 1 }
      },
      crosshair: {
        mode: "x"
      },
      grid: {
        hoverable: true,
        clickable: true,
        borderWidth: 1,
        borderColor: "#bbb"
      },
      xaxis: {
        mode: 'time',
        tickFormatter: function (val) {
          return BS.Perfmon.Util.formatTime(val);
        }
      },
      yaxis: {
        min: 0,
        max: 100,
        tickFormatter: function(val) {
          return val + "%";
        }
      },
      selection: {
        mode: "x"
      },
      shadowSize: 0
    });
  },

  initTooltip: function(chartElem) {
    function showTooltip(x, y, contents) {
      $j('<div id="tooltip">' + contents + '</div>').css({
        position: 'absolute',
        display: 'none',
        top: y + 6,
        left: x + 12,
        border: '1px solid #bbb',
        padding: '2px',
        'background-color': '#fff',
        opacity: 1.0
      }).appendTo("body").fadeIn(200);
    }

    var previousPoint = null;

    chartElem.bind("plothover", function(event, pos, item) {
      if (item) {
        if (previousPoint != item.dataIndex) {
          previousPoint = item.dataIndex;

          $j("#tooltip").remove();
          var time = BS.Perfmon.Util.formatTime(item.datapoint[0]),
              value = item.datapoint[1].toFixed(2);

          showTooltip(item.pageX, item.pageY, item.series.label_ + " at " + time + " is <b>" + value + "%</b>");
        }
      } else {
        $j("#tooltip").remove();
        previousPoint = null;
      }
    });
  },

  initClick: function(chartElem) {
    var that = this;
    chartElem.bind("plotclick", function (event, pos, item) {
      if (item) {
        var timestamp = item.datapoint[0];
        that.showBuildLog(timestamp);
        that.saveToUrl(timestamp);

        // Highlight the selected point.
        // that.plot.highlight(item.series, item.datapoint);
      }
    });
  },

  initCrosshair: function(chartElem, legendElem) {
    var legends = {};
    legendElem.find("label").each(function() {
      var className = $j(this).parent().attr("class");
      legends[className] = $j(this);
    });
  },

  select: function(from, to) {
    var plot = this.plot;

    // `lastFrom` provides toggle-ability.
    if (this.lastFrom == from) {
      plot.clearSelection();
      this.lastFrom = null;
    } else {
      plot.setSelection({
        xaxis: { from: from, to: to }
      });
      this.lastFrom = from;
    }
    return false;
  },

  initLegend: function(legendElem) {
    var that = this;

    legendElem.find("input").change(function() {
      var allData = that.chartData,
          data = [];

      if ($j("#show-cpu").is(":checked")) {
        data.push(allData[0]);
      }
      if ($j("#show-disk").is(":checked")) {
        data.push(allData[1]);
      }
      if ($j("#show-memory").is(":checked")) {
        data.push(allData[2]);
      }

      that.plot.setData(data);
      // that.plot.setupGrid();
      that.plot.draw();
    });

    legendElem.children().each(function() {
      var self = $j(this),
          className = self.attr("class"),
          color = that.COLORS[className];

      self.find(".color-bullet").css({ background: color });
    });

    legendElem.width(160);
  },

  showBuildLog: function(timestamp) {
    var url = base_uri + "/perfmonNavigate.html",
        buildId = this.buildId;

    $j("#loadingLog").show();
      BS.ajaxRequest(url, {
        method: "GET",
        parameters: {
          buildId: buildId,
          timestamp: timestamp
        },
        onComplete: function(xhr) {
          $j("#loadingLog").hide();

          // Insert the build log
          $j("#buildLogDiv").show();
          $j("#buildLogContainer").html(xhr.responseText);
        }
      });
  },

  saveToUrl: function(timestamp) {
    window.location.hash = "#!" + timestamp;
  },

  restoreFromUrl: function() {
    var hash = window.location.hash;
    if (hash) {
      var timestamp = hash.substring(2);
      this.showBuildLog(timestamp, true);
    }
  }
};

BS.Perfmon.Util = {
  formatTime: function(value) {
    var date = new Date(value);
    return date.getHours() + ":" + this.toString2(date.getMinutes()) + ":" + this.toString2(date.getSeconds());
  },

  toString2: function(num) {
    if (num < 10) {
      return "0" + num;
    }
    return num;
  }
};
