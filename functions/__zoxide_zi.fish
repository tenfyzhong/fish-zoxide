# Jump to a directory using interactive search.
function __zoxide_zi
    __zoxide_check || return $status
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

