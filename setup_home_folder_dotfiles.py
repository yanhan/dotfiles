# Copies template dotfiles to be placed in the HOME folder.
# Template dotfiles source from true dotfiles in this repository.

import glob
import hashlib
import os
import os.path
import re
import shutil
import sys

VALID_DOTFILES = set(["bashrc", "gitconfig", "zshrc",])
TEMPLATE_FOLDER = "templates"
HOME_FOLDER = os.environ["HOME"]
BAK_FILE_REGEX = re.compile(r"""bak\.(\d+)$""")

def _get_sha256sum_of_file(file_name):
  if os.path.exists(file_name):
    with open(file_name, "r") as f:
      h = hashlib.sha256()
      h.update(f.read())
      return h.hexdigest()
  else:
    return None

def _construct_home_dotfile_backup_file_name(dotfile_name):
  bak_file_list = glob.glob(HOME_FOLDER,
    "{}.bak*".format(os.path.join(HOME_FOLDER, dotfile_name))
  )
  digit_list = []
  for f in bak_file_list:
    match_obj = BAK_FILE_REGEX.match(f)
    if match_obj is not None:
      digit_list = int(match_obj.group(1))

  bak_file_num_string = ""
  if digit_list:
    bak_file_num_string = ".{}".format(str(max(digit_list)))
  return os.path.join(HOME_FOLDER,
    "{}.bak{}".format(dotfile_name, bak_file_num_string)
  )

def _setup_dotfile(dotfile_name):
  template_dotfile_path = os.path.join(TEMPLATE_FOLDER, dotfile_name)
  template_dotfile_sha256sum = _get_sha256sum_of_file(template_dotfile_path)
  home_folder_dotfile_path = os.path.join(HOME_FOLDER,
    ".{}".format(dotfile_name)
  )
  home_dotfile_sha256sum = _get_sha256sum_of_file(home_folder_dotfile_path)
  if home_dotfile_sha256sum is not None and \
      home_dotfile_sha256sum != template_dotfile_sha256sum:
    # backup original dotfile
    home_dotfile_backup_path = _construct_home_dotfile_backup_file_name(
      dotfile_name
    )
    shutil.move(home_dotfile_path, home_dotfile_backup_path)
    shutil.copyfile(template_dotfile_path, home_dotfile_path)

def _main(dotfiles_list):
  valid_dotfiles = [f for f in dotfiles_list if f in VALID_DOTFILES]
  for dotfile in valid_dotfiles:
    _setup_dotfile(dotfile)

if __name__ == "__main__":
  _main(sys.argv[1:])
