#!/bin/bash
#
#	# make_script.sh cal.sh
#
cd /root/bin
cat <<'EOF' > $1
#!/bin/bash



EOF

chmod +x /root/bin/*.sh

