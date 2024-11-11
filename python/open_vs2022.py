from pywinauto import Application
import pyautogui
import time
import sys

# コマンドライン引数からfile_pathとline_numberを取得
if len(sys.argv) < 3:
    print("Usage: script_name.py <file_path> <line_number>")
    sys.exit(1)

file_path = sys.argv[1]
line_number = sys.argv[2]
#col_num = sys.argv[3]

col_num = str(int(sys.argv[3])-1)

# devenv /editを使ってファイルを開く
app = Application().start(cmd_line="devenv /edit " + file_path)
time.sleep(0.1)
pyautogui.write(line_number + 'gg' + '0' + col_num + 'l')
