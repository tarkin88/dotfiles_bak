function unstage --wraps='git reset' --description 'alias unstage=git reset'
  git reset $argv
        
end
