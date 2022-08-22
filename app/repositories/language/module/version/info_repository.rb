# frozen_string_literal: true

module Language::Module::Version::InfoRepository
  extend ActiveSupport::Concern

  included do
    scope :with_locale, ->(locale = I18n.locale) { where(locale: locale) }
  end
end
