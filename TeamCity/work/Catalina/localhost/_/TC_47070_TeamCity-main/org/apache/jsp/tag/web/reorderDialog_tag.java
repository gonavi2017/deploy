/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:47 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class reorderDialog_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


private static org.apache.jasper.runtime.ProtectedFunctionMapper _jspx_fnmap_0;

static {
  _jspx_fnmap_0= org.apache.jasper.runtime.ProtectedFunctionMapper.getMapForFunction("fn:toLowerCase", org.apache.taglibs.standard.functions.Functions.class, "toLowerCase", new Class[] {java.lang.String.class});
}

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(7);
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/dialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/cancel.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public void setJspContext(javax.servlet.jsp.JspContext ctx) {
    super.setJspContext(ctx);
    java.util.ArrayList _jspx_nested = null;
    java.util.ArrayList _jspx_at_begin = null;
    java.util.ArrayList _jspx_at_end = null;
    this.jspContext = new org.apache.jasper.runtime.JspContextWrapper(ctx, _jspx_nested, _jspx_at_begin, _jspx_at_end, null);
  }

  public javax.servlet.jsp.JspContext getJspContext() {
    return this.jspContext;
  }
  private java.lang.String dialogId;
  private java.lang.String dialogTitle;
  private java.lang.String dialogClass;
  private javax.servlet.jsp.tagext.JspFragment sortables;
  private javax.servlet.jsp.tagext.JspFragment messageBody;
  private javax.servlet.jsp.tagext.JspFragment actionsExtension;

  public java.lang.String getDialogId() {
    return this.dialogId;
  }

  public void setDialogId(java.lang.String dialogId) {
    this.dialogId = dialogId;
    jspContext.setAttribute("dialogId", dialogId);
  }

  public java.lang.String getDialogTitle() {
    return this.dialogTitle;
  }

  public void setDialogTitle(java.lang.String dialogTitle) {
    this.dialogTitle = dialogTitle;
    jspContext.setAttribute("dialogTitle", dialogTitle);
  }

  public java.lang.String getDialogClass() {
    return this.dialogClass;
  }

  public void setDialogClass(java.lang.String dialogClass) {
    this.dialogClass = dialogClass;
    jspContext.setAttribute("dialogClass", dialogClass);
  }

  public javax.servlet.jsp.tagext.JspFragment getSortables() {
    return this.sortables;
  }

  public void setSortables(javax.servlet.jsp.tagext.JspFragment sortables) {
    this.sortables = sortables;
    jspContext.setAttribute("sortables", sortables);
  }

  public javax.servlet.jsp.tagext.JspFragment getMessageBody() {
    return this.messageBody;
  }

  public void setMessageBody(javax.servlet.jsp.tagext.JspFragment messageBody) {
    this.messageBody = messageBody;
    jspContext.setAttribute("messageBody", messageBody);
  }

  public javax.servlet.jsp.tagext.JspFragment getActionsExtension() {
    return this.actionsExtension;
  }

  public void setActionsExtension(javax.servlet.jsp.tagext.JspFragment actionsExtension) {
    this.actionsExtension = actionsExtension;
    jspContext.setAttribute("actionsExtension", actionsExtension);
  }

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    return _jsp_instancemanager;
  }

  private void _jspInit(javax.servlet.ServletConfig config) {
    _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.release();
  }

  public void doTag() throws javax.servlet.jsp.JspException, java.io.IOException {
    javax.servlet.jsp.PageContext _jspx_page_context = (javax.servlet.jsp.PageContext)jspContext;
    javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest) _jspx_page_context.getRequest();
    javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse) _jspx_page_context.getResponse();
    javax.servlet.http.HttpSession session = _jspx_page_context.getSession();
    javax.servlet.ServletContext application = _jspx_page_context.getServletContext();
    javax.servlet.ServletConfig config = _jspx_page_context.getServletConfig();
    javax.servlet.jsp.JspWriter out = jspContext.getOut();
    _jspInit(config);
    jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,jspContext);
    if( getDialogId() != null ) 
      _jspx_page_context.setAttribute("dialogId", getDialogId());
    if( getDialogTitle() != null ) 
      _jspx_page_context.setAttribute("dialogTitle", getDialogTitle());
    if( getDialogClass() != null ) 
      _jspx_page_context.setAttribute("dialogClass", getDialogClass());
    if( getSortables() != null ) 
      _jspx_page_context.setAttribute("sortables", getSortables());
    if( getMessageBody() != null ) 
      _jspx_page_context.setAttribute("messageBody", getMessageBody());
    if( getActionsExtension() != null ) 
      _jspx_page_context.setAttribute("actionsExtension", getActionsExtension());

    try {
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_bs_005fdialog_005f0(_jspx_page_context))
        return;
    } catch( java.lang.Throwable t ) {
      if( t instanceof javax.servlet.jsp.SkipPageException )
          throw (javax.servlet.jsp.SkipPageException) t;
      if( t instanceof java.io.IOException )
          throw (java.io.IOException) t;
      if( t instanceof java.lang.IllegalStateException )
          throw (java.lang.IllegalStateException) t;
      if( t instanceof javax.servlet.jsp.JspException )
          throw (javax.servlet.jsp.JspException) t;
      throw new javax.servlet.jsp.JspException(t);
    } finally {
      jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,super.getJspContext());
      ((org.apache.jasper.runtime.JspContextWrapper) jspContext).syncEndTagFile();
      _jspDestroy();
    }
  }

  private boolean _jspx_meth_bs_005fdialog_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:dialog
    org.apache.jsp.tag.web.dialog_tag _jspx_th_bs_005fdialog_005f0 = new org.apache.jsp.tag.web.dialog_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fdialog_005f0);
    try {
      _jspx_th_bs_005fdialog_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fdialog_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/reorderDialog.tag(12,0) name = dialogId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setDialogId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${dialogId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/reorderDialog.tag(12,0) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("Reorder ${dialogTitle}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/reorderDialog.tag(12,0) name = closeCommand type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setCloseCommand((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("$j('#${dialogId}').trigger('closeDialog')", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/reorderDialog.tag(12,0) name = dialogClass type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setDialogClass((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${dialogClass} reorderDialog", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/reorderDialog.tag(12,0) name = titleId type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setTitleId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${dialogId}Title", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005fdialog_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005fdialog_005f0, null));
      _jspx_th_bs_005fdialog_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fdialog_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fout_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:out
    org.apache.taglibs.standard.tag.rt.core.OutTag _jspx_th_c_005fout_005f0 = (org.apache.taglibs.standard.tag.rt.core.OutTag) _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.OutTag.class);
    boolean _jspx_th_c_005fout_005f0_reused = false;
    try {
      _jspx_th_c_005fout_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fout_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /WEB-INF/tags/reorderDialog.tag(15,23) name = value type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fout_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${fn:toLowerCase(dialogTitle)}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), _jspx_fnmap_0, false));
      int _jspx_eval_c_005fout_005f0 = _jspx_th_c_005fout_005f0.doStartTag();
      if (_jspx_th_c_005fout_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005fout_005f0);
      _jspx_th_c_005fout_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fout_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fout_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fsubmit_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:submit
    org.apache.jsp.tag.web.forms.submit_tag _jspx_th_forms_005fsubmit_005f0 = new org.apache.jsp.tag.web.forms.submit_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fsubmit_005f0);
    try {
      _jspx_th_forms_005fsubmit_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fsubmit_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/reorderDialog.tag(29,6) name = type type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setType("button");
      // /WEB-INF/tags/reorderDialog.tag(29,6) name = label type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setLabel("Apply");
      // /WEB-INF/tags/reorderDialog.tag(29,6) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setId("saveOrderButton");
      _jspx_th_forms_005fsubmit_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fsubmit_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcancel_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:cancel
    org.apache.jsp.tag.web.forms.cancel_tag _jspx_th_forms_005fcancel_005f0 = new org.apache.jsp.tag.web.forms.cancel_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcancel_005f0);
    try {
      _jspx_th_forms_005fcancel_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcancel_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/reorderDialog.tag(30,6) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcancel_005f0.setId("cancelButton");
      _jspx_th_forms_005fcancel_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcancel_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fsaving_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:saving
    org.apache.jsp.tag.web.forms.saving_tag _jspx_th_forms_005fsaving_005f0 = new org.apache.jsp.tag.web.forms.saving_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fsaving_005f0);
    try {
      _jspx_th_forms_005fsaving_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fsaving_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/reorderDialog.tag(31,6) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsaving_005f0.setId("saveOrderProgress");
      _jspx_th_forms_005fsaving_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fsaving_005f0);
    }
    return false;
  }

  private class Helper
      extends org.apache.jasper.runtime.JspFragmentHelper
  {
    private javax.servlet.jsp.tagext.JspTag _jspx_parent;
    private int[] _jspx_push_body_count;

    public Helper( int discriminator, javax.servlet.jsp.JspContext jspContext, javax.servlet.jsp.tagext.JspTag _jspx_parent, int[] _jspx_push_body_count ) {
      super( discriminator, jspContext, _jspx_parent );
      this._jspx_parent = _jspx_parent;
      this._jspx_push_body_count = _jspx_push_body_count;
    }
    public boolean invoke0( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("  <form id=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${dialogId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("Form\">\r\n");
      out.write("    <div>Drag and drop ");
      if (_jspx_meth_c_005fout_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write(" to change the current order.</div>\r\n");
      out.write("    ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getMessageBody() != null) {
        getMessageBody().invoke(_jspx_sout);
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <div class=\"messagesHolder\">\r\n");
      out.write("      <div id=\"savingData\"><i class=\"icon-refresh icon-spin\"></i> Saving...</div>\r\n");
      out.write("      <div id=\"dataSaved\"></div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div id=\"sortableList\" class=\"custom-scroll\">\r\n");
      out.write("      ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getSortables() != null) {
        getSortables().invoke(_jspx_sout);
      }
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"popupSaveButtonsBlock\">\r\n");
      out.write("      ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getActionsExtension() != null) {
        getActionsExtension().invoke(_jspx_sout);
      }
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005fsubmit_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005fcancel_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005fsaving_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("  </form>\r\n");
      return false;
    }
    public void invoke( java.io.Writer writer )
      throws javax.servlet.jsp.JspException
    {
      javax.servlet.jsp.JspWriter out = null;
      if( writer != null ) {
        out = this.jspContext.pushBody(writer);
      } else {
        out = this.jspContext.getOut();
      }
      try {
        Object _jspx_saved_JspContext = this.jspContext.getELContext().getContext(javax.servlet.jsp.JspContext.class);
        this.jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,this.jspContext);
        switch( this.discriminator ) {
          case 0:
            invoke0( out );
            break;
        }
        jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,_jspx_saved_JspContext);
      }
      catch( java.lang.Throwable e ) {
        if (e instanceof javax.servlet.jsp.SkipPageException)
            throw (javax.servlet.jsp.SkipPageException) e;
        throw new javax.servlet.jsp.JspException( e );
      }
      finally {
        if( writer != null ) {
          this.jspContext.popBody();
        }
      }
    }
  }
}
