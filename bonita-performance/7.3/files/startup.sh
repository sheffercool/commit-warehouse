#!/bin/bash
# ensure to set the proper owner of data volume
if [ `stat -c %U /opt/bonita/` != 'bonita' ]
then
	chown -R bonita:bonita /opt/bonita/
fi
# ensure to apply the proper configuration
if [ ! -f /opt/${BONITA_VERSION}-configured ]
then
	gosu bonita /opt/files/config.sh \
      && gosu bonita /opt/bonita/BonitaBPMSubscription-${BONITA_VERSION}-Tomcat-${TOMCAT_VERSION}/setup/setup.sh init \
      && touch /opt/${BONITA_VERSION}-configured || exit 1
fi
if [ -d /opt/custom-init.d/ ]
then
	for f in /opt/custom-init.d/*.sh
	do
		[ -f "$f" ] && . "$f"
	done
fi
# launch tomcat
exec gosu bonita /opt/bonita/BonitaBPMSubscription-${BONITA_VERSION}-Tomcat-${TOMCAT_VERSION}/bin/catalina.sh run
