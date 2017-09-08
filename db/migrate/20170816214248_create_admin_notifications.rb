class CreateAdminNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_notifications do |t|
    	t.string :message    	
      	t.timestamps
    end
  end
end
