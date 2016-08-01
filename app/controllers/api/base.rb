module API
  class Base < Grape::API
    helpers AuthenticableHelpers

    helpers do
      def slack_client
        @slack_client ||= Slack::Web::Client.new
      end

      def slack_hostname
        @slack_hostname ||= begin
          # Get team info
          res = slack_client.team_info
          # Something is wrong!
          error! 'Unable to reach slack API' unless res[:ok]
          # Build the full hostname
          "https://#{res[:team][:domain]}.slack.com"
        end
      end

      def slack_members
        # Get user list
        res = slack_client.users_list(presence: 1)
        # Something when wrong?
        error! 'Unable to get information about the slack channels' unless res[:ok]
        # Get members for result
        members = res.members or []
        # Remove deleted members
        members.select { |u| not u['deleted'] }
      end
    end

    before do
      unless current_user.nil?
        # Allow us to track change on model
        PaperTrail.whodunnit = current_user.id
      end
    end


    mount V1::Base
  end
end
