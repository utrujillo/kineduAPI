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
    # Se validara la diferencia de horas, solamente cuando se envien ambas fechas en la petición
    if self.stop_time.present?
      begin
        time_difference = (self.stop_time - self.start_time) / 1.hour
        if time_difference < 0
          self.errors.add(:base, "La actividad no puede ser terminada en un tiempo previo a la fecha y hora de inicio")
        end
      rescue => e
        self.errors.add(:base, "La actividad no puede ser terminada en un tiempo previo a la fecha y hora de inicio")
      end
    end
    
  end

  before_save do
    if self.stop_time.present?
      hours_difference = (self.stop_time - self.start_time) / 1.hour
      self.duration = hours_difference > 0 ? hours_difference : 0
    end
  end

  # Filtros
  scope :filter_by_baby, -> (baby_id) { 
                              where(
                                "baby_id IN (?)",
                                baby_id
                              )  
                            }
  scope :filter_by_assistant, -> (assistant_id) { 
                              where(
                                "assistant_id IN (?)",
                                assistant_id
                              )  
                            }
  scope :filter_by_process, -> (status) { 
                              where(
                                "stop_time IS ?",
                                status
                              )  
                            }
  scope :filter_by_terminated, -> (status) { 
                              where(
                                "stop_time IS NOT ?",
                                status
                              )  
                            }
end
