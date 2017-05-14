(function () {
  var page_vm = {
    modals: {
      //room: App.make_modal([], populateRoom, submitRoom)
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

    return vm;
  }
  
  function init() {
    page_vm.profiles = ko.observableArray(_.map(profiles, make_profile_vm));

    page_vm.chunks = ko.computed(function() {
      return _.chunk(page_vm.profiles(), 4);
    });

    page_vm.add = function (vm) {
      //page_vm.modals.room.actions.activate();
    };

    return page_vm;
  }

  App.define_on_page('profiles', 'index', init, receive);
})();
