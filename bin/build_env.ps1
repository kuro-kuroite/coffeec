iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop install git

# scoop_command="function scoop() {  powershell -ex unrestricted scoop.ps1 \"\$@\" ;} && export -f scoop"
$scoop_command="function scoop() {  powershell -ex unrestricted scoop.ps1 `"$@`" ;} && export -f scoop"
echo ${scoop_command} >> ~/.bashrc
# source ~/.bashrc

# FIXME: nvm で最新のnode version を有効化する方法
# scoop install nvm 
# nvm install latest
# nvm use vX.X.X
# node -v
scoop install nodejs

scoop install gcc
