function cd
    if test (count $argv) -eq 0
        z $argv
    else
        zi $argv &>>/dev/null || z $argv
    end
    eza -A --icons=auto --group-directories-first
end
