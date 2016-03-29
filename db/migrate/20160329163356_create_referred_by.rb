class CreateReferredBy < ActiveRecord::Migration
  def change
    create_table :referred_bys do |t|
      t.text :root
      t.text :path
      t.timestamps null: false
    end
  end
end
