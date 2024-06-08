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
end
