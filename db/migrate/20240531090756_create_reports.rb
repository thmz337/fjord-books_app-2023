class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
