module Paginatable
  extend ActiveSupport::Concern

  included do
    scope :paginate, ->(page, per_page) { page(page).per(per_page) }
  end
end