#
# Cookbook Name:: app_inmobi_redis
#

module Inmobi
  module Cron
    module Helper

      def get_cron_servers(app_name)
        require "timeout"
        inmobi_cron_servers = Hash.new
        main_tags = ["inmobi_cron:#{app_name}=true"]
        secondary_tags = ["server:uuid=*", "inmobi_cron:addr_ip=*"]

        r = server_collection "inmobi_cron_servers" do
          tags main_tags
          action :nothing
        end

        begin
          Timeout::timeout(60) do
          all_tags = main_tags.collect
          all_tags += secondary_tags.collect if secondary_tags
          delay = 1

          while true
            r.run_action(:load)
            collection = node[:server_collection]["inmobi_cron_servers"]

            break if collection.empty?
            break if !collection.empty? && collection.all? do |id, tags|
              all_tags.all? do |prefix|
                tags.detect { |tag| RightScale::Utils::Helper.matches_tag_wildcard?(prefix, tag) }
              end
            end

            delay = ((delay == 1) ? 2 : (delay*delay)) 
            Chef::Log.info "not all tags for inmobi_cron:#{app_name}=true exist; retrying in #{delay} seconds..."
            sleep delay
          end
        end
        rescue Timeout::Error => e
          raise "ERROR: timed out trying to find servers tagged with inmobi_cron:#{app_name}=true"
        end

        node[:server_collection]['inmobi_cron_servers'].to_hash.values.each do |tags|
          uuid = RightScale::Utils::Helper.get_tag_value('server:uuid', tags)
          ip = RightScale::Utils::Helper.get_tag_value('inmobi_cron:addr_ip', tags)
          inmobi_cron_servers[uuid] = {}
          inmobi_cron_servers[uuid][:ip] = ip
        end

        inmobi_cron_servers
      end

    end
  end
end
