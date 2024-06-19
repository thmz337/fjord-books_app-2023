# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_report_relationships, class_name: 'ReportRelationship', foreign_key: :mentioning_id, dependent: :destroy, inverse_of: :mentioning
  has_many :passive_report_relationships, class_name: 'ReportRelationship', foreign_key: :mentioned_id, dependent: :destroy, inverse_of: :mentioned

  has_many :mentioning_reports, through: :active_report_relationships, source: :mentioned
  has_many :mentioned_reports, through: :passive_report_relationships, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mention_registration
    report_ids_from_content = content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.uniq.map(&:to_i)
    self.mentioning_report_ids = Report.where(id: report_ids_from_content).where.not(id:).pluck(:id)
  end

  def save_with_mention_registration
    Report.transaction do
      if save
        mention_registration
      else
        false
      end
    end
  end

  def update_with_mention_registration
    Report.transaction do
      if update
        mention_registration
      else
        false
      end
    end
  end
end
