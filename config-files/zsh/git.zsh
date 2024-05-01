# git repository greeter
last_repository=
check_directory_for_new_repository() {
	current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
	
	if [ "$current_repository" ] && \
	   [ "$current_repository" != "$last_repository" ]; then
		onefetch
	fi
	last_repository=$current_repository
}
check_directory_for_new_repository

# Git aliases
find_main_branch() {
    # Add SSH key to agent if not already added
    if ! ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_rsa.pub)"; then
        ssh-add -t 28800 ~/.ssh/id_rsa &>/dev/null
    fi
    local main_branch_ref=$(git ls-remote --heads origin | grep -E '\b(main|master)\b' | cut -f 1)
    echo "$main_branch_ref"
}
gp ()
{
    if ! ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_rsa.pub)"; then
        ssh-add -t 28800 ~/.ssh/id_rsa &>/dev/null
    fi
    git push
}
alias gc='git commit -m'
alias gco='git checkout'
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gd='git diff -w'
alias gds='git diff -w --staged'
alias grs='git restore --staged'
alias gst='git rev-parse --git-dir > /dev/null 2>&1 && git status || ls'
alias gu='git reset --soft HEAD~1'
alias gpr='git remote prune origin'
alias gpl='git pull origin $(find_main_branch)'
alias grd='git fetch origin && git rebase origin/master'
alias gbb='git-switchbranch'
alias gbf='git branch | head -1 | xargs' # top branch
alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'"
alias gla="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gec='git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
alias gcan='gc --amend --no-edit'
alias gpf='git push --force-with-lease'
alias gbdd='git-branch-utils -d'
alias gbuu='git-branch-utils -u'
alias gbrr='git-branch-utils -r -b develop'
alias gg='git branch | fzf | xargs git checkout'
alias gup='git branch --set-upstream-to=origin/$(git-current-branch) $(git-current-branch)'
alias gnext='git log --ancestry-path --format=%H ${commit}..master | tail -1 | xargs git checkout'
alias gprev='git checkout HEAD^'
