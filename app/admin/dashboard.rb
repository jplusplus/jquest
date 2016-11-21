ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Updates" do
          section "Recently updated content" do
            table_for PaperTrail::Version.order('id desc').limit(10) do # Use PaperTrail::Version if this throws an error
              column ("Item") { |v| v.item }
              # column ("Item") { |v| link_to v.item, [:admin, v.item] } # Uncomment to display as link
              column ("Type") { |v| v.item_type.underscore.humanize }
              column ("Modified at") { |v| v.created_at.to_s :long }
              column ("Author") { |v| link_to User.find(v.whodunnit).email, [:admin, User.find(v.whodunnit)] }
            end
          end
        end
      end
    end
  end # content
end
