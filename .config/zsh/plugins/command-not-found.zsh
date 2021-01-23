command_not_found_handler() {
        local pkgs cmd="$1"

        pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
        if [[ -n "$pkgs" ]]; then
                print -P "%U%F{blue}$cmd%u%f%s may be found in the following packages:"
                print -f "  %s\n" $pkgs[@]
        else
                print -f "zsh: command not found: %s"
                print -P "%U%F{red}$cmd%u%f"
        fi 1>&2
        return 127
}
