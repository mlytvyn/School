namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "admin",
                       email: "lytvyn.michael@gmail.com",
                       password: "superadmin",
                       password_confirmation: "superadmin",
                       user_type: "Administrator")
  admin.toggle!(:admin)
  
  90.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "dontteachme"
    user_type = "Student"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 user_type: user_type)
  end

  9.times do |n|
    name  = Faker::Name.name
    email = "example-#{90+n+1}@railstutorial.org"
    password  = "justteachthem"
    user_type = "Teacher"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 user_type: user_type)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end