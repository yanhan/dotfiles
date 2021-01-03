# Copies template dotfiles to be placed in the HOME folder.
# Template dotfiles source from true dotfiles in this repository.

import glob
import hashlib
import os
import os.path
import re
import shutil
import sys
from typing import List, Optional

HOME_FOLDER = os.environ["HOME"]
TEMPLATE_FOLDER = "templates"

class ConfigFile:
  def __init__(self, directory: str, filename: str) -> None:
    self.directory = directory
    self.filename = filename

  def get_path(self) -> str:
    return os.path.join(self.directory, self.filename)

  def get_backup_path(self) -> str:
    return os.path.join(
      self.directory, "{}.bak".format(self._get_non_dotted_filename())
    )

  def _get_non_dotted_filename(self) -> str:
    if self.filename[0] == ".":
      return self.filename[1:]
    return self.filename

  def get_template_path(self) -> str:
    global TEMPLATE_FOLDER
    return os.path.join(TEMPLATE_FOLDER, self._get_non_dotted_filename())

VALID_DOTFILES = {
  "bashrc": ConfigFile(HOME_FOLDER, ".bashrc"),
  "gitconfig": ConfigFile(HOME_FOLDER, ".gitconfig"),
  "init.vim": ConfigFile(
    os.path.join(HOME_FOLDER, ".config", "nvim"),
    "init.vim",
  ),
  "tmux.conf": ConfigFile(HOME_FOLDER, ".tmux.conf"),
  "vimrc": ConfigFile(HOME_FOLDER, ".vimrc"),
  "zshrc": ConfigFile(HOME_FOLDER, ".zshrc"),
}

BAK_FILE_REGEX = re.compile(r"""\.bak\.(\d+)$""")

def _get_file_sha256sum(filename: str) -> Optional[str]:
  if os.path.exists(filename):
    with open(filename, "rb") as f:
      h = hashlib.sha256()
      h.update(f.read())
      return h.hexdigest()
  else:
    return None

def _get_dotfile_backup_path(file_info: ConfigFile) -> str:
  global BAK_FILE_REGEX
  backup_path = file_info.get_backup_path()
  bak_files = glob.glob("{}*".format(backup_path))
  digits_used = []
  for f in bak_files:
    match_obj = BAK_FILE_REGEX.search(f)
    if match_obj is not None:
      digits_used.append(int(match_obj.group(1)))

  digit_suffix = ""
  if digits_used:
    digit_suffix = ".{}".format(str(max(digits_used) + 1))
  elif bak_files:
    digit_suffix = ".1"
  return "{}{}".format(backup_path, digit_suffix)

def _setup_dotfile(dotfile_name: str) -> None:
  global HOME_FOLDER, VALID_DOTFILES
  file_info = VALID_DOTFILES[dotfile_name]
  template_path = file_info.get_template_path()
  template_sha256sum = _get_file_sha256sum(template_path)
  dest_path = file_info.get_path()
  dest_sha256sum = _get_file_sha256sum(dest_path)
  if dest_sha256sum is not None and dest_sha256sum != template_sha256sum:
    # backup original dotfile
    backup_path = _get_dotfile_backup_path(file_info)
    print("Backing up {} to {}".format(dest_path, backup_path))
    shutil.move(dest_path, backup_path)
    print("Copying template {} to {}".format(dotfile_name, dest_path))
    shutil.copyfile(template_path, dest_path)
  elif dest_sha256sum is None:
    dest_dir = file_info.directory
    if dest_dir != HOME_FOLDER and not os.path.exists(dest_dir):
      os.makedirs(dest_dir, mode=0o0750)
    print("Copying template {} to {}".format(dotfile_name, dest_path))
    shutil.copyfile(template_path, dest_path)

def _main(dotfiles: List[str]) -> None:
  valid_dotfiles = [f for f in dotfiles if f in VALID_DOTFILES]
  for f in valid_dotfiles:
    _setup_dotfile(f)

if __name__ == "__main__":
  _main(sys.argv[1:])
