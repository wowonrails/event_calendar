p "--------------Creating Users and Events--------------"

9.times do |i|
  user = FactoryGirl.create(:user, email: "user_#{i + 1}@example.com")

  %w[once day week month year].each do |periodicity|
    start = Faker::Date.forward(30)

    FactoryGirl.create(:event,
      user_id: user.id,
      periodicity: periodicity,
      start: start  + (8..20).to_a.sample.hour,
      finish: periodicity == "once" ? "" : start + EventLimitValidator::REPETITION_PERIOD[periodicity.to_sym].send(periodicity),
      public: [true, false].sample
    ).recurring_event!
  end

  p "--------------------Progress #{(i + 1) * 10}%---------------------"
end

users = User.all
user  = users.first
followed_users = users[2..5]
followers      = users[4..8]
followed_users.each { |followed| user.follow!(followed) }
followers.each      { |follower| follower.follow!(user) }

p "--------------------Progress 100%--------------------"
