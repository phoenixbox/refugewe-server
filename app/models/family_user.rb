class FamilyUser < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :family, dependent: :destroy
end
