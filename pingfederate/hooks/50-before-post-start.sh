#!/usr/bin/env sh
#
# Ping Identity DevOps - Docker Build Hooks
#
#- This is called after the start or restart sequence has finished and before 
#- the server within the container starts
#

# shellcheck source=pingcommon.lib.sh
. "${HOOKS_DIR}/pingcommon.lib.sh"

echo Hello from the server profile 50-before-post-start.sh hook!

# Do some text replacements to enable LDAP for:
# - OAuth Clients
# - OAuth Grants
# - AuthN Sessions
# These are mapped later in the /config-store API calls

sed -e "s#class=\"org.sourceid.oauth20.domain.ClientManagerXmlFileImpl\"/>#class=\"org.sourceid.oauth20.domain.ClientManagerLdapImpl\"/>#" \
    -e "s#class=\"org.sourceid.oauth20.token.AccessGrantManagerJdbcImpl\"/>#class=\"org.sourceid.oauth20.token.AccessGrantManagerLDAPPingDirectoryImpl\"/>#" \
    -e "s#class=\"org.sourceid.saml20.service.session.data.impl.SessionStorageManagerJdbcImpl\"/>#class=\"org.sourceid.saml20.service.session.data.impl.SessionStorageManagerLdapImpl\"/>#" \
    "/opt/out/instance/server/default/conf/META-INF/hivemodule.xml" > "/opt/out/instance/server/default/conf/META-INF/hivemodule.xml-modified"

mv /opt/out/instance/server/default/conf/META-INF/hivemodule.xml-modified /opt/out/instance/server/default/conf/META-INF/hivemodule.xml

# Delete bundled files so that Server Profile can apply newer ones
echo Removing bundled files
# AuthN API
echo PF AuthN API
rm -f /opt/out/instance/server/default/lib/pf-authn-api-sdk-1.0.0.48.jar
rm -f /opt/out/instance/server/default/lib/pf-authn-api-sdk-1.0.0.54.jar
rm -f /opt/out/instance/server/default/lib/pf-authn-api-sdk-1.0.0.56.jar
ls /opt/out/instance/server/default/lib/pf-authn-api-sdk-*
echo PingID IK
# PingID IK
rm -f /opt/out/instance/server/default/deploy/pf-pingid-idp-adapter-2.6.jar
rm -f /opt/out/instance/server/default/deploy/pf-pingid-quickconnection-1.0.1.jar
rm -f /opt/out/instance/server/default/deploy/PingIDRadiusPCV-2.5.0.jar
echo P14C IKs
rm -f /opt/out/instance/server/default/deploy/pf-p14c-*
# echo "##########
# "
# cat /opt/out/instance/server/default/conf/META-INF/hivemodule.xml
# echo "
# ##########"
