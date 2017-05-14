class ChangesService
  def self.added(m)
    payload = { id: m.public_id, effect: 'added', model: m.class.name.demodulize.underscore  }
    ActionCable.server.broadcast('changes', payload)    
  end
end
