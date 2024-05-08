# fish-zoxide
Fish plugin for [zoxide](https://github.com/ajeetdsouza/zoxide)

Using this plugin, you do not need to add the config `zoxide init fish | source` to `config.fish`, which will make the fish shell startup slowly.


# Installation
## fisher 
```bash
fisher install tenfyzhong/fish-zoxide
```

# Config
## zoxide init flags
The `zoxide init` command provide some flags to config the zoxide.   
But using this plugin, you do not need to add the config `zoxide init fish | source` to your config file anymore.  
In order to support the `zoxide init` feature, I made a function name `__zoxide_init` to make the same things.  
The function support the same flags with `zoxide init`:  
- `--cmd`
  - Changes the prefix of the z and zi commands.
  - `--cmd j` would change the commands to (`j`, `ji`).
  - `--cmd cd` would replace the cd command.
- `--hook <HOOK>`
  - Changes how often zoxide increments a directory's score, the default config is `pwd`:
    | Hook     | Description                       |
    |----------|-----------------------------------|
    | `none`   | Never                             |
    | `prompt` | At every shell prompta            |
    | `pwd`    | Whenever the directory is changed |
- `--no-cmd`
  - Prevents zoxide from defining the `z` and `zi` commands.
  - These functions will still be available in your shell as `__zoxide_z` and `__zoxide_zi`, should you choose to redefine them

## Environment variables
All the environment is support which the zoxide provide, you can the the office document in this page [environment-variables](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#environment-variables).  
Besides, it's support whenever you set the environment.

- `_ZO_ECHO`
  - When set to 1, z will print the matched directory before navigating to it.
- `_ZO_RESOLVE_SYMLINKS`
  - When set to 1, z will resolve symlinks before adding directories to the database.
