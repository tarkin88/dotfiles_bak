function sort-mirrors --wraps='sudo reflector --country "Mexico,United States" --latest 5 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist' --description 'alias sort-mirrors=sudo reflector --country "Mexico,United States" --latest 5 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
  sudo reflector --country "Mexico,United States" --latest 5 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist $argv
        
end
