class Product < ApplicationRecord
  belongs_to :user
  has_one    :purchase_record
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_free_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates_inclusion_of :price, in: 300..9_999_999
  with_options presence: true do
    validates :name
    validates :explain
    validates :price
    validates :image

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :shipping_free_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
  end
end

## products テーブル

# | Column                         | Type       | Options           |
# | ------------------------------ | ---------- | ----------------- |
# | name                           | string     | null: false       |
# | explain                        | text       | null: false       |
# | category_id                    | integer    | null: false       |
# | status_id                      | integer    | null: false       |
# | shipping_free_status_id        | integer    | null: false       |
# | prefecture_id                  | integer    | null: false       |
# | scheduled_delivery_id          | integer    | null: false       |
# | price                          | integer    | null: false       |
# | user                           | references | foreign_key: true |
