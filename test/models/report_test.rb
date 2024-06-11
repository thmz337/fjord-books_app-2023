# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'user can not edit report' do
    report = reports(:first)
    assert_not report.editable?(users(:bob))
  end

  test 'user can edit report' do
    report = reports(:first)
    assert_not report.editable?(users(:alice))
  end

  test 'Get the date when the daily report was created' do
    report = reports(:second)
    assert 'Tue, 11 Jun 2024', report.created_on
  end
end
