ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Available seasons" do
          para "Every season has its own admin panel."
          ActiveAdmin.application.namespaces.each do |namespace|
            unless namespace.name == :admin
              h3 namespace.name
              ul do
                namespace.resources.each do |resource|
                  li do
                    link_to resource.plural_resource_label, resource.route_collection_path()                    
                  end
                end
              end
            end
          end
        end
      end
    end


    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
