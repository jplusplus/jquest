module API
  module V1
    class Channels < Grape::API
      resource :channels do
        desc "Return stats about connected users"
        get :status do
          authenticate!
          # Get Slack status as the current user
          slack_status_for(current_user).to_h
        end

        desc "Invite the current user to slack"
        get :invite do
          authenticate!
          # Get slack status for the current user
          slack_status = slack_status_for current_user
          # Has the user been invited?
          if not slack_status.is_member and not slack_status.is_invited
            # Invite the user!
            slack_invite_user! current_user
            # Stay cool B)
            { ok: true }
          else
            error! 'You already been invited'
          end
        end
      end
    end
  end
end
