# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :userdatum, :class => 'Userdata' do
    score "MyString"
    time "MyString"
  end
end
