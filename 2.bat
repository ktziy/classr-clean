@echo off
chcp 65001 >nul
:: 创建目标文件夹（如不存在）
if not exist "%USERPROFILE%\Desktop\课件" mkdir "%USERPROFILE%\Desktop\课件"
if not exist "%USERPROFILE%\Desktop\视频" mkdir "%USERPROFILE%\Desktop\视频"
if not exist "%USERPROFILE%\Desktop\图片" mkdir "%USERPROFILE%\Desktop\图片"
if not exist "%USERPROFILE%\Desktop\压缩包" mkdir "%USERPROFILE%\Desktop\压缩包"
if not exist "%USERPROFILE%\Desktop\其他" mkdir "%USERPROFILE%\Desktop\其他"

:: 1. 移动办公文件 → 课件
move "%USERPROFILE%\Desktop\*.ppt*" "%USERPROFILE%\Desktop\课件\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.doc*" "%USERPROFILE%\Desktop\课件\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.xls*" "%USERPROFILE%\Desktop\课件\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.pdf" "%USERPROFILE%\Desktop\课件\" >nul 2>nul

:: 2. 移动视频文件 → 视频
move "%USERPROFILE%\Desktop\*.mp4" "%USERPROFILE%\Desktop\视频\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.avi" "%USERPROFILE%\Desktop\视频\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.mov" "%USERPROFILE%\Desktop\视频\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.mkv" "%USERPROFILE%\Desktop\视频\" >nul 2>nul

:: 3. 移动图片 → 图片
move "%USERPROFILE%\Desktop\*.jpg" "%USERPROFILE%\Desktop\图片\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.png" "%USERPROFILE%\Desktop\图片\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.gif" "%USERPROFILE%\Desktop\图片\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.bmp" "%USERPROFILE%\Desktop\图片\" >nul 2>nul

:: 4. 移动压缩包 → 压缩包
move "%USERPROFILE%\Desktop\*.zip" "%USERPROFILE%\Desktop\压缩包\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.rar" "%USERPROFILE%\Desktop\压缩包\" >nul 2>nul
move "%USERPROFILE%\Desktop\*.7z" "%USERPROFILE%\Desktop\压缩包\" >nul 2>nul

:: 5. 其他所有非快捷方式文件 → 其他
for %%f in ("%USERPROFILE%\Desktop\*") do (
    if not "%%~xf"==".lnk" (
        if not exist "%USERPROFILE%\Desktop\课件\%%~nxf" (
            if not exist "%USERPROFILE%\Desktop\视频\%%~nxf" (
                if not exist "%USERPROFILE%\Desktop\图片\%%~nxf" (
                    if not exist "%USERPROFILE%\Desktop\压缩包\%%~nxf" (
                        move "%%f" "%USERPROFILE%\Desktop\其他\" >nul 2>nul
                    )
                )
            )
        )
    )
)

pause
