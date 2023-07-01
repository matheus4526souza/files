# Usage


### python_installer.sh
``` sudo bash python_installer.sh <python link> ```
<br>
example:
<br>
``` sudo bash python_installer.sh https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz ```

# Env control

### python_env.sh
```
make install
python_env help
- `python_env create <python version> <environment name>`
    > creates an environment with the provided python version at /home/nebula/python_envs/<environment name>
- `source $(python_env activate <environment name>)`
    > it needs to run like this to activate the environment
- `python_env remove <environment name>`
    > removes the environment
- `python_env list`
    > lists all environments <env_name> <python_version>
```

creating an environment:
```sudo python_env create 3.9 test```
if python version do not exist, it will raise an error.
example:
```sudo python_env create 3.4 test```
will return:
```python3.4 is not installed```
and exits the script.

if the creation is succesful:
```
sudo python_env create 3.9 test
- creating environment with 3.9
- creating path
- <prints path where the environment is at>
```

activating an environment:
``` source $(python_env activate test) ```

removing an environment:
``` sudo python_env remove test ```

listing all environments:
``` python_env list ```
<br>
```
env_1 python3.10
env_2 python3.9
```

# Setting up VSCode with the virtual environment:
Press `Ctrl + Shift + P` to open the command palette in VSCode.
<br>
Search for `Python: Select Interpreter`.
<br>
From the drop-down list, look for the path to your virtual environment's Python interpreter. It should be something like:
<br>
`/home/<user>/python_envs/<env_name>/bin/python<version>`.
<br>
Select it, and VSCode will use the Python interpreter from your virtual environment.
<br>
Replace *user*, *env_name*, and *version* with your actual username, the name of your virtual environment, and the Python version you're using, respectively.


# future features

add the script python_installer.sh to be a command in the python_env like:
<br>
python_env install <link>
<br>
make tests for all bash scripts
<br>
