# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'only email registered' do
    user = users(:alice)
    user.name = ''
    assert 'alice@example.com', user.name_or_email
  end

  test 'only name registered' do
    user = users(:bob)
    assert 'bob', user.name_or_email
  end

  test 'both name and email registered' do
    user = users(:charlie)
    assert 'charie', user.name_or_email
  end
end
