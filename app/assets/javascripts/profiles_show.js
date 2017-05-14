(function () {
  var page_vm = {
  };

  function receive(ch) {
  }

  function format_user(o) {
    return o.name + " (" + o.email + ")";
  }
  
  function extend_profile_vm(pvm) {
    return {
      owner_label: ko.computed(function() {
	return format_user(pvm.owner());
      }),
      users_list: ko.computed(function() {
	return _.join(_.map(pvm.users(), format_user), ', ');
      })
    };
  }
  
  function init() {
    page_vm.profile = ko.observable(Builders.make_profile_vm(profile, extend_profile_vm));

    return page_vm;
  }

  App.define_on_page('profiles', 'show', init, receive);
})();
