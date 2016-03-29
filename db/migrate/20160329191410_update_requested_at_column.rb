class UpdateRequestedAtColumn < ActiveRecord::Migration
  def change
    change_table(:payload_requests) do |t|
      t.remove :requestedAt
      t.date :requested_at
    end 
  end
end
