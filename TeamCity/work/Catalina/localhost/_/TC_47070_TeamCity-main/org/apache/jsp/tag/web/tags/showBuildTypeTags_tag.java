/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:39 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.tags;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.serverSide.BuildTypeEx;

public final class showBuildTypeTags_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(9);
    _jspx_dependants.put("/WEB-INF/tags/tags/showTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/s.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/printTag.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/_buildTypeTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showPublicAndPrivateTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/resetFilter.tag", Long.valueOf(1504702500000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;

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
  private jetbrains.buildServer.serverSide.SBuildType buildType;
  private jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean historyForm;
  private java.lang.String label;

  public jetbrains.buildServer.serverSide.SBuildType getBuildType() {
    return this.buildType;
  }

  public void setBuildType(jetbrains.buildServer.serverSide.SBuildType buildType) {
    this.buildType = buildType;
    jspContext.setAttribute("buildType", buildType);
  }

  public jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean getHistoryForm() {
    return this.historyForm;
  }

  public void setHistoryForm(jetbrains.buildServer.controllers.buildType.tabs.HistorySearchBean historyForm) {
    this.historyForm = historyForm;
    jspContext.setAttribute("historyForm", historyForm);
  }

  public java.lang.String getLabel() {
    return this.label;
  }

  public void setLabel(java.lang.String label) {
    this.label = label;
    jspContext.setAttribute("label", label);
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
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
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
    if( getBuildType() != null ) 
      _jspx_page_context.setAttribute("buildType", getBuildType());
    if( getHistoryForm() != null ) 
      _jspx_page_context.setAttribute("historyForm", getHistoryForm());
    if( getLabel() != null ) 
      _jspx_page_context.setAttribute("label", getLabel());

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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      jetbrains.buildServer.users.SUser currentUser = null;
      currentUser = (jetbrains.buildServer.users.SUser) _jspx_page_context.getAttribute("currentUser", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (currentUser == null){
        throw new java.lang.InstantiationException("bean currentUser not found within scope");
      }
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      //  t:showPublicAndPrivateTags
      org.apache.jsp.tag.web.tags.showPublicAndPrivateTags_tag _jspx_th_t_005fshowPublicAndPrivateTags_005f0 = new org.apache.jsp.tag.web.tags.showPublicAndPrivateTags_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_t_005fshowPublicAndPrivateTags_005f0);
      try {
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setJspContext(_jspx_page_context);
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = buildTypeId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setBuildTypeId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.externalId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = label type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setLabel((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${label}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = publicTags type = java.util.List reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setPublicTags((java.util.List) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.tags}", java.util.List.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = selectedPublicTag type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setSelectedPublicTag((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${empty historyForm ? null : historyForm.tag}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = privateTags type = java.util.List reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setPrivateTags(((BuildTypeEx)buildType).getTags(currentUser));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = selectedPrivateTag type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setSelectedPrivateTag((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${empty historyForm ? null : historyForm.privateTag}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        // /WEB-INF/tags/tags/showBuildTypeTags.tag(17,0) name = hidePrivateTags type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.setHidePrivateTags((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${false}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
        _jspx_th_t_005fshowPublicAndPrivateTags_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_t_005fshowPublicAndPrivateTags_005f0);
      }
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_t_005f_005fbuildTypeTags_005f0(_jspx_page_context))
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

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/tags/showBuildTypeTags.tag(16,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("userTags");
      // /WEB-INF/tags/tags/showBuildTypeTags.tag(16,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue("");
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      _jspx_th_c_005fset_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_t_005f_005fbuildTypeTags_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  t:_buildTypeTags
    org.apache.jsp.tag.web.tags._005fbuildTypeTags_tag _jspx_th_t_005f_005fbuildTypeTags_005f0 = new org.apache.jsp.tag.web.tags._005fbuildTypeTags_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_t_005f_005fbuildTypeTags_005f0);
    try {
      _jspx_th_t_005f_005fbuildTypeTags_005f0.setJspContext(_jspx_page_context);
      _jspx_th_t_005f_005fbuildTypeTags_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/tags/showBuildTypeTags.tag(21,0) name = buildType type = jetbrains.buildServer.serverSide.SBuildType reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_t_005f_005fbuildTypeTags_005f0.setBuildType((jetbrains.buildServer.serverSide.SBuildType) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType}", jetbrains.buildServer.serverSide.SBuildType.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_t_005f_005fbuildTypeTags_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_t_005f_005fbuildTypeTags_005f0);
    }
    return false;
  }
}