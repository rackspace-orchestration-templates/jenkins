# coding: utf-8
#
# Cookbook Name:: rax-jenkins
# Recipe:: rax-canon
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

# Install Rackspace Canon Jenkins Theme
if node['rax']['jenkins']['install_theme']
  template File.join(node['jenkins']['master']['home'], 'org.codefirst.SimpleThemeDecorator.xml') do
    source 'org.codefirst.SimpleThemeDecorator.xml'
    mode 0644
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    notifies :restart, 'service[jenkins]'
    action :create_if_missing
  end
end
