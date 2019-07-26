#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p ~/.kube/
mkdir -p ~/.tools/completions/
mkdir -p ~/.bash_completion.d/
sudo cp /etc/kubernetes/admin.conf ~/.kube/config

USER=$(whoami)
GROUP=$(id -gn)
sudo chown ${USER}:${GROUP} ~/.kube/config

wget -q https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases -O ~/.kubectl_aliases

LINE="source ~/.kubectl_aliases"
grep -qxF "$LINE" ~/.bashrc || echo ${LINE} >> ~/.bashrc

wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O ~/.tools/kubectx
wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O ~/.tools/kubens

chmod +x ~/.tools/kubectx
chmod +x ~/.tools/kubens

PATH_LINE="PATH=\$PATH:~/.tools/"
grep -qxF "$PATH_LINE" ~/.bashrc || echo ${PATH_LINE} >> ~/.bashrc

sudo apt-get update
sudo apt-get install -y pkgconf bash-completion

cat >~/.bash_completion <<EOL
for bcfile in ~/.bash_completion.d/* ; do
  . \$bcfile
done
EOL

wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash -O ~/.bash_completion.d/kubectx
wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash -O ~/.bash_completion.d/kubens

BASH_COMPLETION_LINE="if [ -f /etc/bash_completion ] && ! shopt -oq posix; then . /etc/bash_completion; fi"
grep -qxF "$BASH_COMPLETION_LINE" ~/.bashrc || echo ${BASH_COMPLETION_LINE} >> ~/.bashrc

KUBECTL_BASH_COMPLETION_LINE="source <(kubectl completion bash)"
grep -qxF "$KUBECTL_BASH_COMPLETION_LINE" ~/.bashrc || echo ${KUBECTL_BASH_COMPLETION_LINE} >> ~/.bashrc

sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

echo "Now do source ~/.bashrc"
