class ChangeIpToText < ActiveRecord::Migration
  def change
    change_table :ips do |t|
      t.remove :ip
      t.text :ip
    end
  end
end
