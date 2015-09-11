class Prescription < ActiveRecord::Base
  belongs_to :consultation
  belongs_to :condition
end
