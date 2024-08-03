function docker-clean --wraps='docker rm -f (docker ps -aq);docker volume rm -f  docker_das_db_volume' --description 'alias docker-clean=docker rm -f (docker ps -aq);docker volume rm -f  docker_das_db_volume'
  docker rm -f (docker ps -aq);docker volume rm -f  docker_das_db_volume $argv
        
end
