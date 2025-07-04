class Category < ApplicationRecord
  has_many :predictions, dependent: :nullify
  
  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  validates :icon, presence: true
  
  scope :ordered, -> { order(:name) }
  
  def display_name
    "#{icon} #{name}"
  end
end 