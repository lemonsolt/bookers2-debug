class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # ここからフォローフォロワー関係
  has_many :relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: 'Relationship',foreign_key: :followed_id
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  # ここまで
  has_one_attached :profile_image

  validates :name, length:{ minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum:50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # フォロー関連のメソッド(仮置き)
  # def follow(other_user)
  #   unless self == other_user
  #     self.relationships.find_or_create_by(follower_id: other_user.id)
  #   end
  # end
  # def unfollow(other_user)
  #   relationship = self.relationships.find_by(follower_id: other_user.id)
  #   relationship.destroy if relationship
  # end
  def is_followed_by?(user)
    reverse_of_relationships.find_by(follower_id: user.id).present?
  end
end
