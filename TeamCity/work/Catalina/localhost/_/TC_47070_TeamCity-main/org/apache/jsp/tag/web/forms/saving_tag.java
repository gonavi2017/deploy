/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.forms;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class saving_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
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
  private java.lang.String id;
  private java.lang.String style;
  private java.lang.String className;
  private java.lang.String savingTitle;

  public java.lang.String getId() {
    return this.id;
  }

  public void setId(java.lang.String id) {
    this.id = id;
    jspContext.setAttribute("id", id);
  }

  public java.lang.String getStyle() {
    return this.style;
  }

  public void setStyle(java.lang.String style) {
    this.style = style;
    jspContext.setAttribute("style", style);
  }

  public java.lang.String getClassName() {
    return this.className;
  }

  public void setClassName(java.lang.String className) {
    this.className = className;
    jspContext.setAttribute("className", className);
  }

  public java.lang.String getSavingTitle() {
    return this.savingTitle;
  }

  public void setSavingTitle(java.lang.String savingTitle) {
    this.savingTitle = savingTitle;
    jspContext.setAttribute("savingTitle", savingTitle);
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
    if( getId() != null ) 
      _jspx_page_context.setAttribute("id", getId());
    if( getStyle() != null ) 
      _jspx_page_context.setAttribute("style", getStyle());
    if( getClassName() != null ) 
      _jspx_page_context.setAttribute("className", getClassName());
    if( getSavingTitle() != null ) 
      _jspx_page_context.setAttribute("savingTitle", getSavingTitle());

    try {
      if (_jspx_meth_forms_005fprogressRing_005f0(_jspx_page_context))
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
    }
  }

  private boolean _jspx_meth_forms_005fprogressRing_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:progressRing
    org.apache.jsp.tag.web.forms.progressRing_tag _jspx_th_forms_005fprogressRing_005f0 = new org.apache.jsp.tag.web.forms.progressRing_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fprogressRing_005f0);
    try {
      _jspx_th_forms_005fprogressRing_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fprogressRing_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/forms/saving.tag(8,2) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fprogressRing_005f0.setId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${empty id ? 'saving' : id}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/forms/saving.tag(8,2) name = style type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fprogressRing_005f0.setStyle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("display: none; ${style}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/forms/saving.tag(8,2) name = className type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fprogressRing_005f0.setClassName((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${className}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/forms/saving.tag(8,2) name = progressTitle type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fprogressRing_005f0.setProgressTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${empty savingTitle ? 'Please wait...' : savingTitle}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005fprogressRing_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fprogressRing_005f0);
    }
    return false;
  }
}
