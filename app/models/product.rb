class Product < ApplicationRecord
  belongs_to :user
  # has_one    :purchase_record
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_free_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :name
    validates :explain
    validates :category_id
    validates :status_id
    validates :shipping_free_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
    validates :image
  end
end
