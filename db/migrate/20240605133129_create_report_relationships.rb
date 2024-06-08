class CreateReportRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :report_relationships do |t|
      t.integer :mentioning_id
      t.integer :mentioned_id

      t.timestamps
    end
    add_index :report_relationships, :mentioning_id
    add_index :report_relationships, [:mentioned_id, :mentioning_id], unique: true
  end
end
