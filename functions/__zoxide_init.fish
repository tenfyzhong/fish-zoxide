function __zoxide_init --description 'wrap command `zoxide init`'
    set -l v $argv
    while test -n "$v"
        switch "$v[1]"
            case -h --help
                __zoxide_init_help
                return 0
            case --cmd
                set z_cmd $v[2]
                if test -z "$z_cmd"
                    return 1
                end
                set v $v[3..-1]
            case --hook
                set z_hook $v[2]
                if test -z "$z_hook"
                    return 2
                end
                set v $v[3..-1]
            case --no-cmd
                set z_no_cmd 1
                set v $v[2..-1]
            case \*
                return 3
        end
    end

    if set -q z_cmd
        __zoxide_create_cmd "$z_cmd" || return $status
    end

    if set -q z_hook
        __zoxide_process_hook "$z_hook" || return $status
    end

    if set -q z_no_cmd
        __zoxide_remove_cmd || return $status
    end
end

function __zoxide_init_help
    printf %s\n \
        "__zoxide_init: desc" \
        "Usage: __zoxide_init <opts>" \
        "" \
        "Options:"\
        "  -h/--help               print this help message"\
        "  --cmd cmd               changes the prefix of the z and zi commands"\
        "  --hook hook             changes how often zoxide increments a directory's score, hook value should be one of [none,prompt,pwd]"\
        "  --no-cmd                prevents zoxide from defining the z and zi commands"
end

function __zoxide_remove_cmd
    set -l cmd_name "$zoxide_cmd"
    if test -z "$cmd_name"
        set cmd_name "z"
    end

    command rm -f -- $__fish_config_dir/functions/"$cmd_name".fish
    command rm -f -- $__fish_config_dir/functions/"$cmd_name"i.fish
    functions -e "$cmd_name"
    functions -e "$cmd_name"i

    set -Ue zoxide_cmd
end

function __zoxide_process_hook -a hook
    if test -z "$hook"
        return 0
    end

    set -l target "$__fish_config_dir/conf.d/__zoxide_hook.fish"

    functions -e __zoxide_hook
    switch "$hook"
        case none
            command rm -f -- "$target"
        case pwd
            command ln -f -- $__fish_config_dir/functions/__zoxide_hook_pwd.fish "$target"
        case prompt
            command ln -f -- $__fish_config_dir/functions/__zoxide_hook_prompt.fish "$target"
        case \*
            return 4
    end

    source "$target"
end

function __zoxide_create_cmd -a cmd
    __zoxide_remove_cmd

    set -Ux zoxide_cmd "$cmd"
    if test -z "$zoxide_cmd"
        set -Ux zoxide_cmd z
    end

    eval "alias --save $zoxide_cmd __zoxide_z &>/dev/null"
    eval "alias --save "$zoxide_cmd"i __zoxide_zi &>/dev/null"
end
