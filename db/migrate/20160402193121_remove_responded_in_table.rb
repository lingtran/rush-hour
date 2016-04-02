class RemoveRespondedInTable < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove :responded_in_id
      t.integer :responded_in
    end
    drop_table :responded_ins
  end
end
