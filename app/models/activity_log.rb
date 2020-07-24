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

  # Acciones
  validate do
    begin
      time_difference = ((self.stop_time - self.start_time) / 1.hour).round
      if time_difference < 0
        self.errors.add(:base, "La actividad no puede ser terminada en un tiempo previo a la fecha y hora de inicio")
      end
    rescue => e
      self.errors.add(:base, "La actividad no puede ser terminada en un tiempo previo a la fecha y hora de inicio")
    end
  end

  before_save do
    time_difference = ((self.stop_time - self.start_time) / 1.hour).round
    self.duration = time_difference > 0 ? time_difference : 0
  end
end
