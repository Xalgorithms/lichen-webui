(function () {
  var page_vm = {
    modals: {
      invite: App.make_modal([], populate_invite, submit_invite)
    }
  };
    
  var changes = {
    'user' : {
      'added' : receive_added_user
    }
  };

  function receive(ch) {
    var fn = _.get(_.get(changes, ch.model, {}), ch.effect, _.identity);
    fn(ch);    
  }

  function receive_added_user(ch) {
    $.get(Routes.api_v1_user_path(ch.id), function (o) {
      var pvm = page_vm.profile();
      pvm.users.push(make_user_vm(o, pvm));
    });
  }

  function format_user(o) {
    return o.name + " (" + o.email + ")";
  }

  function populate_invite(vm) {
    var mvm = {
      email: ko.observable()
    };

    return mvm;
  }

  function submit_invite(vm) {
    var payload = {
      email: vm.email(),
      profile_id: page_vm.profile().id
    };

    $.post(Routes.api_v1_actions_path(), { actions_profile_invite : payload }, function (o) {
      console.log('sent change');
    });    
  }

  function make_user_vm(u, pvm) {
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
  }
  
  function extend_profile_vm(pvm) {
    return {
      user_vms: ko.computed(function () {
	return _.map(pvm.users(), function (u) {
	  return make_user_vm(u, pvm);
	});
      })
    };
  }
  
  function init() {
    page_vm.profile = ko.observable(Builders.make_profile_vm(profile, extend_profile_vm));

    page_vm.invite = function (vm) {
      page_vm.modals.invite.actions.activate();
    };

    return page_vm;
  }

  App.define_on_page('profiles', 'show', init, receive);
})();
