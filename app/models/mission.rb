class Mission < ApplicationRecord
  belongs_to :listing

  scope :ordered_by_listing_id, -> { self.all.order('listing_id ASC, date') }
end
