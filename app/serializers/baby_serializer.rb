class BabySerializer < ActiveModel::Serializer
  attributes :id, :name, :age_in_months, :mother_name, :father_name, :address, :phone

  def age_in_months
    calculate_months( object.birthday.to_date, Time.now.strftime("%Y-%m-%d").to_date )
  end

  def calculate_months(date1, date2)
    (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
  end
end
