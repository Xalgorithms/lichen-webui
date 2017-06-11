class ChangesService
  def self.added(m, props=[])
    send('added', m, props)
  end

  def self.destroyed(m, props=[])
    send('destroyed', m, props)
  end

  private

  def self.send(effect, m, props)
    payload = { effect: effect, model: m.class.name.demodulize.underscore  }
    if m.respond_to?(:public_id)
      payload = payload.merge(id: m.public_id)
    else
      payload = payload.merge(props.inject({}) do |o, k|
                                o.merge(k => m.send(k))
                              end)
    end
    Rails.logger.info("broadcasting: #{payload}")
    ActionCable.server.broadcast('changes', payload)        
  end
end
