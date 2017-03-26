class AddGroupIdToGroupRelationship < ActiveRecord::Migration[5.0]
    def change
        add_column :group_relationships, :group_id, :integer
    end
end
