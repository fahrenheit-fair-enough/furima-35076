class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nick_name
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'を全角で入力してください' } do
      validates :family_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'をカタカナ全角で入力してください' } do
      validates :family_name_kana
      validates :first_name_kana
    end
    validates :birth_date
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  end
end
