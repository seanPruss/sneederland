function up
    # Go up x directories
    if test (count $argv) -eq 0
        cd ..
        return
    end
    set dir ".."
    for i in (seq 2 $argv)
        set dir "../$dir"
    end
    cd $dir
end
