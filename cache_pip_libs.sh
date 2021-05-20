#!/bin/bash

set -ueo pipefail

get_known_packages() {
    cat <<'EOF_PACKAGES'
appdirs
appdirs==1.4.4
attrs==21.2.0
bleach==3.3.0
certifi==2020.12.5
cffi==1.14.5
click==7.1.2
click==8.0.0
colorama==0.4.4
cryptography==3.4.7
dateparser
distlib==0.3.1
Frontmatter
chardet==4.0.0
idna==2.10
iniconfig==1.1.1
iniconfig
Jinja2==2.11.3
jinja2==3.0.0
Jinja2==3.0.0
jsons
MarkupSafe==1.1.1
MarkupSafe==2.0.0
mc-bin-client==1.0.1
more-itertools==8.7.0
mypy-extensions==0.4.3
packaging==20.9
pathspec==0.8.1
pluggy==0.13.1
pycparser==2.20
Pygments==2.9.0
pyparsing==2.4.7
pytest==6.2.4
python-dateutil==2.8.1
python-frontmatter
python-frontmatter==1.0.0
pytz==2021.1
pyyaml
PyYAML
PyYAML==5.1
pyyaml==5.4.1
PyYAML==5.4.1
py==1.10.0
regex==2021.4.4
requests==2.25.1
roman
roman==3.3
setuptools
six==1.16.0
tap.py
tap.py==3.0
toml==0.10.2
tqdm==4.60.0
urllib3==1.26.4
webencodings==0.5.1
zipp==3.4.1
EOF_PACKAGES
}

packages_to_cache() {
    local pkg
    get_known_packages | sort | while read -r pkg; do
        echo "$pkg"
        echo "$pkg" | sed 's#\([^>=<]*\)[>=<].*#\1#'
    done | sort | uniq
}


mkdir -p /srv/nswi177/pypi/
mkdir /srv/nswi177/pypi/cache
mkdir /srv/nswi177/pypi/downloads

packages_to_cache | while read -r package_name; do
    ( echo; echo ">>>>> $package_name" ) >&2

    pip download \
        --cache-dir /srv/nswi177/pypi/cache/ \
        --dest /srv/nswi177/pypi/downloads/ \
        "$package_name"
done
