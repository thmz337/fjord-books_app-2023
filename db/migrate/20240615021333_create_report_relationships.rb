class CreateReportRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :report_relationships do |t|
      t.references :mentioning, foreign_key: { to_table: :reports }
      t.references :mentioned, foreign_key: { to_table: :reports }
      
      t.timestamps
    end
    add_index :report_relationships, [:mentioned_id, :mentioning_id], unique: true
  end
end
