class AddUserIdToGroupRelationship < ActiveRecord::Migration[5.0]
    def change
        add_column :group_relationships, :user_id, :integer
    end
end
