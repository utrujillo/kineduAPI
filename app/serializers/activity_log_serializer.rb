class ActivityLogSerializer < ActiveModel::Serializer
  attributes :id, :baby_id, :baby_name, :teacher, :start_time, :stop_time, :duration, :comments

  def attributes(*args)
    hash = super
    hash.select {|k,v| rule.include?(k) }
  end

  def rule
    rule = instance_options[:rule].present? ? instance_options[:rule].upcase.to_s : 'PUBLIC'
    
    "ActivityLogSerializer::#{rule}".constantize
  end
  
  def baby_name
    object.baby.name
  end

  def teacher
    object.assistant.name
  end

  # Atributos que serán retornados dependiendo de la vista que realiza la petición
  # GET api/babies/:id/activity_logs
  INDEX = [ :id, :baby_id, :baby_name, :teacher, :start_time, :stop_time ]
  # GET api/activity_logs/:id
  PUBLIC = [ :id, :baby_id, :baby_name, :teacher, :start_time, :stop_time, :duration, :comments ]

end
