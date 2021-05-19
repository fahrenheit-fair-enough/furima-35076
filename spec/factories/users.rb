FactoryBot.define do
  factory :user do
    nick_name  {'frima太夫'}
    email {Faker::Internet.free_email}
    password {'aaa111'}
    password_confirmation {password}
    family_name {'田中'}
    first_name {'隆太郎'}
    family_name_kana {'ヤマダ'}
    first_name_kana {'リクタロウ'}
    birth_date {'1930-01-01'}
  end
end

