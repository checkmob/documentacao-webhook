@echo off
echo Verificando a instalacao do Python...
echo.

python --version
if %errorlevel% neq 0 (
    echo Python nao encontrado!
    echo.
    echo Por favor, siga estes passos:
    echo 1. Baixe o Python em: https://www.python.org/downloads/
    echo 2. Durante a instalacao, MARQUE a opcao "Add Python to PATH"
    echo 3. Reinicie o computador
    echo 4. Execute este script novamente
    echo.
    pause
    exit
)

echo.
echo Python encontrado! Instalando MkDocs e dependencias...
echo.

python -m pip install --upgrade pip
python -m pip install mkdocs
python -m pip install mkdocs-material

echo.
echo Instalacao concluida!
echo.
echo Para iniciar a documentacao, execute o arquivo 'iniciar-docs.bat'
echo.
pause 