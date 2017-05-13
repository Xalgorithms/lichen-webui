this.App = {}

App.pages = { };
App.listener = null;

App.broadcast = function(event) {
  if (App.listener) {
    App.listener(event);
  }
}

App.define_on_page = function (name, action, init_fn, event_fn) {
  var k = name + '_' + action;
  App.pages = _.set(App.pages, k, { init: init_fn, event: event_fn });
};

App.init_on_page = function(name, action) {
  console.log('initializing: ' + name + '/' + action);
  var k = name + '_' + action;
  var fns = _.get(App.pages, k, null);
  if (fns && fns.init) {
    console.log('init: ' + name + '/' + action);

    var page_vm = fns.init();

    console.log('init: binding page vm');
    ko.applyBindings(page_vm, document.getElementById('page'));
    App.listener = fns.event;
  } else {
    console.log('missing: ' + name + '/' + action);
  }
};

App.make_modal = function (fields, populateFn, submitFn) {
  var basic = {
    active: ko.observable(false),
    actions: { },
    model: ko.observable()
  };

  basic.actions.submit = function (vm) {
    basic.active(false);
    submitFn(basic.model());
  };
  basic.actions.deactivate =  function() {
    basic.active(false);
  };
  basic.actions.activate = function(vm) {
    basic.model(populateFn(vm));
    basic.active(true);
  };

  return _.reduce(fields, function (o, name) {
    return _.set(o, name, ko.observable());
  }, basic);
};
