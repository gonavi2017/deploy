/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:31:52 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class vcsTree_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


private static org.apache.jasper.runtime.ProtectedFunctionMapper _jspx_fnmap_0;

static {
  _jspx_fnmap_0= org.apache.jasper.runtime.ProtectedFunctionMapper.getMapForFunction("fn:escapeXml", org.apache.taglibs.standard.functions.Functions.class, "escapeXml", new Class[] {java.lang.String.class});
}

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

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
  private java.lang.String treeId;
  private java.lang.String callback;
  private java.lang.String fieldId;
  private java.lang.Boolean dirsOnly;
  private java.lang.String vcsRootId;
  private java.lang.String rootDirName;

  public java.lang.String getTreeId() {
    return this.treeId;
  }

  public void setTreeId(java.lang.String treeId) {
    this.treeId = treeId;
    jspContext.setAttribute("treeId", treeId);
  }

  public java.lang.String getCallback() {
    return this.callback;
  }

  public void setCallback(java.lang.String callback) {
    this.callback = callback;
    jspContext.setAttribute("callback", callback);
  }

  public java.lang.String getFieldId() {
    return this.fieldId;
  }

  public void setFieldId(java.lang.String fieldId) {
    this.fieldId = fieldId;
    jspContext.setAttribute("fieldId", fieldId);
  }

  public java.lang.Boolean getDirsOnly() {
    return this.dirsOnly;
  }

  public void setDirsOnly(java.lang.Boolean dirsOnly) {
    this.dirsOnly = dirsOnly;
    jspContext.setAttribute("dirsOnly", dirsOnly);
  }

  public java.lang.String getVcsRootId() {
    return this.vcsRootId;
  }

  public void setVcsRootId(java.lang.String vcsRootId) {
    this.vcsRootId = vcsRootId;
    jspContext.setAttribute("vcsRootId", vcsRootId);
  }

  public java.lang.String getRootDirName() {
    return this.rootDirName;
  }

  public void setRootDirName(java.lang.String rootDirName) {
    this.rootDirName = rootDirName;
    jspContext.setAttribute("rootDirName", rootDirName);
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
    if( getTreeId() != null ) 
      _jspx_page_context.setAttribute("treeId", getTreeId());
    if( getCallback() != null ) 
      _jspx_page_context.setAttribute("callback", getCallback());
    if( getFieldId() != null ) 
      _jspx_page_context.setAttribute("fieldId", getFieldId());
    if( getDirsOnly() != null ) 
      _jspx_page_context.setAttribute("dirsOnly", getDirsOnly());
    if( getVcsRootId() != null ) 
      _jspx_page_context.setAttribute("vcsRootId", getVcsRootId());
    if( getRootDirName() != null ) 
      _jspx_page_context.setAttribute("rootDirName", getRootDirName());

    try {
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, (java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("/vcsTreePopup.html?treeId=${not empty treeId ? treeId : fieldId}&callback=${callback}&fieldId=${fieldId}&dirsOnly=${dirsOnly}&vcsRootId=${not empty vcsRootId ? vcsRootId : ''}&rootDirName=${not empty rootDirName ? fn:escapeXml(rootDirName) : ''}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), _jspx_fnmap_0, false), out, false);
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
}
