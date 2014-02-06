@echo off

echo ------------------------------------
echo Cleaning workspace
echo ------------------------------------

del PeachyToolChain-*.zip
REM TODO JT 2014-02-04 - Should clean the workspace

echo ------------------------------------
echo Extracting Git Revision Number
echo ------------------------------------

REM TODO JT 2014-02-04 - Should extract the sematic file to  common place

set SEMANTIC=0.0.1a
IF NOT DEFINED GIT_HOME (
  git --version
  IF ERRORLEVEL 0 (
    set GIT_HOME=git
  ) ELSE (
    echo Could not find git.
    pause
    REM exit 1
  )
)

for /f "delims=" %%A in ('%GIT_HOME% rev-list HEAD --count') do set "GIT_REV_COUNT=%%A"
for /f "delims=" %%A in ('%GIT_HOME% rev-parse HEAD') do set "GIT_REV=%%A"

set VERSION=%SEMANTIC%.%GIT_REV_COUNT%
echo Version: %VERSION%
echo # THIS IS A GENERATED FILE  > version.properties
echo version='%VERSION%' >> version.properties
echo revision='%GIT_REV%' >> version.properties
echo Git Revision Number is %GIT_REV_COUNT%
copy version.properties src/VERSION.py

echo ------------------------------------
echo Running Tests
echo ------------------------------------

python test/test.py
IF NOT ERRORLEVEL 0 (
    echo FAILED TESTS ABORTING
    REM exit 1
)

echo ------------------------------------
echo Making files
echo ------------------------------------

make

echo ------------------------------------
echo Create Peachy Tool Chain archive
echo ------------------------------------

7za a -tzip PeachyToolChain-%VERSION%.zip README.md
7za a -tzip PeachyToolChain-$VERSION.tar licence.txt
7za a -tzip PeachyToolChain-$VERSION.tar src/
7za a -tzip PeachyToolChain-$VERSION.tar doc/
7za a -tzip PeachyToolChain-$VERSION.tar models/
7za a -tzip PeachyToolChain-$VERSION.tar audio_test_files/
7za a -tzip PeachyToolChain-$VERSION.tar bin/*.bat