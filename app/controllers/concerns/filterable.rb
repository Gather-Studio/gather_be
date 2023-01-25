module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def param_filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results.uniq
    end
  end
end