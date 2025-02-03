function yz
    # Wrapper function for yazi to cd where you closed it
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd "$cwd"
    end
    rm -f -- "$tmp"
end
