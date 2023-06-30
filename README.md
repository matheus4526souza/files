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
- **`python_env create <python version> <environment name>`** : creates an environment with the provided python version at /home/nebula/python_envs/<environment name>
- **`source $(python_env activate <environment name>)`** : it needs to run like this to activate the environment
- **`python_env remove <environment name>`** : removes the environment
- **`python_env list`** : lists all environments
```