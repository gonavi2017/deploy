/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class adminProjectsSearchField_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("/WEB-INF/tags/forms/textField.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/filterButton.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/resetFilter.tag", Long.valueOf(1504702500000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody;

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
  private jetbrains.buildServer.controllers.admin.AdminOverviewBean adminOverviewForm;

  public jetbrains.buildServer.controllers.admin.AdminOverviewBean getAdminOverviewForm() {
    return this.adminOverviewForm;
  }

  public void setAdminOverviewForm(jetbrains.buildServer.controllers.admin.AdminOverviewBean adminOverviewForm) {
    this.adminOverviewForm = adminOverviewForm;
    jspContext.setAttribute("adminOverviewForm", adminOverviewForm);
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
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.release();
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
    if( getAdminOverviewForm() != null ) 
      _jspx_page_context.setAttribute("adminOverviewForm", getAdminOverviewForm());

    try {
      out.write("<form action=\"");
      if (_jspx_meth_c_005furl_005f0(_jspx_page_context))
        return;
      out.write("\" method=\"get\">\r\n");
      out.write("  <div class=\"actionBar\">\r\n");
      out.write("    <span class=\"nowrap\">\r\n");
      out.write("      <label class=\"firstLabel\" for=\"keyword\">Filter: </label>\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005ftextField_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    </span>\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005ffilterButton_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <span style=\"margin-left: 20px;\">\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005fcheckbox_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("      <label for=\"includeArchived\" style=\"margin: 0;\">Show archived</label>\r\n");
      out.write("    </span>\r\n");
      out.write("    <div class=\"clearfix\"></div>\r\n");
      out.write("  </div>\r\n");
      out.write("  <input type=\"hidden\" name=\"item\" value=\"projects\">\r\n");
      out.write("</form>\r\n");
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

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(5,16) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue("/admin/admin.html");
      int _jspx_eval_c_005furl_005f0 = _jspx_th_c_005furl_005f0.doStartTag();
      if (_jspx_th_c_005furl_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f0);
      _jspx_th_c_005furl_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f0, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005ftextField_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:textField
    org.apache.jsp.tag.web.forms.textField_tag _jspx_th_forms_005ftextField_005f0 = new org.apache.jsp.tag.web.forms.textField_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005ftextField_005f0);
    try {
      _jspx_th_forms_005ftextField_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005ftextField_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(9,6) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005ftextField_005f0.setName("keyword");
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(9,6) name = value type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005ftextField_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminOverviewForm.keyword}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(9,6) name = size type = java.lang.Integer reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005ftextField_005f0.setSize(new java.lang.Integer(20));
      _jspx_th_forms_005ftextField_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005ftextField_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005ffilterButton_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:filterButton
    org.apache.jsp.tag.web.forms.filterButton_tag _jspx_th_forms_005ffilterButton_005f0 = new org.apache.jsp.tag.web.forms.filterButton_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005ffilterButton_005f0);
    try {
      _jspx_th_forms_005ffilterButton_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005ffilterButton_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      _jspx_th_forms_005ffilterButton_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005ffilterButton_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f0_reused = false;
    try {
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(12,4) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty adminOverviewForm.keyword}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          if (_jspx_meth_c_005furl_005f1(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          if (_jspx_meth_forms_005fresetFilter_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
      _jspx_th_c_005fif_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f1 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f1_reused = false;
    try {
      _jspx_th_c_005furl_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(13,9) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f1.setValue("/admin/admin.html?item=projects&keyword=");
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(13,9) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f1.setVar("resetUrl");
      int _jspx_eval_c_005furl_005f1 = _jspx_th_c_005furl_005f1.doStartTag();
      if (_jspx_th_c_005furl_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f1);
      _jspx_th_c_005furl_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f1, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fresetFilter_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:resetFilter
    org.apache.jsp.tag.web.forms.resetFilter_tag _jspx_th_forms_005fresetFilter_005f0 = new org.apache.jsp.tag.web.forms.resetFilter_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fresetFilter_005f0);
    try {
      _jspx_th_forms_005fresetFilter_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fresetFilter_005f0.setParent(_jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(13,81) name = resetUrl type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fresetFilter_005f0.setResetUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${resetUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005fresetFilter_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fresetFilter_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcheckbox_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:checkbox
    org.apache.jsp.tag.web.forms.checkbox_tag _jspx_th_forms_005fcheckbox_005f0 = new org.apache.jsp.tag.web.forms.checkbox_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcheckbox_005f0);
    try {
      _jspx_th_forms_005fcheckbox_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcheckbox_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(17,6) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setName("includeArchived");
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(17,6) name = disabled type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setDisabled((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminOverviewForm.numberOfActiveProjects == 0}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(17,6) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminOverviewForm.includeArchived}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/admin/adminProjectsSearchField.tag(17,6) name = onclick type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setOnclick("this.form.submit();");
      _jspx_th_forms_005fcheckbox_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f0);
    }
    return false;
  }
}