# coding: utf-8
#
# Cookbook Name:: rax-firewall
# Recipe:: default
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

%w( tcp udp ).each do |proto|
  node['rax']['firewall'][proto].each do |listen_port|
    case node['platform']
    when 'ubuntu'
      firewall_rule "Firewall rule, tcp/#{listen_port}" do
        port      listen_port.to_i
        case proto
        when 'tcp'
          protocol  :tcp
        when 'udp'
          protocol :udp
        end
        direction :in
        action    :allow
      end
    when 'rhel', 'centos', 'debian'
      iptables_ng_rule "Firewall rule, #{proto}/#{listen_port}" do
        name       'Allow'
        chain      'INPUT'
        table      'filter'
        ip_version [4, 6]
        rule       "-p #{proto} --dport #{listen_port} -j ACCEPT"
        action     :create_if_missing
      end
    end
  end
end
