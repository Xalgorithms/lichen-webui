class ActionService
  def self.profile_add(m)
    um = User.where(public_id: m.owner_id).first
    pm = Profile.create(name: m.name, owner: um, users: [um])

    ChangesService.added(pm)
  end
end
