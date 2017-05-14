(function () {
  function populate_profile(vm) {
    var mvm = {
      name: ko.observable(),
      owner_id: ko.observable(user.id)
    };

    return mvm;
  }

  function submit_profile(vm) {
    var payload = {
        name: vm.name(),
        owner_id: vm.owner_id()
    };
    $.post(Routes.api_v1_actions_path(), { actions_profile_add : payload }, function (o) {
      console.log('sent change');
    });    
  }

  function populate_invite(vm) {
    var mvm = {
    };

    return mvm;
  }

  function submit_invite(vm) {
    debugger;
  }

  var page_vm = {
    modals: {
      profile: App.make_modal([], populate_profile, submit_profile),
      invite: App.make_modal([], populate_invite, submit_invite)
    }
  };

  var changes = {
    'profile' : {
      'added' : receive_added_profile,
      'destroyed' : receive_destroyed_profile
    }
  };

  function receive(ch) {
    var fn = _.get(_.get(changes, ch.model, {}), ch.effect, _.identity);
    fn(ch);
  }

  function receive_added_profile(ch) {
    $.get(Routes.api_v1_profile_path(ch.id), function (o) {
      page_vm.profiles.push(make_profile_vm(o));
    });
  }

  function receive_destroyed_profile(ch) {
    page_vm.profiles.remove(function (vm) {
      return vm.id === ch.id;
    });
  }

  function make_profile_vm(pm) {
    return Builders.make_profile_vm(pm, function () {
      return {
        invite: function (vm) {
          page_vm.modals.invite.actions.activate();
        },
	remove: function (vm) {
	  var payload = {
            thing: 'profile',
	    thing_id: vm.id
	  };
	  
	  $.post(Routes.api_v1_actions_path(), { actions_remove : payload }, function (o) {
	    console.log('sent change');
	  });
	}
      };
    });
  }
  
  function init() {
    page_vm.profiles = ko.observableArray(_.map(profiles, make_profile_vm));

    page_vm.chunks = ko.computed(function() {
      return _.chunk(page_vm.profiles(), 4);
    });

    page_vm.add = function (vm) {
      page_vm.modals.profile.actions.activate();
    };

    return page_vm;
  }

  App.define_on_page('profiles', 'index', init, receive);
})();
