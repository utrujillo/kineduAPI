class ActivityLog < ApplicationRecord
	# Asociasiones
  belongs_to :baby
  belongs_to :assistant
	belongs_to :activity
	
	# Validaciones
	validates :activity_id, presence: true, numericality: { only_integer: true }
	validates :baby_id, presence: true, numericality: { only_integer: true }
	validates :assistant_id, presence: true, numericality: { only_integer: true }
	validates :start_time, presence: true
end
