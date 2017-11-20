BS.Plugins = {};

(function (o) {
  o.Problems = {};

  o.registerProblem = function (id) {
    o.Problems[id] = new BS.Popup(id, {delay: 0, hideDelay: -1});
    return o.Problems[id];
  };

  o.toggleProblem = function (id, el) {
    if (!o.Problems.hasOwnProperty(id)) {
      o.registerProblem(id)
    }
    var problem = o.Problems[id];
    if (problem.isShown()) {
      problem.hidePopup()
    } else {
      problem.showPopupNearElement(el);
    }
  }
})(BS.Plugins);
