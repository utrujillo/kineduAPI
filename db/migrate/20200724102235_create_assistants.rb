class CreateAssistants < ActiveRecord::Migration[5.2]
  def change
    create_table :assistants do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :group

      t.timestamps
    end
  end
end
