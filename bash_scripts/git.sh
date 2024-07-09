alias gol="git log --oneline"
function god() {
    rev="$1"
    test -z $rev && { git diff HEAD ; return 0; }
    git diff $rev~1 $rev
}
