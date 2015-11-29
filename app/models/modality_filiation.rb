class ModalityFiliation < ActiveRecord::Base
  belongs_to :modality
  belongs_to :filiation
end
