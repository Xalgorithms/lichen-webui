class ChangesService
  def self.added(m)
    send('added', m)
  end

  def self.destroyed(m)
    send('destroyed', m)
  end

  private

  def self.send(effect, m)
    payload = { id: m.public_id, effect: effect, model: m.class.name.demodulize.underscore  }
    ActionCable.server.broadcast('changes', payload)        
  end
end
