module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, ->(keyword) { where(self.conditions(keyword)) }
  end

  module ClassMethods
    def conditions(keyword)
      return if keyword.blank?
      self.searchable_fields.map { |field| "#{field} LIKE '%#{keyword}%'" }.join(' OR ')
    end
  end
end