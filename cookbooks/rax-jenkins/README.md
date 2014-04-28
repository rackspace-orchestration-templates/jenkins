rax-jenkins
===========

Wrapper cookbook to setup a few other odds and ends that cannot be done through
the community cookbook.

recipes
=======
* `cli`: installs `jenkins-cli` and sets up the cli configuration
* `plugins`: installs a list of Jenkins plugins; does not automatically resolve
  dependencies
* `rax-cannon`: installs the [Rackspace
  Canon](https://github.com/rackerlabs/canon-jenkins) theme
