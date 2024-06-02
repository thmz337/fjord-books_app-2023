class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :body
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
