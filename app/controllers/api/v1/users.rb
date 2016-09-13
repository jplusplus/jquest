module API
  module V1
    class Users < Grape::API
      resource :users do

        desc "Return list of users"
        get do
          policy_scope(User).
            # Eager load points
            includes(:points).
            includes(:school).
            # Paginate
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end

        params do
          requires :id, type: Integer, desc: 'User id.'
        end
        route_param :id do
          desc 'Return a user using its id.'
          get do
            authenticate!
            garner.options(expires_in: 5.minutes) do
              policy_scope(User).
                # Eager load points
                includes(:points).
                includes(:school).
                # Find the user
                find(params[:id])
            end
          end

          desc 'Update a user using its id.'
          params do
            optional :firstname, type: String
            optional :lastname, type: String
            optional :email, type: String
            optional :phone_number, type: String
            optional :current_password, type: String
            optional :password, type: String
            optional :password_confirmation, type: String
          end
          put do
            user = policy_scope(User).find(params[:id])
            # Are we allowed to update this user?
            authorize user, :update?
            # A password is given!
            ok = unless params[:current_password].blank?
              # Update the user with all declared parameters
              user.update_with_password declared(params)
            else
              # Update the user removing missing parameters
              user.update declared(params, include_missing: false)
            end
            # Display errors nicely
            error! user.errors.full_messages.first unless ok
            # Ensure user stay connected
            sign_in user, :bypass => true if user == current_user
            # Return the user
            user
          end
        end
      end
    end
  end
end
