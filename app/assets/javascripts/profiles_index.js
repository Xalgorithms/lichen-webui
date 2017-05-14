(function () {
  function populate_profile(vm) {
    var mvm = {
      name: ko.observable(),
      owner_id: ko.observable(user.id)
    };

    return mvm;
  }

  function submit_profile(vm) {
    
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

  function receive(event) {
    console.log(event);
  }

  function make_profile_vm(pm) {
    var vm = {
      name: ko.observable(pm.name),
      owner: ko.observable(pm.owner)
    };

    vm.is_owner = ko.computed(function() {
      return vm.owner().id === user.id;
    });

    vm.invite = function (vm) {
      page_vm.modals.invite.actions.activate();
    };

    return vm;
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
