var LdapTrigger = {
  start: function() {
    $('ldapSubmit').disabled = 'disabled';
    BS.ajaxRequest(window['base_uri'] + '/ldap/status.html?syncNow=true', {
      method: "post",
      onComplete: function() {
        $('ldapSectionContainer').refresh();
      }
    });
  }
};
