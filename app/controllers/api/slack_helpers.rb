module API
  module SlackHelpers
    def slack_client
      @slack_client ||= Slack::Web::Client.new
    end

    def slack_invite_url
      @slack_invite_url ||= slack_hostname + '/api/users.admin.invite'
    end

    def slack_invite_uri
      @slack_invite_uri ||= URI.parse(slack_invite_url)
    end

    def slack_invite_headers
      {'Content-Type' =>'application/json'}
    end

    def slack_invite_user!(user)
      # Build request BODY
      payload = {
        token: slack_client.token,
        email: user.email
      }
      # Send it to slack
      response = Net::HTTP.post_form(slack_invite_uri, payload)
      # Test response statis
      if response.code.to_i == 200
        # Check body
        body = JSON.parse response.body
        # Throw an error if not ok
        raise body['error'] unless body['ok'] or body['error'] == 'already_invited'
        # Mark the user as invited
        user.update invited_to_channel_at: Time.now
      else
        raise "Unable to reach Slack or invite user (#{response.code})."
      end
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
      @slack_members ||=begin
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

    def as_slack_member(user)
      @as_slack_member ||= slack_members.select do |m|
        m.profile.email == user.invited_to_channel_as_or_email
      end
      # Returns first element (if any)
      @as_slack_member.first
    end

    def slack_status_for(user)
      # Return a hash
      OpenStruct.new(
        total: slack_members.length,
        active: slack_members.select { |u| u.presence == 'active' }.length,
        hostname: slack_hostname,
        # Find the current user among the member
        is_member: as_slack_member(current_user).present?,
        is_invited: current_user.invited_to_channel?)
    end
  end
end
