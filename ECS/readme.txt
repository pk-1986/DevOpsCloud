# Download latest Copilot
curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-$(uname -s)-$(uname -m)

# Make it executable
chmod +x copilot

# Move to PATH
sudo mv copilot /usr/local/bin/copilot


================================

Invoke-WebRequest "https://github.com/aws/copilot-cli/releases/latest/download/copilot-windows.exe" -OutFile "copilot.exe"
Move-Item -Path ".\copilot.exe" -Destination "C:\Program Files\copilot.exe"

=========================================
copilot --version

=======================
copilot init

=======================
copilot deploy

===================
copilot svc status

copilot svc show

============

copilot env init --name prod --profile default --region ap-south-1
copilot deploy --env prod

