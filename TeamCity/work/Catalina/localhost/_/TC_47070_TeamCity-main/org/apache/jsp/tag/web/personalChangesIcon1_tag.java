/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:26 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.web.util.SessionUser;

public final class personalChangesIcon1_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/tags/personalChangesIcon.tag", Long.valueOf(1504702500000L));
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
  private jetbrains.buildServer.vcs.SVcsModification mod;
  private java.lang.Boolean noTitle;

  public jetbrains.buildServer.vcs.SVcsModification getMod() {
    return this.mod;
  }

  public void setMod(jetbrains.buildServer.vcs.SVcsModification mod) {
    this.mod = mod;
    jspContext.setAttribute("mod", mod);
  }

  public java.lang.Boolean getNoTitle() {
    return this.noTitle;
  }

  public void setNoTitle(java.lang.Boolean noTitle) {
    this.noTitle = noTitle;
    jspContext.setAttribute("noTitle", noTitle);
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
    if( getMod() != null ) 
      _jspx_page_context.setAttribute("mod", getMod());
    if( getNoTitle() != null ) 
      _jspx_page_context.setAttribute("noTitle", getNoTitle());

    try {
      out.write('\r');
      out.write('\n');
      //  bs:personalChangesIcon
      org.apache.jsp.tag.web.personalChangesIcon_tag _jspx_th_bs_005fpersonalChangesIcon_005f0 = new org.apache.jsp.tag.web.personalChangesIcon_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fpersonalChangesIcon_005f0);
      try {
        _jspx_th_bs_005fpersonalChangesIcon_005f0.setJspContext(_jspx_page_context);
        _jspx_th_bs_005fpersonalChangesIcon_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));        // /WEB-INF/tags/personalChangesIcon1.tag(6,6) name = myChanges type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fpersonalChangesIcon_005f0.setMyChanges( mod.isCommitter(SessionUser.getUser(request)));
        // /WEB-INF/tags/personalChangesIcon1.tag(6,6) name = noTitle type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fpersonalChangesIcon_005f0.setNoTitle((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${noTitle}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        _jspx_th_bs_005fpersonalChangesIcon_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fpersonalChangesIcon_005f0);
      }
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
}