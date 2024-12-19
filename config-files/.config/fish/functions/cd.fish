function cd
    if test (count $argv) -eq 0
        z $argv
    else
        zi $argv || z $argv
    end
    ls
end
