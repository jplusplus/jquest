module VersionsControl
  def self.extended(base)
    base.instance_eval do
      controller do
        def show
          @resource = resource.class.includes(versions: :item).find(params[:id])
          @versions = @resource.versions
          @resource = @resource.versions[params[:version].to_i].reify if params[:version]
          show!
        end
      end

      sidebar "versions", only: :show do
        if versions.length == 0
          strong 'No versions yet'
        else
          last     = versions.last
          first    = versions.first
          active   = resource.version.nil? ? last : resource.version

          if active.index != last.index
            strong 'Your are consulting a previous version'
          end

          table_for versions.reverse do

            column 'Version' do |v|
              link_to v.created_at.to_s(:short), {:version => v.index}
            end

            column 'Author' do |v|
              if v.whodunnit.present?
                link_to User.find(v.whodunnit).display_name, [:admin, User.find(v.whodunnit)]
              end
            end

            column '' do |v|
              div style: 'text-align: right' do
                if v.index == last.index
                  status_tag 'Last', class: (v.index == active.index ? 'ok' : '')
                elsif v.index == first.index
                  status_tag 'First', class: (v.index == active.index ? 'ok' : '')
                else
                  status_tag 'Previous', class: (v.index == active.index ? 'ok' : '')
                end
              end
            end
          end
        end
      end
    end
  end
end
