complete -c __zoxide_init -f
complete -c __zoxide_init -r -f -l cmd -d "changes the prefix of the z and zi commands"
complete -c __zoxide_init -r -f -l hook -a "none prompt pwd" -d "changes how often zoxide increments a directory's score, hook value should be one of [none,prompt,pwd]"
complete -c __zoxide_init -l "no-cmd" -d "prevents zoxide from defining the z and zi commands"
complete -c __zoxide_init -s h -l help -d "print this help message"
