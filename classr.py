import os
import shutil
import time
import ctypes

# 制作信息
print("classr-clean")
print("v1.0.0")
print("make by krutziy")
print("项目地址:https://github.com/ktziy/classr-clean/")

# 获取用户桌面路径
desktop_path = os.path.join(os.path.expanduser('~'), 'Desktop')
misc_folder_path = os.path.join(desktop_path, '杂项')

# 定义文件分类字典，使用中文作为分类名称
file_types = {
    '文档': ['.pdf', '.doc', '.docx', '.txt'],
    'PPT': ['.ppt', '.pptx'],
    '表格': ['.xls', '.xlsx'],
    '图片': ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.svg'],
    '视频': ['.mp4', '.mkv', '.mov', '.avi', '.flv'],
    '音频': ['.mp3', '.wav', '.aac', '.flac'],
    '压缩文件': ['.zip', '.rar', '.7z', '.tar', '.gz'],
    '程序': ['.exe', '.bat', '.sh'],
    '其他': []  # 用于未分类的文件
}

# 创建分类文件夹
def create_folder(base_path, folder_name):
    folder_path = os.path.join(base_path, folder_name)
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    return folder_path

# 文件整理功能
def organize_files():
    try:
        if not os.path.exists(misc_folder_path):
            os.makedirs(misc_folder_path)

        for item in os.listdir(desktop_path):
            item_path = os.path.join(desktop_path, item)
            if os.path.isfile(item_path) and not item.endswith('.lnk'):
                file_ext = os.path.splitext(item)[-1].lower()
                moved = False
                for folder, extensions in file_types.items():
                    if file_ext in extensions:
                        dest_folder = create_folder(misc_folder_path, folder)
                        shutil.move(item_path, os.path.join(dest_folder, item))
                        moved = True
                        break
                if not moved:
                    others_folder = create_folder(misc_folder_path, '其他')
                    shutil.move(item_path, os.path.join(others_folder, item))
    except Exception as e:
        print(f"发生错误：{e}")

# 调用 Windows Shell API 进行桌面排列
def arrange_desktop_icons():
    desktop_hwnd = ctypes.windll.user32.FindWindowW("Progman", None)
    if desktop_hwnd:
        ctypes.windll.user32.SendMessageW(desktop_hwnd, 0x1033, 3, 0)  # LVM_ARRANGE, 参数 3 表示按类型排列
        print("桌面图标已按文件类型排列")
    else:
        print("未能找到桌面窗口")

# 程序主入口
if __name__ == "__main__":
    organize_files()
    time.sleep(1)
    arrange_desktop_icons()
    print("桌面文件已整理完毕！")
