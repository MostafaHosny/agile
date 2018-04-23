# frozen_string_literal: true

class Product < ApplicationRecord

  has_many :line_items

  #-------------validations ----------------
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  # we used allow_blank to avoid getting multiple error messages
  # when the field is blank.
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    messgae: 'must be a URL for GIF, JPG or PNG image.'
  }
  #-------------callbacks--------------
  before_destroy :ensure_not_referenced_by_any_line_item

  private 
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end
