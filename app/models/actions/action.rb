module Actions
  class Action
    include Mongoid::Document
    include Mongoid::Timestamps

    after_create do |m|
      ActionService.send(m.class.name.demodulize.underscore, m)
    end
  end
end
    
