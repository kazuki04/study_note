# FactoryBot.define do
#   factory :note_form do
#     highlight    {"Sample HighLight"}
#     excerpt     {"Sample Excerpt"}
#     body        {"Sample Body"}
#     written_day {"2021-05-10"}

#     trait :with_tags do
#       after(:build) {|note_form| note_form.tags << FactoryBot.build(:tag)}
#     end
#   end

# end
