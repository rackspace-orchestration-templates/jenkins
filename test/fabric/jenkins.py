import re
from fabric.api import env, run, hide, task
from envassert import detect, file, package, port, process, service, user


def jenkins_is_responding_on_http():
    with hide('running', 'stdout'):
        homepage = run("wget --quiet --output-document - http://localhost:8080/")
        if re.search('Dashboard \[Jenkins\]', homepage):
            return True
        else:
            return False


@task
def check():
    env.platform_family = detect.detect()

    assert package.installed("jenkins")
    assert package.installed("jenkins-cli")
    assert file.exists("/etc/jenkins/cli.conf")
    assert port.is_listening(8080)
    assert port.is_listening(8081)
    assert user.exists("jenkins")
    assert process.is_up("daemon")
    assert service.is_enabled("jenkins")
    assert jenkins_is_responding_on_http()
