/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:45 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class editBuildTypeParams_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(98);
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ua.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_tagsEditingControl.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/pauseCommentText.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editBuildTypeLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/pauseBuildTypeDialog.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/importWebComponents.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtensions.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/smallNote.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/commonDialogs.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnEvents.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/tableWithHighlighting.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/option.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/li.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/s.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popupControl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentText.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/star.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/pageMeta.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/refreshable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/page.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/responsible/form.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_applyToAllBuildsCheckbox.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/configModificationLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/prototype.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/textField.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/templateUsagesPopup.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editProjectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectUrl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/professionalLimited.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/userDefinedParameters.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/_pauseBuildTypeLinkOnClick.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/extractTemplate.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/addButton.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemStylesAndScripts.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/encrypt.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/makeBreakable.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/jquery.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editBuildTypeNav.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editBuildTypePage.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/editTagsForm.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/commonTemplates.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/stopBuildDialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtension.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/configModificationInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_pauseInfo.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/popup_static.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/simpleDate.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/runBuild.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/dialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editableParametersList.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/projectOptGroup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/select.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/executeOnce.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/unprocessedMessages.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/attachTemplateDialog.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/actionsPopup.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypePaused.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/help.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/baseUri.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/auditLogActionUserName.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/date.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeRequest.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editTemplateLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/editBuildTypeNavSteps.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentUserInfo.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/commonFrameworks.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/formatDate.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/out.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/messages.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/webComponentsSettings.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/XUACompatible.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/predefinedIntProps.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectOrBuildTypeIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/cancel.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/modalDialog.tag", Long.valueOf(1504702504000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"/runtimeError.html", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm buildForm = null;
      buildForm = (jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm) _jspx_page_context.getAttribute("buildForm", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (buildForm == null){
        throw new java.lang.InstantiationException("bean buildForm not found within scope");
      }
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.controllers.admin.projects.EditableUserDefinedParametersBean propertiesBean = null;
      propertiesBean = (jetbrains.buildServer.controllers.admin.projects.EditableUserDefinedParametersBean) _jspx_page_context.getAttribute("propertiesBean", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (propertiesBean == null){
        throw new java.lang.InstantiationException("bean propertiesBean not found within scope");
      }
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_admin_005feditBuildTypePage_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_admin_005feditBuildTypePage_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  admin:editBuildTypePage
    org.apache.jsp.tag.web.admin.editBuildTypePage_tag _jspx_th_admin_005feditBuildTypePage_005f0 = new org.apache.jsp.tag.web.admin.editBuildTypePage_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_admin_005feditBuildTypePage_005f0);
    try {
      _jspx_th_admin_005feditBuildTypePage_005f0.setJspContext(_jspx_page_context);
      // /admin/editBuildTypeParams.jsp(6,0) name = selectedStep type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005feditBuildTypePage_005f0.setSelectedStep("buildParams");
      javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_admin_005feditBuildTypePage_005f0, null);
      // /admin/editBuildTypeParams.jsp(6,0) null
      _jspx_th_admin_005feditBuildTypePage_005f0.setHead_include(_jspx_temp0);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp1 = new Helper( 2, _jspx_page_context, _jspx_th_admin_005feditBuildTypePage_005f0, null);
      // /admin/editBuildTypeParams.jsp(6,0) null
      _jspx_th_admin_005feditBuildTypePage_005f0.setBody_include(_jspx_temp1);
      _jspx_th_admin_005feditBuildTypePage_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_admin_005feditBuildTypePage_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005flinkCSS_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:linkCSS
    org.apache.jsp.tag.web.linkCSS_tag _jspx_th_bs_005flinkCSS_005f0 = new org.apache.jsp.tag.web.linkCSS_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005flinkCSS_005f0);
    try {
      _jspx_th_bs_005flinkCSS_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005flinkCSS_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005flinkCSS_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_bs_005flinkCSS_005f0, null));
      _jspx_th_bs_005flinkCSS_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005flinkCSS_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /admin/editBuildTypeParams.jsp(15,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("/admin/editBuildParams.html?id=${buildForm.settingsId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(15,4) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setVar("actionUrl");
      int _jspx_eval_c_005furl_005f0 = _jspx_th_c_005furl_005f0.doStartTag();
      if (_jspx_th_c_005furl_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f0);
      _jspx_th_c_005furl_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f0, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f1(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f1 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f1_reused = false;
    try {
      _jspx_th_c_005furl_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /admin/editBuildTypeParams.jsp(16,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f1.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("/admin/parameterAutocompletion.html?settingsId=${buildForm.settingsId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(16,4) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f1.setVar("autocompletionUrl");
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

  private boolean _jspx_meth_admin_005fuserDefinedParameters_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  admin:userDefinedParameters
    org.apache.jsp.tag.web.admin.userDefinedParameters_tag _jspx_th_admin_005fuserDefinedParameters_005f0 = new org.apache.jsp.tag.web.admin.userDefinedParameters_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_admin_005fuserDefinedParameters_005f0);
    try {
      _jspx_th_admin_005fuserDefinedParameters_005f0.setJspContext(_jspx_page_context);
      _jspx_th_admin_005fuserDefinedParameters_005f0.setParent(_jspx_parent);
      // /admin/editBuildTypeParams.jsp(17,4) name = userParametersBean type = jetbrains.buildServer.controllers.buildType.ParametersBean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005fuserDefinedParameters_005f0.setUserParametersBean((jetbrains.buildServer.controllers.buildType.ParametersBean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${propertiesBean}", jetbrains.buildServer.controllers.buildType.ParametersBean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(17,4) name = parametersActionUrl type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005fuserDefinedParameters_005f0.setParametersActionUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${actionUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(17,4) name = parametersAutocompletionUrl type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005fuserDefinedParameters_005f0.setParametersAutocompletionUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${autocompletionUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(17,4) name = readOnly type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005fuserDefinedParameters_005f0.setReadOnly((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildForm.readOnly}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/editBuildTypeParams.jsp(17,4) name = externalId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_admin_005fuserDefinedParameters_005f0.setExternalId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildForm.externalId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_admin_005fuserDefinedParameters_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_admin_005fuserDefinedParameters_005f0);
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
      if (_jspx_meth_bs_005flinkCSS_005f0(_jspx_parent, _jspx_page_context))
        return true;
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("      /css/settingsTable.css\r\n");
      out.write("      /css/admin/editUserParams.css\r\n");
      out.write("    ");
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      if (_jspx_meth_c_005furl_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005furl_005f1(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_admin_005fuserDefinedParameters_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("      (function($) {\r\n");
      out.write("        $(document).ready(function() {\r\n");
      out.write("          if (document.location.hash.indexOf('edit_') != -1) {\r\n");
      out.write("            var selector = document.location.hash;\r\n");
      out.write("            $(selector).triggerHandler(\"click\");\r\n");
      out.write("            document.location.hash = \"\";\r\n");
      out.write("          }\r\n");
      out.write("        });\r\n");
      out.write("      }(jQuery));\r\n");
      out.write("    </script>");
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
