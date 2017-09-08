class Changetypeofperhours < ActiveRecord::Migration[5.1]
  def change
  	change_column :listings, :rateperhour, :integer
  end
end
