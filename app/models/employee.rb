class Employee < ActiveRecord::Base
  attr_accessible :id, :fname, :lname, :created_at, :updated_at
  
  belongs_to :store
end
