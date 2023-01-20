class Item < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :status
  enum status: {"Built" => 0, "Trimmed" => 1, "Bisque Fired" => 2, "Glazed" => 3, "Complete" => 4}

  scope :filter_by_status, -> (status) { where status: status.to_i }

end
