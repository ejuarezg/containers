"""
Source: https://gist.github.com/briandk/924d101f28dbf309758206fa3eff32b4
Help: https://docs.python.org/3/library/subprocess.html#call-function-trio

Port of the python 3 version to python 2.
"""
import subprocess

get_line_by_line_texlive_dependencies = subprocess.check_output(
    ["apt-cache", "depends", "texlive-full"], universal_newlines=True
)

dependency_pattern = "Depends: "


def extract_dependency(dependency_text, pattern):
    dependency = dependency_text.strip().replace(pattern, "")
    return dependency


dependencies = [
    extract_dependency(line, dependency_pattern)
    for line in get_line_by_line_texlive_dependencies.splitlines()
    if line.strip().startswith(dependency_pattern)
    and not line.strip().endswith("-doc")
    and (line.strip().find("texlive-lang-") == -1)
]


arguments = ["apt-get", "install", "--assume-yes", "--no-install-recommends"]

arguments.extend(dependencies)

# execute apt-get install with all the package names
subprocess.check_call(arguments)
