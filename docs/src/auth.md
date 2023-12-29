# Authentication
To authenticate with AWS locally use this command. It would be nice to update this  
command to not have to use the `--preserve-env` flag, but right now this is the  
current situation based on how [assume-role](https://github.com/Fomiller/assume-role) is configured.

```bash
doppler run --preserve-env="AWS_ASSUME_CONFIG_DIR" just login dev
```
