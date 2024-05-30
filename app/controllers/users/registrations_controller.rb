# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    super
    profile_picture = account_update_params[:profile_picture]
    resource.profile_picture.attach(profile_picture) unless profile_picture.nil?
  end
end
