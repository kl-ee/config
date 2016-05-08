#!/usr/bin/env python3
import os
import shutil

base_dir = os.environ['HOME']
config_dir = os.path.join(base_dir, 'config')

# Dictionary that maps {base_dir}/file -> {config_dir}/directory/file
dot_dict = {
    '.bashrc': 'bash',
    '.vimrc': 'vim',
    '.vim': 'vim',
    '.tmux.conf': 'tmux',
    '.inputrc': 'bash',
    '.emacs.d': 'emacs',
    '.spacemacs': 'emacs',
    '.lein': 'lein'
}

print("Base dir:", base_dir)
print("Config dir:", config_dir)
confirm = input("Continue(Y/N)? ").lower()
print("")

if confirm in ['y', 'yes']:
    for key, val in dot_dict.items():
        cur_file = os.path.join(base_dir, key)
        cur_link = os.path.join(*[config_dir, val, key])

        create_link = True
        if os.path.exists(cur_file):
            if os.path.islink(cur_file):
                print("[{}] Symlink already exists.  Ignoring...".format(key))
                create_link = False
            else:
                print("[{}] Moving original file...".format(key))
                shutil.move(cur_file, cur_file + "_orig")
        if create_link:
            print("[{}] Creating symlink...".format(key))
            os.symlink(cur_link, cur_file)
else:
    print("Exiting...")
