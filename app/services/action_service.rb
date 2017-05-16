class ActionService
  def self.profile_add(m)
    um = User.where(public_id: m.owner_id).first
    pm = Profile.create(name: m.name, owner: um, users: [um])

    ChangesService.added(pm)
  end

  def self.profile_invite(m)
    pm = Profile.where(public_id: m.profile_id).first
    um = User.create(email: m.email, fullname: '', password: 'password')
    pm.users << um
    um.save

    ChangesService.added(um)
  end

  @@thing_to_model = {
    'profile' => Profile,
  }
  
  def self.remove(a)
    kl = @@thing_to_model.fetch(a.thing)
    m = kl.where(public_id: a.thing_id).first
    m.destroy if m
  end
end
