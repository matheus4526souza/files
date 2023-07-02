install:
	sed "s|__COMMON_FUNCTIONS_SH_PATH__|$(shell pwd)/lib/common_functions.sh|g" python_env.sh > python_env_temp.sh
	chmod +x python_env_temp.sh
	sudo cp python_env_temp.sh /usr/local/bin/python_env
	rm python_env_temp.sh

	sed "s|__COMMON_FUNCTIONS_SH_PATH__|$(shell pwd)/lib/python_env_autocomplete.sh|g" python_env_autocomplete.sh > python_env_autocomplete_temp.sh
	chmod +x python_env_autocomplete_temp.sh
	sudo cp python_env_autocomplete_temp.sh /etc/bash_completion.d/python_env
	rm python_env_autocomplete_temp.sh