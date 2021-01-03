# Copies template config files to be placed in the HOME folder.
# Template config files source from true config files in this repository.

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

  def _get_non_dotted_filename(self) -> str:
    if self.filename[0] == ".":
      return self.filename[1:]
    return self.filename

  def get_backup_path(self) -> str:
    global BAK_FILE_REGEX
    backup_path = os.path.join(
      self.directory, "{}.bak".format(self._get_non_dotted_filename())
    )
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

  def get_template_path(self) -> str:
    global TEMPLATE_FOLDER
    return os.path.join(TEMPLATE_FOLDER, self._get_non_dotted_filename())

VALID_CONFIG_FILES = {
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

def _setup_config_file(filename: str) -> None:
  global HOME_FOLDER, VALID_CONFIG_FILES
  file_info = VALID_CONFIG_FILES[filename]
  template_path = file_info.get_template_path()
  template_sha256sum = _get_file_sha256sum(template_path)
  dest_path = file_info.get_path()
  dest_sha256sum = _get_file_sha256sum(dest_path)
  if dest_sha256sum is not None and dest_sha256sum != template_sha256sum:
    # backup original config file
    backup_path = file_info.get_backup_path()
    print("Backing up {} to {}".format(dest_path, backup_path))
    shutil.move(dest_path, backup_path)
    print("Copying template {} to {}".format(filename, dest_path))
    shutil.copyfile(template_path, dest_path)
  elif dest_sha256sum is None:
    dest_dir = file_info.directory
    if dest_dir != HOME_FOLDER and not os.path.exists(dest_dir):
      os.makedirs(dest_dir, mode=0o0750)
    print("Copying template {} to {}".format(filename, dest_path))
    shutil.copyfile(template_path, dest_path)

def _main(filenames: List[str]) -> None:
  valid_filenames = [f for f in filenames if f in VALID_CONFIG_FILES]
  for f in valid_filenames:
    _setup_config_file(f)

if __name__ == "__main__":
  _main(sys.argv[1:])
