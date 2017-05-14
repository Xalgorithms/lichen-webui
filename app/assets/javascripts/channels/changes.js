App.changes = App.cable.subscriptions.create('ChangesChannel', {
  received: function (o) {
    App.listener(o);
  }
});
