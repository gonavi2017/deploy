BS.ProjectHierarchyBlock = Class.create(BS.BlockWithHandle, {
  initialize: function($super, blockTypeId, blockId, collapsedByDefault, persist, projectExtId) {
    this.mustPersistState = !!persist;
    this._projectExtId = projectExtId;
    $super(blockTypeId, blockId, collapsedByDefault, true);
  },
  
  getBlockContentElement: function() {
    return jQuery('#btb' + this.blockId);
  },

  onShowBlock: function($super, contentElement, id) {
    $super(contentElement, id);
    if (this._projectExtId && jQuery('.projectBlockHidden_' + this._projectExtId)) {
      jQuery('.projectBlockHidden_' + this._projectExtId).hide();
    }
  },

  onHideBlock: function($super, contentElement, id) {
    $super(contentElement, id);
    if (this._projectExtId && jQuery('.projectBlockHidden_' + this._projectExtId)) {
      jQuery('.projectBlockHidden_' + this._projectExtId).show();
    }
  }
});
             
BS.ProjectHierarchyTree = {
  patchHandle: function (block, controllerUrl, contentContainerId, ajaxParameters) {
    var oldChangeState = block.changeState;
    block.changeState = function (id, now, showBlock, all) {
      block.changeState = oldChangeState;
      block.changeState(id, now, showBlock);
      if (all) {
        ajaxParameters.__openAllProjects = "true";
      }
      BS.ajaxRequest(window['base_uri'] + "/" + controllerUrl, {
        parameters: ajaxParameters,
        method: "GET",
        onComplete: function (transport) {
          var response = transport.responseText;
          if (response != null) {
            $j("#" + contentContainerId).replaceWith(response);
            BS.ProjectHierarchyTree.registerHandle(block.getId(), true);
          }
        }
      });
    };
  },
  registerHandle: function (id, collapsed, persist, projectExtId) {
    persist = persist || false;
    var block = new BS.ProjectHierarchyBlock("projectHierarchy", id, collapsed, persist, projectExtId);
    BS.CollapsableBlocks.registerBlock(block, "projectHierarchy");
    if (persist) {
      block.restoreSavedBlocks();
    }
  },
  findCollapsibleBlock: function (id) {
    return BS.CollapsableBlocks._blocks("projectHierarchy")[id];
  },
  expandAll: function() {
    var blocks = BS.CollapsableBlocks._blocks('projectHierarchy');
    for (var id in blocks) {
      if (!blocks.hasOwnProperty(id)) continue;

      if (!blocks[id].isExpanded(id)) {
        blocks[id].changeState(id, true, true, true);
        blocks[id]._saveState();
      }
    }
    return false;
  }
};