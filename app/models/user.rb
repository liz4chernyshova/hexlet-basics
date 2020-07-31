# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :lesson_members, class_name: 'Language::Lesson::Member', dependent: :destroy
  has_many :language_members, class_name: 'Language::Member', dependent: :destroy
  has_many :accounts, dependent: :destroy

  def guest?
    false
  end

  def finished_members_for_language(language)
    lesson_members.where(language: language).finished
  end

  def valid_password?(password)
    return false if password_digest.nil?

    authenticate(password)
  end

  def complete_language?(language)
    language_members.where(language: language).first&.finished?
  end
end
