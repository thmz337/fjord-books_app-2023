# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'user can not edit report' do
    report = reports(:report_by_alice)
    assert_not report.editable?(users(:bob))
  end

  test 'user can edit report' do
    report = reports(:report_by_alice)
    assert report.editable?(users(:alice))
  end

  test 'Get the date when the daily report was created' do
    report = reports(:report_by_bob)
    report.created_at = Date.parse('2024-06-11 09:57:39.890045')
    assert_equal '2024-06-11'.to_date, report.created_on
  end
end
