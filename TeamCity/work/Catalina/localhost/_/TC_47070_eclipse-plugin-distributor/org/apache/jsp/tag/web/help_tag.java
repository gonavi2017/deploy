/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:19:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class help_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(5);
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
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
  private java.lang.String urlPrefix;
  private java.lang.String file;
  private java.lang.String anchor;
  private java.lang.String shortHelp;
  private java.lang.String style;
  private java.lang.String id;
  private java.lang.String width;
  private java.lang.String height;

  public java.lang.String getUrlPrefix() {
    return this.urlPrefix;
  }

  public void setUrlPrefix(java.lang.String urlPrefix) {
    this.urlPrefix = urlPrefix;
    jspContext.setAttribute("urlPrefix", urlPrefix);
  }

  public java.lang.String getFile() {
    return this.file;
  }

  public void setFile(java.lang.String file) {
    this.file = file;
    jspContext.setAttribute("file", file);
  }

  public java.lang.String getAnchor() {
    return this.anchor;
  }

  public void setAnchor(java.lang.String anchor) {
    this.anchor = anchor;
    jspContext.setAttribute("anchor", anchor);
  }

  public java.lang.String getShortHelp() {
    return this.shortHelp;
  }

  public void setShortHelp(java.lang.String shortHelp) {
    this.shortHelp = shortHelp;
    jspContext.setAttribute("shortHelp", shortHelp);
  }

  public java.lang.String getStyle() {
    return this.style;
  }

  public void setStyle(java.lang.String style) {
    this.style = style;
    jspContext.setAttribute("style", style);
  }

  public java.lang.String getId() {
    return this.id;
  }

  public void setId(java.lang.String id) {
    this.id = id;
    jspContext.setAttribute("id", id);
  }

  public java.lang.String getWidth() {
    return this.width;
  }

  public void setWidth(java.lang.String width) {
    this.width = width;
    jspContext.setAttribute("width", width);
  }

  public java.lang.String getHeight() {
    return this.height;
  }

  public void setHeight(java.lang.String height) {
    this.height = height;
    jspContext.setAttribute("height", height);
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
    if( getUrlPrefix() != null ) 
      _jspx_page_context.setAttribute("urlPrefix", getUrlPrefix());
    if( getFile() != null ) 
      _jspx_page_context.setAttribute("file", getFile());
    if( getAnchor() != null ) 
      _jspx_page_context.setAttribute("anchor", getAnchor());
    if( getShortHelp() != null ) 
      _jspx_page_context.setAttribute("shortHelp", getShortHelp());
    if( getStyle() != null ) 
      _jspx_page_context.setAttribute("style", getStyle());
    if( getId() != null ) 
      _jspx_page_context.setAttribute("id", getId());
    if( getWidth() != null ) 
      _jspx_page_context.setAttribute("width", getWidth());
    if( getHeight() != null ) 
      _jspx_page_context.setAttribute("height", getHeight());

    try {
      if (_jspx_meth_bs_005fhelpLink_005f0(_jspx_page_context))
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

  private boolean _jspx_meth_bs_005fhelpLink_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:helpLink
    org.apache.jsp.tag.web.helpLink_tag _jspx_th_bs_005fhelpLink_005f0 = new org.apache.jsp.tag.web.helpLink_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fhelpLink_005f0);
    try {
      _jspx_th_bs_005fhelpLink_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fhelpLink_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/help.tag(12,4) name = urlPrefix type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setUrlPrefix((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${urlPrefix}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = file type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setFile((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${file}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = anchor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setAnchor((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${anchor}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${id}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = style type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setStyle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${style}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = width type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setWidth((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${width}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/help.tag(12,4) name = height type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpLink_005f0.setHeight((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${height}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005fhelpLink_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005fhelpLink_005f0, null));
      _jspx_th_bs_005fhelpLink_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fhelpLink_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fhelpIcon_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:helpIcon
    org.apache.jsp.tag.web.helpIcon_tag _jspx_th_bs_005fhelpIcon_005f0 = new org.apache.jsp.tag.web.helpIcon_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fhelpIcon_005f0);
    try {
      _jspx_th_bs_005fhelpIcon_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fhelpIcon_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/help.tag(12,140) name = iconTitle type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelpIcon_005f0.setIconTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${shortHelp}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005fhelpIcon_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fhelpIcon_005f0);
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
      if (_jspx_meth_bs_005fhelpIcon_005f0(_jspx_parent, _jspx_page_context))
        return true;
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
