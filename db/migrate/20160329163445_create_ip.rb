class CreateIp < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.inet :ip
      t.timestamps null: false
    end
  end
end
