class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_posts, through: :likes, source: :post
 attachment :profile_image

 validates :name, presence: true
 validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  def already_liked?(post)
  	self.likes.exists?(post_id: post.id)
  end
end
