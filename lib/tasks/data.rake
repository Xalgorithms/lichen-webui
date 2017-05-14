require_relative '../randomness'

namespace :data do
  include Randomness
  
  desc 'add users and profiles'
  task :users_and_profiles, [] => :environment do |t, args|
    User.destroy_all

    User.create(fullname: 'Bob Smith', email: 'bob@nowhere.com', password: 'password')
    rand_array do
      n = Faker::Name.name
      User.create(fullname: n, email: Faker::Internet.email(n), password: 'password')
    end

    owning_ums = User.all.to_a
    pms = rand_array do
      um = owning_ums.shift
      Profile.create(name: Faker::StarWars.unique.planet, owner: um, users: rand_some(User.all) + [um])
    end
  end
end
