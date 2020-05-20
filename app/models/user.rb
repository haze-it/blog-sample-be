class User < ApplicationRecord
  has_secure_password

  validates :name, length: { in: 3...32 }, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-z0-9\-_]+\z/ }
  validates :email, length: { in: 5..255 }, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { in: 8...72 }, presence: true, format: { with: /\A[!-~]+\z/ }
end
