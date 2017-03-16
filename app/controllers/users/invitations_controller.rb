class Users::InvitationsController < Devise::InvitationsController

  # see https://github.com/scambra/devise_invitable/blob/master/app/controllers/devise/invitations_controller.rb#L52
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      if Devise.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        sign_in(resource_name, resource)
        # Redirect to the season this user is related to
        if resource.group and resource.group.season
          redirect_to resource.group.season.path
        else
          respond_with resource, :location => after_accept_path_for(resource)
        end
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, :location => new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource){ render :edit }
    end
  end

  protected

  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      set_flash_message(:alert, :invitation_token_invalid) if is_flashing_format?
      redirect_to new_user_session_path
    end
  end
end
