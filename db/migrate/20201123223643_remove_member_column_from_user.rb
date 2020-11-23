class RemoveMemberColumnFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :member, :string
  end
end
