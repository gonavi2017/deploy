/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:35 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.problems;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.serverSide.impl.problems.BuildProblemImpl;

public final class buildProblemRow_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(34);
    _jspx_dependants.put("/WEB-INF/tags/date.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/responsibilityInfo.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/iconLinkStyle.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/muteInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDescriptionText.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tests/testInvestigationLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/simpleDate.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/simplePopup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectUrl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/formatDate.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/out.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/id.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblem.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDescription.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/responsibility-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDetails.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemInvestigationLinks.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildLogLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/editBuildTypeGranted.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemBuildLogLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_muteInfoTable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/popupControl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFullAbstract.tag", Long.valueOf(1504702502000L));
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
  private jetbrains.buildServer.web.problems.BuildProblemsBean buildProblemsBean;
  private java.lang.Boolean compactMode;
  private java.lang.Boolean showPopup;
  private java.lang.Boolean showLink;
  private jetbrains.buildServer.serverSide.problems.BuildProblem buildProblem;
  private java.lang.String buildProblemType;
  private java.lang.String buildProblemListId;

  public jetbrains.buildServer.web.problems.BuildProblemsBean getBuildProblemsBean() {
    return this.buildProblemsBean;
  }

  public void setBuildProblemsBean(jetbrains.buildServer.web.problems.BuildProblemsBean buildProblemsBean) {
    this.buildProblemsBean = buildProblemsBean;
    jspContext.setAttribute("buildProblemsBean", buildProblemsBean);
  }

  public java.lang.Boolean getCompactMode() {
    return this.compactMode;
  }

  public void setCompactMode(java.lang.Boolean compactMode) {
    this.compactMode = compactMode;
    jspContext.setAttribute("compactMode", compactMode);
  }

  public java.lang.Boolean getShowPopup() {
    return this.showPopup;
  }

  public void setShowPopup(java.lang.Boolean showPopup) {
    this.showPopup = showPopup;
    jspContext.setAttribute("showPopup", showPopup);
  }

  public java.lang.Boolean getShowLink() {
    return this.showLink;
  }

  public void setShowLink(java.lang.Boolean showLink) {
    this.showLink = showLink;
    jspContext.setAttribute("showLink", showLink);
  }

  public jetbrains.buildServer.serverSide.problems.BuildProblem getBuildProblem() {
    return this.buildProblem;
  }

  public void setBuildProblem(jetbrains.buildServer.serverSide.problems.BuildProblem buildProblem) {
    this.buildProblem = buildProblem;
    jspContext.setAttribute("buildProblem", buildProblem);
  }

  public java.lang.String getBuildProblemType() {
    return this.buildProblemType;
  }

  public void setBuildProblemType(java.lang.String buildProblemType) {
    this.buildProblemType = buildProblemType;
    jspContext.setAttribute("buildProblemType", buildProblemType);
  }

  public java.lang.String getBuildProblemListId() {
    return this.buildProblemListId;
  }

  public void setBuildProblemListId(java.lang.String buildProblemListId) {
    this.buildProblemListId = buildProblemListId;
    jspContext.setAttribute("buildProblemListId", buildProblemListId);
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
    if( getBuildProblemsBean() != null ) 
      _jspx_page_context.setAttribute("buildProblemsBean", getBuildProblemsBean());
    if( getCompactMode() != null ) 
      _jspx_page_context.setAttribute("compactMode", getCompactMode());
    if( getShowPopup() != null ) 
      _jspx_page_context.setAttribute("showPopup", getShowPopup());
    if( getShowLink() != null ) 
      _jspx_page_context.setAttribute("showLink", getShowLink());
    if( getBuildProblem() != null ) 
      _jspx_page_context.setAttribute("buildProblem", getBuildProblem());
    if( getBuildProblemType() != null ) 
      _jspx_page_context.setAttribute("buildProblemType", getBuildProblemType());
    if( getBuildProblemListId() != null ) 
      _jspx_page_context.setAttribute("buildProblemListId", getBuildProblemListId());

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
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      //  c:set
      org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f1 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
      boolean _jspx_th_c_005fset_005f1_reused = false;
      try {
        _jspx_th_c_005fset_005f1.setPageContext(_jspx_page_context);
        _jspx_th_c_005fset_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));        // /WEB-INF/tags/problems/buildProblemRow.tag(17,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fset_005f1.setVar("isNew");
        // /WEB-INF/tags/problems/buildProblemRow.tag(17,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fset_005f1.setValue(((BuildProblemImpl)buildProblem).isNew());
        int _jspx_eval_c_005fset_005f1 = _jspx_th_c_005fset_005f1.doStartTag();
        if (_jspx_th_c_005fset_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          throw new javax.servlet.jsp.SkipPageException();
        }
        _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f1);
        _jspx_th_c_005fset_005f1_reused = true;
      } finally {
        org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f1, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f1_reused);
      }
      out.write('\r');
      out.write('\n');
      //  c:set
      org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f2 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
      boolean _jspx_th_c_005fset_005f2_reused = false;
      try {
        _jspx_th_c_005fset_005f2.setPageContext(_jspx_page_context);
        _jspx_th_c_005fset_005f2.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));        // /WEB-INF/tags/problems/buildProblemRow.tag(18,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fset_005f2.setVar("requestProblemId");
        // /WEB-INF/tags/problems/buildProblemRow.tag(18,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fset_005f2.setValue(request.getParameter("problemId"));
        int _jspx_eval_c_005fset_005f2 = _jspx_th_c_005fset_005f2.doStartTag();
        if (_jspx_th_c_005fset_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          throw new javax.servlet.jsp.SkipPageException();
        }
        _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f2);
        _jspx_th_c_005fset_005f2_reused = true;
      } finally {
        org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f2, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f2_reused);
      }
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_c_005fset_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("<div class=\"tcRow problemToHighlight problem");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem.id}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("\" data-id=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem.id}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("\">\r\n");
      out.write("  <div class=\"tcCell\" style=\"padding-left: 1em;\">\r\n");
      out.write("    <span class=\"icons tcRight\">\r\n");
      out.write("      ");
      if (_jspx_meth_problems_005fbuildProblemIcon_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    </span><span class=\"description\" id=\"bpd_");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uid}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("\">\r\n");
      out.write("      ");
      if (_jspx_meth_problems_005fbuildProblemDescription_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    </span>\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"tcCell rightSideActions\">\r\n");
      out.write("    ");
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getJspBody() != null)
        getJspBody().invoke(_jspx_sout);
      jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,getJspContext());
      out.write("\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"clear\"></div>\r\n");
      out.write("</div>\r\n");
      if (_jspx_meth_problems_005fbuildProblemDescription_005f1(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_problems_005fbuildProblem_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
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

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(16,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("uid");
      // /WEB-INF/tags/problems/buildProblemRow.tag(16,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblemListId}_${buildProblem.id}_${buildProblem.buildPromotion.id}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
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

  private boolean _jspx_meth_c_005fset_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f3 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f3_reused = false;
    try {
      _jspx_th_c_005fset_005f3.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f3.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(19,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f3.setVar("expand");
      // /WEB-INF/tags/problems/buildProblemRow.tag(19,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f3.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not compactMode and (((buildProblemsBean.hasOneBuildProblem or isNew) and not buildProblem.mutedInBuild) or buildProblem.id eq requestProblemId)}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      int _jspx_eval_c_005fset_005f3 = _jspx_th_c_005fset_005f3.doStartTag();
      if (_jspx_th_c_005fset_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f3);
      _jspx_th_c_005fset_005f3_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f3, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f3_reused);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemIcon_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemIcon
    org.apache.jsp.tag.web.problems.buildProblemIcon_tag _jspx_th_problems_005fbuildProblemIcon_005f0 = new org.apache.jsp.tag.web.problems.buildProblemIcon_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemIcon_005f0);
    try {
      _jspx_th_problems_005fbuildProblemIcon_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemIcon_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(23,6) name = currentMuteInfo type = jetbrains.buildServer.serverSide.mute.CurrentMuteInfo reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemIcon_005f0.setCurrentMuteInfo((jetbrains.buildServer.serverSide.mute.CurrentMuteInfo) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem.currentMuteInfo}", jetbrains.buildServer.serverSide.mute.CurrentMuteInfo.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(23,6) name = showBuildSpecificInfo type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemIcon_005f0.setShowBuildSpecificInfo((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(23,6) name = buildProblem type = jetbrains.buildServer.serverSide.problems.BuildProblem reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemIcon_005f0.setBuildProblem((jetbrains.buildServer.serverSide.problems.BuildProblem) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem}", jetbrains.buildServer.serverSide.problems.BuildProblem.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_problems_005fbuildProblemIcon_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemIcon_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemDescription_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemDescription
    org.apache.jsp.tag.web.problems.buildProblemDescription_tag _jspx_th_problems_005fbuildProblemDescription_005f0 = new org.apache.jsp.tag.web.problems.buildProblemDescription_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemDescription_005f0);
    try {
      _jspx_th_problems_005fbuildProblemDescription_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemDescription_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = buildProblemUID type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setBuildProblemUID((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uid}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = buildProblem type = jetbrains.buildServer.serverSide.problems.BuildProblem reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setBuildProblem((jetbrains.buildServer.serverSide.problems.BuildProblem) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem}", jetbrains.buildServer.serverSide.problems.BuildProblem.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = showPopup type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setShowPopup((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${showPopup}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = showLink type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setShowLink((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${showLink}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = compactMode type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setCompactMode((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${compactMode}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = buildProblemType type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setBuildProblemType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblemType}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(25,6) name = invokeDescription type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f0.setInvokeDescription(new java.lang.Boolean(true));
      _jspx_th_problems_005fbuildProblemDescription_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemDescription_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemDescription_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemDescription
    org.apache.jsp.tag.web.problems.buildProblemDescription_tag _jspx_th_problems_005fbuildProblemDescription_005f1 = new org.apache.jsp.tag.web.problems.buildProblemDescription_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemDescription_005f1);
    try {
      _jspx_th_problems_005fbuildProblemDescription_005f1.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemDescription_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = buildProblemUID type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setBuildProblemUID((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uid}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = buildProblem type = jetbrains.buildServer.serverSide.problems.BuildProblem reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setBuildProblem((jetbrains.buildServer.serverSide.problems.BuildProblem) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem}", jetbrains.buildServer.serverSide.problems.BuildProblem.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = showPopup type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setShowPopup((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${showPopup}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = showLink type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setShowLink((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${showLink}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = compactMode type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setCompactMode((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${compactMode}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = buildProblemType type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setBuildProblemType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblemType}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(34,0) name = invokeDetails type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemDescription_005f1.setInvokeDetails(new java.lang.Boolean(true));
      _jspx_th_problems_005fbuildProblemDescription_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemDescription_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblem_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblem
    org.apache.jsp.tag.web.problems.buildProblem_tag _jspx_th_problems_005fbuildProblem_005f0 = new org.apache.jsp.tag.web.problems.buildProblem_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblem_005f0);
    try {
      _jspx_th_problems_005fbuildProblem_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblem_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemRow.tag(36,0) name = buildProblem type = jetbrains.buildServer.serverSide.problems.BuildProblem reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblem_005f0.setBuildProblem((jetbrains.buildServer.serverSide.problems.BuildProblem) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildProblem}", jetbrains.buildServer.serverSide.problems.BuildProblem.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(36,0) name = compactMode type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblem_005f0.setCompactMode((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${compactMode}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(36,0) name = buildProblemUID type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblem_005f0.setBuildProblemUID((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uid}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemRow.tag(36,0) name = showExpanded type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblem_005f0.setShowExpanded((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${expand}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_problems_005fbuildProblem_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblem_005f0);
    }
    return false;
  }
}
