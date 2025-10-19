from testcontainers.core.container import DockerContainer
from testcontainers.core.wait_strategies import LogMessageWaitStrategy
from testcontainers.core.network import Network

def test_help(img_app):
    with DockerContainer(img_app).with_command("-h") as subject:
        subject.waiting_for(LogMessageWaitStrategy(".*Usage: bw .*"))
