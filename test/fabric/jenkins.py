import re

from fabric.api import env, run, hide, task
from envassert import detect, file, package, port, process, service, user
from time import sleep


def jenkins_is_responding_on_http():
    with hide('running', 'stdout'):
        sleep(10)  # Jenkins can take a few seconds to come up when started
        site = "http://localhost:8080/"
        homepage = run("wget --quiet --output-document - %s" % site)
        if re.search('Dashboard \[Jenkins\]', homepage):
            return True
        else:
            return False


@task
def check():
    env.platform_family = detect.detect()

    assert package.installed("jenkins")
    assert file.exists("/var/lib/jenkins/hudson.model.UpdateCenter.xml")
    assert port.is_listening(8080)
    assert port.is_listening(8081)
    assert user.exists("jenkins")
    assert process.is_up("daemon")
    assert service.is_enabled("jenkins")
    assert jenkins_is_responding_on_http()
