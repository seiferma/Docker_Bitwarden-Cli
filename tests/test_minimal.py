from testcontainers.core.container import DockerContainer
from testcontainers.core.wait_strategies import LogMessageWaitStrategy
from testcontainers.core.network import Network

def test_help(img_minimal):
    with DockerContainer(img_minimal).with_command("-h") as subject:
        subject.waiting_for(LogMessageWaitStrategy(".*Usage: bw .*"))
