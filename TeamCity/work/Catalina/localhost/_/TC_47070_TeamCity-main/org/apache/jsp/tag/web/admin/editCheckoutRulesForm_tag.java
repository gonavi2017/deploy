/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:46 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class editCheckoutRulesForm_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(14);
    _jspx_dependants.put("/WEB-INF/tags/help.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/smallNote.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/cancel.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/modalDialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/dialog.tag", Long.valueOf(1504702504000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
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
  private java.lang.String formAction;

  public java.lang.String getFormAction() {
    return this.formAction;
  }

  public void setFormAction(java.lang.String formAction) {
    this.formAction = formAction;
    jspContext.setAttribute("formAction", formAction);
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
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
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
    if( getFormAction() != null ) 
      _jspx_page_context.setAttribute("formAction", getFormAction());

    try {
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_bs_005fmodalDialog_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
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
    }
  }

  private boolean _jspx_meth_bs_005fmodalDialog_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:modalDialog
    org.apache.jsp.tag.web.modalDialog_tag _jspx_th_bs_005fmodalDialog_005f0 = new org.apache.jsp.tag.web.modalDialog_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fmodalDialog_005f0);
    try {
      _jspx_th_bs_005fmodalDialog_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fmodalDialog_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(7,0) name = formId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fmodalDialog_005f0.setFormId("editCheckoutRulesForm");
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(7,0) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fmodalDialog_005f0.setTitle("");
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(7,0) name = action type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fmodalDialog_005f0.setAction((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${formAction}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(7,0) name = closeCommand type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fmodalDialog_005f0.setCloseCommand("BS.EditCheckoutRulesForm.cancelDialog()");
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(7,0) name = saveCommand type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fmodalDialog_005f0.setSaveCommand("BS.EditCheckoutRulesForm.submit()");
      _jspx_th_bs_005fmodalDialog_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005fmodalDialog_005f0, null));
      _jspx_th_bs_005fmodalDialog_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fmodalDialog_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fsmallNote_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:smallNote
    org.apache.jsp.tag.web.smallNote_tag _jspx_th_bs_005fsmallNote_005f0 = new org.apache.jsp.tag.web.smallNote_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fsmallNote_005f0);
    try {
      _jspx_th_bs_005fsmallNote_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fsmallNote_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005fsmallNote_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_bs_005fsmallNote_005f0, null));
      _jspx_th_bs_005fsmallNote_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fsmallNote_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fhelp_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:help
    org.apache.jsp.tag.web.help_tag _jspx_th_bs_005fhelp_005f0 = new org.apache.jsp.tag.web.help_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fhelp_005f0);
    try {
      _jspx_th_bs_005fhelp_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fhelp_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(23,74) name = file type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelp_005f0.setFile("VCS+Checkout+Rules");
      _jspx_th_bs_005fhelp_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fhelp_005f0);
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
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(31,4) name = name type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setName("saveCheckoutRules");
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(31,4) name = label type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setLabel("Save");
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
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(32,4) name = onclick type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcancel_005f0.setOnclick("BS.EditCheckoutRulesForm.cancelDialog()");
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(32,4) name = showdiscardchangesmessage type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcancel_005f0.setShowdiscardchangesmessage("false");
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
      // /WEB-INF/tags/admin/editCheckoutRulesForm.tag(33,4) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsaving_005f0.setId("saveRulesProgress");
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
      out.write("\r\n");
      out.write("  <h2 id=\"vcsRootName\" class=\"noBorder\"></h2>\r\n");
      out.write("\r\n");
      out.write("  <div class=\"posRel\">\r\n");
      out.write("    <textarea rows=\"6\" cols=\"58\" name=\"checkoutRules\" id=\"checkoutRules\" class=\"buildTypeParams\" wrap=\"off\"></textarea>\r\n");
      out.write("    <span id=\"checkoutRulesVcsTree\"></span>\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("  <span class=\"error\" id=\"errorCheckoutRules\" style=\"margin-left: 0;\"></span>\r\n");
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_bs_005fsmallNote_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <div class=\"popupSaveButtonsBlock\" id=\"editCheckoutRulesFormSaveBlock\">\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsubmit_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fcancel_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsaving_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("  <input type=\"hidden\" name=\"vcsRootId\" value=\"\"/>\r\n");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("    Newline-delimited set of rules in the form of +|-:VCSPath[=>AgentPath]");
      if (_jspx_meth_bs_005fhelp_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("<br/>\r\n");
      out.write("    <!--By default, all is included<br/>-->\r\n");
      out.write("    e.g. use <strong>-:.</strong> to exclude all, or <strong>-:repository/path</strong> to exclude only the path from checkout<br/>\r\n");
      out.write("    or <strong>+:repository/path => another/path</strong> to map to different path.<br/>\r\n");
      out.write("    Note: checkout rules can only be set to directories, files are <strong>not</strong> supported.\r\n");
      out.write("  ");
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
          case 1:
            invoke1( out );
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
