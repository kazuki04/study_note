FactoryBot.define do
  factory :user do
    nickname {"sample nickname"}
    sequence(:email) {|n| "sample#{n}@exapmle.com"}
    password {"abc123"}
    
    after(:build) do |user|
      user.avatar.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
