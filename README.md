Description
===========

This is a template for deploying a [Jenkins server](http://jenkins-ci.org/)
with a number of slave nodes. A self-signed certificate will be generated for
logging into and managing Jenkins.

We recommend setting up
[authentication](https://wiki.jenkins-ci.org/display/JENKINS/Standard+Security+Setup)
to manage Jenkins to ensure any testing configurations and credentials are
safe.

If you need additional workers, we recommend using the [JClouds
Plugin](https://wiki.jenkins-ci.org/display/JENKINS/JClouds+Plugin). The plugin
is installed as a part of this stack, all you will need to do is configure it
with your cloud credentials.  Please do this after you've configured your
authentication.

Requirements
============
* A Heat provider that supports the Rackspace `OS::Heat::ChefSolo` plugin.
* An OpenStack username, password, and tenant id.
* [python-heatclient](https://github.com/openstack/python-heatclient)
`>= v0.2.8`:

```bash
pip install python-heatclient
```

We recommend installing the client within a [Python virtual
environment](http://www.virtualenv.org/).

Example Usage
=============
Here is an example of how to deploy this template using the
[python-heatclient](https://github.com/openstack/python-heatclient):

```
heat --os-username <OS-USERNAME> --os-password <OS-PASSWORD> --os-tenant-id \
  <TENANT-ID> --os-auth-url https://identity.api.rackspacecloud.com/v2.0/ \
  stack-create Jenkins-Stack -f jenkins.yaml \
  -P ssh_keypair_name=jenkins-example
```

* For UK customers, use `https://lon.identity.api.rackspacecloud.com/v2.0/` as
the `--os-auth-url`.

Optionally, set environmental variables to avoid needing to provide these
values every time a call is made:

```
export OS_USERNAME=<USERNAME>
export OS_PASSWORD=<PASSWORD>
export OS_TENANT_ID=<TENANT-ID>
export OS_AUTH_URL=<AUTH-URL>
```

Parameters
==========
Parameters can be replaced with your own values when standing up a stack. Use
the `-P` flag to specify a custom parameter.

* `server_hostname`: Sets the hostname of the server. (Default: jenkins)
* `image`: Server image used for all servers that are created as a part of this
  deployment (Default: Ubuntu 14.04 LTS (Trusty Tahr))
* `chef_version`: Version of chef client to use (Default: 11.16.4)
* `flavor`: Rackspace Cloud Server flavor to use. The size is based on the
  amount of RAM for the provisioned server. (Default: 4 GB Performance)
* `kitchen`: URL for the kitchen to use (Default:
  https://github.com/rackspace-orchestration-templates/jenkins)


Outputs
=======
Once a stack comes online, use `heat output-list` to see all available outputs.
Use `heat output-show <OUTPUT NAME>` to get the value fo a specific output.

* `private_key`: SSH private that can be used to login as root to the server.
* `server_ip`: Public IP address of the Jenkins server
* `jenkins_http_url`: URL to access Jenkins via HTTP, in place for use with
  jenkins-cli.
* `jenkins_https_url`: URL to access Jenkins via HTTPS (uses a self-signed
  cert). Preferred method for accessing and managing Jenkins.

For multi-line values, the response will come in an escaped form. To get rid of
the escapes, use `echo -e '<STRING>' > file.txt`. For vim users, a substitution
can be done within a file using `%s/\\n/\r/g`.

Stack Details
=============
A single Linux server running [Jenkins
CI](http://jenkins-ci.org/content/about-jenkins-ci) Server with multiple slave
nodes to be used for build testing.

Several useful plugins, such as
[JCloud](https://wiki.jenkins-ci.org/display/JENKINS/JClouds+Plugin), are
included as a part of this installation to ease scaling.

Contributing
============
There are substantial changes still happening within the [OpenStack
Heat](https://wiki.openstack.org/wiki/Heat) project. Template contribution
guidelines will be drafted in the near future.

License
=======
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
