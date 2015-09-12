class Consultation < ActiveRecord::Base
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :medical_record
  belongs_to :consultant, :class_name => 'User', :foreign_key => 'user_id'
end
