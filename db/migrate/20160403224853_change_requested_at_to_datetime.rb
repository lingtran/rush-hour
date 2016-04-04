class ChangeRequestedAtToDatetime < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove :requested_at
      t.datetime :requested_at
    end
  end
end
