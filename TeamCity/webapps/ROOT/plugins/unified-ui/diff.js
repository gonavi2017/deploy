(function ($) {
  BS.DiffView = {
    init: function (diffTool) {
      if (diffTool.getMode() == 2) {
        this.originalEditor = diffTool.getController().getOriginalEditor();
        this.modifiedEditor = diffTool.getController().getModifiedEditor();
      } else if (diffTool.getMode() == 8) {
        this.originalEditor = diffTool.getController().getEditor();
        this.modifiedEditor = diffTool.getController().getEditor();
      }

      this.toolbar = $('.diff-header__toolbar');
      this.toolbarBefore = this.toolbar.find('.column-before');
      this.toolbarAfter = this.toolbar.find('.column-after');

      this.initClipboard();

      this.twoPaneDiff = $('.ring-diff_doublepane');
      if (this.twoPaneDiff.length > 0) {
        this.diffMenu = this.twoPaneDiff.find('.ring-diff__menu');
        this.diffCode = this.twoPaneDiff.find('.ring-diff__code');
        this.diffMap = this.twoPaneDiff.find('.ring-diff__map');

        this.diffOriginal = this.twoPaneDiff.find('.ring-diff__original');
        this.diffModified = this.twoPaneDiff.find('.ring-diff__modified');
        this.diffSplit = this.twoPaneDiff.find('.ring-diff__split');

        this.doResize();
        $(window).resize(_.bind(this.doResize, this));
      } else {
        this.toolbarBefore.removeClass("invisible");
        this.toolbarAfter.remove();
      }
    },

    doResize: function () {
      var targetHeight = this.twoPaneDiff.height() - this.diffMenu.height() - 10;

      this.diffCode.height(targetHeight);
      this.diffMap.height(targetHeight);

      this.toolbarBefore
          .css({left: 0, width: this.diffOriginal.width()})
          .removeClass("invisible");
      this.toolbarAfter
          .css({left: this.diffOriginal.width() + this.diffSplit.width(), width: this.diffModified.width() + this.diffMap.width() + 4})
          .removeClass("invisible")
    },

    initClipboard: function () {
      var clipboardButtons = this.toolbar.find('.clipboard');

      var self = this;
      var getContent = function (el) {
        var diffPanel = $(el).data('for');
        var editor;
        var content = '';

        if (diffPanel == 'original') editor = self.originalEditor;
        else if (diffPanel == 'modified') editor = self.modifiedEditor;

        if (editor) {
          content = editor.getValue();
        }

        return content;
      };

      if (window['clipboardData']) {
        clipboardButtons.click(function () {
          window.clipboardData.setData("Text", getContent(this));
          return false;
        });
      } else if (swfobject.getFlashPlayerVersion().major > 0) {
        clipboardButtons.zclip({
          path: window.base_uri + '/img/ZeroClipboard.swf',
          copy: function () {
            return getContent(this);
          },
          afterCopy: function () {}
        });
      } else {
        clipboardButtons.addClass('invisible');
      }
    }
  };
})(jQuery);
