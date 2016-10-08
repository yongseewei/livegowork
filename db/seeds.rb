user = {}
uids = []
User.all.each { |u| uids << u.id }

20.times do

    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['encrypted_password'] = Faker::Internet.password(8)


    User.create(user)

end
