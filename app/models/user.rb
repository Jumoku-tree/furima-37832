class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :kanji_family_name, presence: true
  validates :kanji_first_name, presence: true
  with_options presence: true, format: {with: /\A[ァ-ヶ]+\z/, message: 'must be 2-byte katakana' } do
    validates :kana_family_name
    validates :kana_first_name 
  end
  validates :birthday, presence: true

  PASSWORD_CHAR = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}+\z/.freeze
  validates_format_of :password, with: PASSWORD_CHAR, message: 'must include both alphabet and number'
end
