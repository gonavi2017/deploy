/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:49 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.userProfile;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class userAuthSettings_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/tags/_authSettings.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/settingsBlock.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
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
  private jetbrains.buildServer.controllers.profile.ProfileForm profileForm;

  public jetbrains.buildServer.controllers.profile.ProfileForm getProfileForm() {
    return this.profileForm;
  }

  public void setProfileForm(jetbrains.buildServer.controllers.profile.ProfileForm profileForm) {
    this.profileForm = profileForm;
    jspContext.setAttribute("profileForm", profileForm);
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
    if( getProfileForm() != null ) 
      _jspx_page_context.setAttribute("profileForm", getProfileForm());

    try {
      if (_jspx_meth_bs_005f_005fauthSettings_005f0(_jspx_page_context))
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

  private boolean _jspx_meth_bs_005f_005fauthSettings_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:_authSettings
    org.apache.jsp.tag.web._005fauthSettings_tag _jspx_th_bs_005f_005fauthSettings_005f0 = new org.apache.jsp.tag.web._005fauthSettings_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005f_005fauthSettings_005f0);
    try {
      _jspx_th_bs_005f_005fauthSettings_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005f_005fauthSettings_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = pluginSections type = java.util.List reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setPluginSections((java.util.List) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.userAuthSettingsPluginList}", java.util.List.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setTitle("Authentication Settings");
      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = propertyFieldNamePrefix type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setPropertyFieldNamePrefix("userAuthSettingsPlugins");
      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = showEditUsernameLink type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setShowEditUsernameLink((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.showEditUsernameLink}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = canSomehowEditUsername type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setCanSomehowEditUsername((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.canSomehowEditUsername}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/userProfile/userAuthSettings.tag(3,2) name = canChangeUsername type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fauthSettings_005f0.setCanChangeUsername((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.canChangeUsername}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_bs_005f_005fauthSettings_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005f_005fauthSettings_005f0);
    }
    return false;
  }
}