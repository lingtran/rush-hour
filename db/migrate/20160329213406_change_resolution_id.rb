class ChangeResolutionId < ActiveRecord::Migration
  def change
    change_table(:payload_requests) do |t|
      t.remove :resolution_id
      t.integer :resolution_id
    end
  end
end
