# Expand-WebArchive

A simple cmdlet that allows to expand downloaded ZIP archives (or anything the built-in `Expand-Archive` cmdlet understands) without leaving the archive behind.

Example usage:

```PowerShell
Expand-WebArchive -Uri https://cmake.org/files/v3.10/cmake-3.10.0-win64-x64.zip -DestinationPath ~/Downloads/Kitware/CMake
```