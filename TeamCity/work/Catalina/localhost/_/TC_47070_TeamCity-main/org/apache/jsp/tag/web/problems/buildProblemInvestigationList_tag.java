/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:50 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.problems;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class buildProblemInvestigationList_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(49);
    _jspx_dependants.put("/WEB-INF/tags/layout/blockState.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/currentProblem.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/responsibilityInfo.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemExpandCollapse.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/muteInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tests/testInvestigationLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/simpleDate.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/simplePopup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/id.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblem.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDetails.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_collapsibleBlock.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popupControl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemGroup.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemGroupByProject.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/collapseExpand.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/date.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemList.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemRow.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/iconLinkStyle.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDescriptionText.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectUrl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/additonalInfo.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/inlineMuteInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/formatDate.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/out.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemDescription.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectOrBuildTypeIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/responsibility-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemInvestigationLinks.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildLogLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemStylesAndScripts.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/editBuildTypeGranted.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemBuildLogLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_muteInfoTable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFullAbstract.tag", Long.valueOf(1504702502000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar;

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
  private jetbrains.buildServer.web.problems.ProjectBuildProblemsBean projectBuildProblemsBean;

  public jetbrains.buildServer.web.problems.ProjectBuildProblemsBean getProjectBuildProblemsBean() {
    return this.projectBuildProblemsBean;
  }

  public void setProjectBuildProblemsBean(jetbrains.buildServer.web.problems.ProjectBuildProblemsBean projectBuildProblemsBean) {
    this.projectBuildProblemsBean = projectBuildProblemsBean;
    jspContext.setAttribute("projectBuildProblemsBean", projectBuildProblemsBean);
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
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar.release();
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
    if( getProjectBuildProblemsBean() != null ) 
      _jspx_page_context.setAttribute("projectBuildProblemsBean", getProjectBuildProblemsBean());

    try {
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
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

  private boolean _jspx_meth_c_005fif_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f0_reused = false;
    try {
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(8,0) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty projectBuildProblemsBean and projectBuildProblemsBean.buildProblemsNumber > 0}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  ");
          if (_jspx_meth_problems_005fbuildProblemStylesAndScripts_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write("\r\n");
          out.write("\r\n");
          out.write("  ");
          if (_jspx_meth_c_005fset_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write("\r\n");
          out.write("  ");
          if (_jspx_meth_bs_005f_005fcollapsibleBlock_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write('\r');
          out.write('\n');
          int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
      _jspx_th_c_005fif_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemStylesAndScripts_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemStylesAndScripts
    org.apache.jsp.tag.web.problems.buildProblemStylesAndScripts_tag _jspx_th_problems_005fbuildProblemStylesAndScripts_005f0 = new org.apache.jsp.tag.web.problems.buildProblemStylesAndScripts_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemStylesAndScripts_005f0);
    try {
      _jspx_th_problems_005fbuildProblemStylesAndScripts_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemStylesAndScripts_005f0.setParent(_jspx_th_c_005fif_005f0);
      _jspx_th_problems_005fbuildProblemStylesAndScripts_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemStylesAndScripts_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(11,2) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("title");
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_eval_c_005fset_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_c_005fset_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = org.apache.jasper.runtime.JspRuntimeLibrary.startBufferedBody(_jspx_page_context, _jspx_th_c_005fset_005f0);
        }
        do {
          out.write("<span class=\"icon icon16 bp taken\"></span> Build problem investigations");
          int evalDoAfterBody = _jspx_th_c_005fset_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_c_005fset_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar.reuse(_jspx_th_c_005fset_005f0);
      _jspx_th_c_005fset_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005f_005fcollapsibleBlock_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:_collapsibleBlock
    org.apache.jsp.tag.web._005fcollapsibleBlock_tag _jspx_th_bs_005f_005fcollapsibleBlock_005f0 = new org.apache.jsp.tag.web._005fcollapsibleBlock_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005f_005fcollapsibleBlock_005f0);
    try {
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setParent(_jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(12,2) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${title}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(12,2) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setId("buildProblemInvestigations");
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(12,2) name = collapsedByDefault type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setCollapsedByDefault(new java.lang.Boolean(false));
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005f_005fcollapsibleBlock_005f0, null));
      _jspx_th_bs_005f_005fcollapsibleBlock_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005f_005fcollapsibleBlock_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemExpandCollapse_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemExpandCollapse
    org.apache.jsp.tag.web.problems.buildProblemExpandCollapse_tag _jspx_th_problems_005fbuildProblemExpandCollapse_005f0 = new org.apache.jsp.tag.web.problems.buildProblemExpandCollapse_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemExpandCollapse_005f0);
    try {
      _jspx_th_problems_005fbuildProblemExpandCollapse_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemExpandCollapse_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(14,4) name = showExpandCollapseActions type = java.lang.Boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemExpandCollapse_005f0.setShowExpandCollapseActions(new java.lang.Boolean(true));
      _jspx_th_problems_005fbuildProblemExpandCollapse_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_problems_005fbuildProblemExpandCollapse_005f0, null));
      _jspx_th_problems_005fbuildProblemExpandCollapse_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemExpandCollapse_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_problems_005fbuildProblemGroupByProject_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  problems:buildProblemGroupByProject
    org.apache.jsp.tag.web.problems.buildProblemGroupByProject_tag _jspx_th_problems_005fbuildProblemGroupByProject_005f0 = new org.apache.jsp.tag.web.problems.buildProblemGroupByProject_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_problems_005fbuildProblemGroupByProject_005f0);
    try {
      _jspx_th_problems_005fbuildProblemGroupByProject_005f0.setJspContext(_jspx_page_context);
      _jspx_th_problems_005fbuildProblemGroupByProject_005f0.setParent(_jspx_parent);
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(15,8) name = projectBuildProblemsBean type = jetbrains.buildServer.web.problems.ProjectBuildProblemsBean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemGroupByProject_005f0.setProjectBuildProblemsBean((jetbrains.buildServer.web.problems.ProjectBuildProblemsBean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectBuildProblemsBean}", jetbrains.buildServer.web.problems.ProjectBuildProblemsBean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/problems/buildProblemInvestigationList.tag(15,8) name = inlineResponsibiltyInfo type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_problems_005fbuildProblemGroupByProject_005f0.setInlineResponsibiltyInfo((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_problems_005fbuildProblemGroupByProject_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_problems_005fbuildProblemGroupByProject_005f0);
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_problems_005fbuildProblemExpandCollapse_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  ");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("        ");
      if (_jspx_meth_problems_005fbuildProblemGroupByProject_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
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
