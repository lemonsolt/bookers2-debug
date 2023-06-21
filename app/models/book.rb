class Book < ApplicationRecord
  belongs_to :user
  validates :title,length:{minimum:1,maximum:20},presence:true
  validates :body,length:{maximum:200},presence:true
end
