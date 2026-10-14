@echo off
echo =======================================================================
echo [BUILD] DONG GOI THU VIEN QUADRATIC EQUATION SOLVER (JAR)
echo =======================================================================

REM Kiem tra xem may da cai dat Maven chua
where mvn >nul 2>nul
if %errorlevel% equ 0 (
    echo [INFO] Phat hien Apache Maven tren he thong. Tien hanh build va dong goi...
    call mvn clean package
    if %errorlevel% equ 0 (
        echo [SUCCESS] Dong goi thanh cong tap tin JAR tai thu muc target/
    ) else (
        echo [ERROR] Build that bai bang Maven.
    )
    goto end
)

REM Neu chua co Maven, kiem tra trinh bien dich javac
where javac >nul 2>nul
if %errorlevel% equ 0 (
    echo [INFO] Dang bien dich ma nguon bang javac truc tiep...
    if not exist out mkdir out
    javac -encoding UTF-8 -d out src/main/java/com/codegym/equation/*.java src/main/java/com/codegym/demo/*.java
    if %errorlevel% equ 0 (
        echo [INFO] Dang dong goi thanh tap tin JAR...
        if not exist dist mkdir dist
        jar cvfm dist/quadratic-equation-solver-1.0.0.jar src/main/resources/META-INF/MANIFEST.MF -C out .
        echo [SUCCESS] Dong goi thanh cong tai dist/quadratic-equation-solver-1.0.0.jar
    ) else (
        echo [ERROR] Bien dich that bai!
    )
    goto end
)

echo [WARNING] He thong chua them javac hoac mvn vao PATH.
echo [HD] Vui long cai dat JDK (Java Development Kit) hoac mo project trong IntelliJ IDEA / Eclipse de build JAR tu dong.

:end
pause
