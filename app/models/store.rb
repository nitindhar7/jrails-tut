class Store < ActiveRecord::Base
  attr_accessible :id, :name, :city, :created_at, :updated_at
  
  has_many :employees
  
  validates_presence_of :name
  validates_presence_of :city
end
