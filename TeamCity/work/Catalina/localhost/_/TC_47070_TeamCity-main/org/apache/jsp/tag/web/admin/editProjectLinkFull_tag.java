/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:45 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class editProjectLinkFull_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/tags/admin/editProjectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFullAbstract.tag", Long.valueOf(1504702502000L));
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
  private jetbrains.buildServer.serverSide.SProject project;
  private java.lang.String withSeparatorInTheEnd;
  private jetbrains.buildServer.serverSide.SProject contextProject;
  private java.lang.Boolean skipContextProject;
  private java.lang.String style;
  private java.lang.String target;

  public jetbrains.buildServer.serverSide.SProject getProject() {
    return this.project;
  }

  public void setProject(jetbrains.buildServer.serverSide.SProject project) {
    this.project = project;
    jspContext.setAttribute("project", project);
  }

  public java.lang.String getWithSeparatorInTheEnd() {
    return this.withSeparatorInTheEnd;
  }

  public void setWithSeparatorInTheEnd(java.lang.String withSeparatorInTheEnd) {
    this.withSeparatorInTheEnd = withSeparatorInTheEnd;
    jspContext.setAttribute("withSeparatorInTheEnd", withSeparatorInTheEnd);
  }

  public jetbrains.buildServer.serverSide.SProject getContextProject() {
    return this.contextProject;
  }

  public void setContextProject(jetbrains.buildServer.serverSide.SProject contextProject) {
    this.contextProject = contextProject;
    jspContext.setAttribute("contextProject", contextProject);
  }

  public java.lang.Boolean getSkipContextProject() {
    return this.skipContextProject;
  }

  public void setSkipContextProject(java.lang.Boolean skipContextProject) {
    this.skipContextProject = skipContextProject;
    jspContext.setAttribute("skipContextProject", skipContextProject);
  }

  public java.lang.String getStyle() {
    return this.style;
  }

  public void setStyle(java.lang.String style) {
    this.style = style;
    jspContext.setAttribute("style", style);
  }

  public java.lang.String getTarget() {
    return this.target;
  }

  public void setTarget(java.lang.String target) {
    this.target = target;
    jspContext.setAttribute("target", target);
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
    if( getProject() != null ) 
      _jspx_page_context.setAttribute("project", getProject());
    if( getWithSeparatorInTheEnd() != null ) 
      _jspx_page_context.setAttribute("withSeparatorInTheEnd", getWithSeparatorInTheEnd());
    if( getContextProject() != null ) 
      _jspx_page_context.setAttribute("contextProject", getContextProject());
    if( getSkipContextProject() != null ) 
      _jspx_page_context.setAttribute("skipContextProject", getSkipContextProject());
    if( getStyle() != null ) 
      _jspx_page_context.setAttribute("style", getStyle());
    if( getTarget() != null ) 
      _jspx_page_context.setAttribute("target", getTarget());

    try {
      //  bs:projectLinkFullAbstract
      org.apache.jsp.tag.web.projectLinkFullAbstract_tag _jspx_th_bs_005fprojectLinkFullAbstract_005f0 = new org.apache.jsp.tag.web.projectLinkFullAbstract_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fprojectLinkFullAbstract_005f0);
      try {
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setJspContext(_jspx_page_context);
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));        // /WEB-INF/tags/admin/editProjectLinkFull.tag(11,2) name = project type = jetbrains.buildServer.serverSide.SProject reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setProject((jetbrains.buildServer.serverSide.SProject) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${project}", jetbrains.buildServer.serverSide.SProject.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/admin/editProjectLinkFull.tag(11,2) name = contextProject type = jetbrains.buildServer.serverSide.SProject reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setContextProject((jetbrains.buildServer.serverSide.SProject) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${contextProject}", jetbrains.buildServer.serverSide.SProject.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/admin/editProjectLinkFull.tag(11,2) name = skipContextProject type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setSkipContextProject((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${skipContextProject}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/admin/editProjectLinkFull.tag(11,2) name = withSeparatorInTheEnd type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setWithSeparatorInTheEnd((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${withSeparatorInTheEnd}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_bs_005fprojectLinkFullAbstract_005f0, null);
        // /WEB-INF/tags/admin/editProjectLinkFull.tag(11,2) null
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.setProjectHtml(_jspx_temp0);
        _jspx_th_bs_005fprojectLinkFullAbstract_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fprojectLinkFullAbstract_005f0);
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
      _jspDestroy();
    }
  }

  private boolean _jspx_meth_admin_005feditProjectLink_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  admin:editProjectLink
    org.apache.jsp.tag.web.admin.editProjectLink_tag _jspx_th_admin_005feditProjectLink_005f0 = new org.apache.jsp.tag.web.admin.editProjectLink_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_admin_005feditProjectLink_005f0);
    try {
      _jspx_th_admin_005feditProjectLink_005f0.setJspContext(_jspx_page_context);
      _jspx_th_admin_005feditProjectLink_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/admin/editProjectLinkFull.tag(12,35) name = projectId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005feditProjectLink_005f0.setProjectId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${proj.externalId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/admin/editProjectLinkFull.tag(12,35) name = style type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005feditProjectLink_005f0.setStyle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${style}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_admin_005feditProjectLink_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_admin_005feditProjectLink_005f0, null));
      _jspx_th_admin_005feditProjectLink_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_admin_005feditProjectLink_005f0);
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
      // /WEB-INF/tags/admin/editProjectLinkFull.tag(12,106) name = value type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fout_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${proj.name}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
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
    public void invoke0( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      if (_jspx_meth_admin_005feditProjectLink_005f0(_jspx_parent, _jspx_page_context))
        return;
      return;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      if (_jspx_meth_c_005fout_005f0(_jspx_parent, _jspx_page_context))
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
