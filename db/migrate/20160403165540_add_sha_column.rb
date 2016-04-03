class AddShaColumn < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.text :digest
    end
  end
end
