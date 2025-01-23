function __fzf_find_file -d "List files and folders"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -q FZF_FIND_FILE_COMMAND
    or set -l FZF_FIND_FILE_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"

    begin
        eval "$FZF_FIND_FILE_COMMAND | "(__fzfcmd) "-m $FZF_DEFAULT_OPTS $FZF_FIND_FILE_OPTS --query \"$fzf_query\"" | while read -l s
            set results $results $s
        end
    end

    if test -z "$results"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    for result in $results
        commandline -it -- (string escape $result)
        commandline -it -- " "
    end
    commandline -f repaint
end
