class ChangeCommentsName < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.rename :name, :title
    end
  end
end
