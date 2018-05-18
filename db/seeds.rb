User.create!(name: "Example User",
             email: "example@sample.org",
             password: "foobar",
             password_confirmation: "foobar",
             phones: "+37360354756",
             phone02: "+37360855356",
             address: "9931 Cortney Mall, East Khalilshire, Nevada",
             photo: "120.jpg",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@sample.org"
  password = "password"
  phones = "+373" + rand(20..99).to_s + rand(200..999).to_s + rand(200..999).to_s
  phone02 = "+373" + rand(20..99).to_s + rand(200..999).to_s + rand(200..999).to_s
  address = Faker::Address.street_address + ', ' + Faker::Address.city + ', ' + Faker::Address.state
  if n < 9
    n_string = '00' + (n + 1).to_s
  elsif n < 99
    n_string = '0' + (n + 1).to_s
  else
    n_string = (n + 1).to_s
  end
  photo = n_string + '.jpg'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               phones: phones,
               phone02: phone02,
               address: address,
               photo: photo,
               activated: true,
               activated_at: Time.zone.now)
end