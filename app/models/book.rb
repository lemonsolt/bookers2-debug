class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,length:{minimum:1,maximum:20},presence:true
  validates :body,length:{maximum:200},presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
