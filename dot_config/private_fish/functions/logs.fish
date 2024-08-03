function logs --wraps='git log  --color --graph --pretty --abbrev-commit | command less -r' --description 'alias logs=git log  --color --graph --pretty --abbrev-commit | command less -r'
  git log  --color --graph --pretty --abbrev-commit | command less -r $argv
        
end
