/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:40 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.p;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class container_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/tags/forJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changeRequest.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody;

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
  private java.lang.String contextId;
  private java.lang.String JSObject;
  private javax.servlet.jsp.tagext.JspFragment context;
  private javax.servlet.jsp.tagext.JspFragment content;

  public java.lang.String getContextId() {
    return this.contextId;
  }

  public void setContextId(java.lang.String contextId) {
    this.contextId = contextId;
    jspContext.setAttribute("contextId", contextId);
  }

  public java.lang.String getJSObject() {
    return this.JSObject;
  }

  public void setJSObject(java.lang.String JSObject) {
    this.JSObject = JSObject;
    jspContext.setAttribute("JSObject", JSObject);
  }

  public javax.servlet.jsp.tagext.JspFragment getContext() {
    return this.context;
  }

  public void setContext(javax.servlet.jsp.tagext.JspFragment context) {
    this.context = context;
    jspContext.setAttribute("context", context);
  }

  public javax.servlet.jsp.tagext.JspFragment getContent() {
    return this.content;
  }

  public void setContent(javax.servlet.jsp.tagext.JspFragment content) {
    this.content = content;
    jspContext.setAttribute("content", content);
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
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.release();
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
    if( getContextId() != null ) 
      _jspx_page_context.setAttribute("contextId", getContextId());
    if( getJSObject() != null ) 
      _jspx_page_context.setAttribute("JSObject", getJSObject());
    if( getContext() != null ) 
      _jspx_page_context.setAttribute("context", getContext());
    if( getContent() != null ) 
      _jspx_page_context.setAttribute("content", getContent());

    try {
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      jetbrains.buildServer.controllers.parameters.ParameterConstants parameterConstants = null;
      parameterConstants = (jetbrains.buildServer.controllers.parameters.ParameterConstants) _jspx_page_context.getAttribute("parameterConstants", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (parameterConstants == null){
        parameterConstants = new jetbrains.buildServer.controllers.parameters.ParameterConstants();
        _jspx_page_context.setAttribute("parameterConstants", parameterConstants, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("  ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${JSObject}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write(" = BS.TypedParameters.create();\r\n");
      out.write("  ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${JSObject}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write(".containerId = '");
      if (_jspx_meth_bs_005fforJs_005f0(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("  ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${JSObject}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write(".submitUrl = '");
      if (_jspx_meth_bs_005fforJs_005f1(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      if (_jspx_meth_bs_005fchangeRequest_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
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

  private boolean _jspx_meth_bs_005fforJs_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:forJs
    org.apache.jsp.tag.web.forJs_tag _jspx_th_bs_005fforJs_005f0 = new org.apache.jsp.tag.web.forJs_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fforJs_005f0);
    try {
      _jspx_th_bs_005fforJs_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fforJs_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      _jspx_th_bs_005fforJs_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005fforJs_005f0, null));
      _jspx_th_bs_005fforJs_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fforJs_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fforJs_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:forJs
    org.apache.jsp.tag.web.forJs_tag _jspx_th_bs_005fforJs_005f1 = new org.apache.jsp.tag.web.forJs_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fforJs_005f1);
    try {
      _jspx_th_bs_005fforJs_005f1.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fforJs_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      _jspx_th_bs_005fforJs_005f1.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_bs_005fforJs_005f1, null));
      _jspx_th_bs_005fforJs_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fforJs_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /WEB-INF/tags/p/container.tag(20,37) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${parameterConstants.parametersSubmitControllerPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
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

  private boolean _jspx_meth_bs_005fchangeRequest_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest)_jspx_page_context.getRequest();
    javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse)_jspx_page_context.getResponse();
    //  bs:changeRequest
    org.apache.jsp.tag.web.changeRequest_tag _jspx_th_bs_005fchangeRequest_005f0 = new org.apache.jsp.tag.web.changeRequest_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fchangeRequest_005f0);
    try {
      _jspx_th_bs_005fchangeRequest_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fchangeRequest_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/p/container.tag(23,0) name = key type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangeRequest_005f0.setKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${parameterConstants.parametersContainer}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/p/container.tag(23,0) name = value type = java.lang.Object reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangeRequest_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${contextId}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005fchangeRequest_005f0.setJspBody(new Helper( 2, _jspx_page_context, _jspx_th_bs_005fchangeRequest_005f0, null));
      _jspx_th_bs_005fchangeRequest_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fchangeRequest_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fchangeRequest_005f1(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest)_jspx_page_context.getRequest();
    javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse)_jspx_page_context.getResponse();
    //  bs:changeRequest
    org.apache.jsp.tag.web.changeRequest_tag _jspx_th_bs_005fchangeRequest_005f1 = new org.apache.jsp.tag.web.changeRequest_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fchangeRequest_005f1);
    try {
      _jspx_th_bs_005fchangeRequest_005f1.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fchangeRequest_005f1.setParent(_jspx_parent);
      // /WEB-INF/tags/p/container.tag(24,0) name = key type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangeRequest_005f1.setKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${parameterConstants.parametersFormJs}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/p/container.tag(24,0) name = value type = java.lang.Object reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangeRequest_005f1.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${JSObject}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005fchangeRequest_005f1.setJspBody(new Helper( 3, _jspx_page_context, _jspx_th_bs_005fchangeRequest_005f1, null));
      _jspx_th_bs_005fchangeRequest_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fchangeRequest_005f1);
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
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${contextId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      if (_jspx_meth_c_005furl_005f0(_jspx_parent, _jspx_page_context))
        return true;
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest)_jspx_page_context.getRequest();
      javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse)_jspx_page_context.getResponse();
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_bs_005fchangeRequest_005f1(_jspx_parent, _jspx_page_context))
        return true;
      out.write('\r');
      out.write('\n');
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest)_jspx_page_context.getRequest();
      javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse)_jspx_page_context.getResponse();
      out.write("\r\n");
      out.write("  ");
      out.write("\r\n");
      out.write("  ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, (java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${parameterConstants.parametersFormControllerPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false) + (((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${parameterConstants.parametersFormControllerPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false)).indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("init", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("1", request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <!-- create additional paremters for container -->\r\n");
      out.write("  ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getContext() != null) {
        getContext().invoke(_jspx_sout);
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <!-- render parameters context -->\r\n");
      out.write("  ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getContent() != null) {
        getContent().invoke(_jspx_sout);
      }
      out.write("\r\n");
      out.write("\r\n");
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
          case 2:
            invoke2( out );
            break;
          case 3:
            invoke3( out );
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