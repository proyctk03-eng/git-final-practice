@echo off
echo =======================================================================
echo [RUN] CHAY UNG DUNG MINH HOA THU VIEN QUADRATIC EQUATION SOLVER
echo =======================================================================

if exist target\quadratic-equation-solver-1.0.0.jar (
    java -jar target\quadratic-equation-solver-1.0.0.jar
    goto end
)

if exist dist\quadratic-equation-solver-1.0.0.jar (
    java -jar dist\quadratic-equation-solver-1.0.0.jar
    goto end
)

echo [INFO] Chua tim thay tap tin JAR da build. Vui long chay build.bat truoc.
:end
pause
