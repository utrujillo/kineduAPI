class ActivityLogSerializer < ActiveModel::Serializer
  attributes :id, :baby_id, :baby_name, :teacher, :start_time, :stop_time
  
  def baby_name
    object.baby.name
  end

  def teacher
    object.assistant.name
  end
end
