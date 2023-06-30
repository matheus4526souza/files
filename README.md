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
    > lists all environments
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

# setting in vscode:
ctrl + shift + p
select interpreter
find
/home/<user>/python_envs/<env_name>/bin/python<version>
