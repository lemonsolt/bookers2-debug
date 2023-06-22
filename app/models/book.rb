class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title,length:{minimum:1,maximum:20},presence:true
  validates :body,length:{maximum:200},presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
