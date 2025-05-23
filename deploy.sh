#!/bin/bash
if [ ! -f /usr/local/bin/govc ]; then
	# extract govc binary to /usr/local/bin
	curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | tar -C /usr/local/bin -xvzf - govc
fi

# set govc environment
if [ -f export.sh ]; then
	source export.sh
	if grep "export.sh" ".gitignore" >/dev/null 2>&1; then
		:
	else
		echo export.sh >>.gitignore
	fi
else
	echo "missing export.sh"
	exit 2
fi

# test if govc works
#govc tree

# delete current vm
govc vm.destroy sl-micro.x86_64-6.1

# import ova
govc import.ova -options=deploy.json -folder=Kubernetes image/SL-Micro.x86_64-6.1.ova
