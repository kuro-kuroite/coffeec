set-executionpolicy unrestricted -s cu

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop install git

# scoop_command="function scoop() {  powershell -ex unrestricted scoop.ps1 \"\$@\" ;} && export -f scoop"
$scoop_command="function scoop() {  powershell -ex unrestricted scoop.ps1 `"$@`" ;} && export -f scoo
p"
echo ${scoop_command} >> ~/.bashrc
# source ~/.bashrc

scoop install nvm
nvm install && node -v

scoop install gcc
