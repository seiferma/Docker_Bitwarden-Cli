import pytest

@pytest.fixture(scope='session')
def img_app(pytestconfig):
    return 'test-image-app'

@pytest.fixture(scope='session')
def img_minimal(pytestconfig):
    return 'test-image-minimal'
