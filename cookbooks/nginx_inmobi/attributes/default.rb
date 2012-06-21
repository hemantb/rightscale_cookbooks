#
# Cookbook Name:: nginx
# Attributes:: default
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['nginx']['dir'] = "/opt/mkhoj/conf/nginx"
default['nginx']['binary'] = "/opt/mkhoj/sbin/nginx"

case node['platform']
when "debian","ubuntu"
  default['nginx']['user']       = "nobody"
end

default['nginx']['gzip']              = "on"
default['nginx']['gzip_comp_level']   = "2"
default['nginx']['gzip_proxied']      = "any"
default['nginx']['gzip_types']        = [
  "text/plain",
  "text/css",
  "application/x-javascript",
  "text/xml",
  "application/xml",
  "application/xml+rss",
  "text/javascript",
  "application/javascript",
  "application/json"
]

default['nginx']['keepalive']          = "on"
default['nginx']['keepalive_timeout']  = 65
default['nginx']['worker_processes']   = 2
default['nginx']['worker_connections'] = 16384

default['nginx']['disable_access_log'] = false
