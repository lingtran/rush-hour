class RemoveParameters < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove :parameters_id
    end
    drop_table :parameters
  end
end
