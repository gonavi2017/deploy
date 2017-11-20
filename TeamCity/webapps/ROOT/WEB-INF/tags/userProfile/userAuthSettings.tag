<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="profileForm" rtexprvalue="true" type="jetbrains.buildServer.controllers.profile.ProfileForm" required="true"
%><bs:_authSettings pluginSections="${profileForm.userAuthSettingsPluginList}"
                    title="Authentication Settings"
                    propertyFieldNamePrefix="userAuthSettingsPlugins"
                    showEditUsernameLink="${profileForm.showEditUsernameLink}"
                    canSomehowEditUsername="${profileForm.canSomehowEditUsername}"
                    canChangeUsername="${profileForm.canChangeUsername}"/>