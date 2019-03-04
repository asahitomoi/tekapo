class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :name,uniqueness: true,presence:true,length: { minimum:2, maximum: 20}
  validates :body,length: {maximum: 50}

  has_many :books, dependent: :destroy
  attachment :image
end
