$helmPath = "C:\helm"  # Replace with your actual path
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$helmPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$helmPath", "User")
}