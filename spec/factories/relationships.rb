FactoryGirl.define do
  factory :relationship do
    association :follower, factory: :user, strategy: :build
    association :followed, factory: :user, strategy: :build
  end
end
