class CreateReportMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|
      t.belongs_to :mentioning_report, class_name: "Report", foreign_key: true
      t.belongs_to :mentioned_report,  class_name: "Report", foreign_key: true
      t.timestamps
    end
  end
end
