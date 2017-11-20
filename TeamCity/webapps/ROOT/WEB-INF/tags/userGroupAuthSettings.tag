<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="groupBean" rtexprvalue="true" type="jetbrains.buildServer.controllers.admin.groups.EditGroupBean" required="true"
%><bs:_authSettings pluginSections="${groupBean.userGroupSettingsPluginList}"
                    title="Additional Settings"
                    propertyFieldNamePrefix="userGroupSettingsPlugins"
                    showEditUsernameLink="${groupBean.showEditPropertyLink}"
                    canSomehowEditUsername="${groupBean.showEditPropertyLink}"
                    canChangeUsername="${false}"/>