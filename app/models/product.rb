# frozen_string_literal: true

class Product < ApplicationRecord
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
end
