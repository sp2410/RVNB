class CreateSpecks < ActiveRecord::Migration[5.1]
  def change
    create_table :specks do |t|
      t.string :name

      t.timestamps
    end
  end
end
