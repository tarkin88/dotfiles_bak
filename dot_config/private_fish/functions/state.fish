function state --wraps='git status -sb' --description 'alias state=git status -sb'
  git status -sb $argv
        
end
