class ChangePayloadRequest < ActiveRecord::Migration
  def change
    change_table(:payload_requests) do |t|
      t.remove :resolutionHeight
      t.remove :resolutionWidth
      t.remove :url
      t.remove :respondedIn
      t.remove :referredBy
      t.remove :requestType
      t.remove :parameters
      t.remove :eventName
      t.remove :userAgent
      t.remove :ip
      t.column :url_id, :integer
      t.column :responded_in_id, :integer
      t.column :referred_by_id, :integer
      t.column :request_type_id, :integer
      t.column :parameters_id, :integer
      t.column :event_name_id, :integer
      t.column :user_agent_id, :integer
      t.column :resolution_id, :text
      t.column :ip_id, :integer
    end
  end
end
