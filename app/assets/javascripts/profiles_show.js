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
      user_vms: ko.computed(function () {
	return _.map(pvm.users(), function (u) {
	  var extras = {
	    label: ko.computed(function () {
	      return u.name + " (" + u.email + ")";
	    }),
	    is_owner: ko.computed(function () {
	      var oum = pvm.owner();
	      return u.id === oum.id;
	    })
	  };

	  return _.assignIn(extras, u);
	});
      })
    };
  }
  
  function init() {
    page_vm.profile = ko.observable(Builders.make_profile_vm(profile, extend_profile_vm));

    return page_vm;
  }

  App.define_on_page('profiles', 'show', init, receive);
})();
