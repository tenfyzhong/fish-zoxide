# Initialize hook to add new entries to the database.
function __zoxide_hook --on-event fish_prompt
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end
