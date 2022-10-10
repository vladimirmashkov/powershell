# https://superuser.com/questions/1296024/windows-ssh-permissions-for-private-key-are-too-open
# GUI:
# [File] Properties → Security → Advanced
#     Owner: The key's user
#     Permission Entries: Remove all except for the key's user
#     Set key's user to Full Control

# Set Key File Variable:
New-Variable -Name Key -Value "$env:UserProfile\.ssh\id_rsa"

# Remove Inheritance:
  Icacls $Key /c /t /Inheritance:d

# Set Ownership to Owner:
  # Key's within $env:UserProfile:
    Icacls $Key /c /t /Grant ${env:UserName}:F

   # Key's outside of $env:UserProfile:
     TakeOwn /F $Key
     Icacls $Key /c /t /Grant:r ${env:UserName}:F

# Remove All Users, except for Owner:
  Icacls $Key /c /t /Remove:g Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

# Verify:
  Icacls $Key

# Remove Variable:
  Remove-Variable -Name Key