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

# Remove anything from the /work folder
# Keeps the Admin node clean if restarted
echo Cleaning work folder
rm -rf /opt/out/instance/work/*

# Delete bundled files so that Server Profile can apply newer ones
echo Removing bundled files
# AuthN API
echo PF AuthN API
rm -f /opt/out/instance/server/default/lib/pf-authn-api-sdk-1.0.0.71.jar
echo PingID IK
# PingID IK
rm -f /opt/out/instance/server/default/deploy/pf-pingid-idp-adapter-2.6.jar
rm  -f /opt/out/instance/server/default/deploy/PingIDRadiusPCV-2.9.0.jar
rm  -f /opt/out/instance/server/default/deploy/pf-pingid-quickconnection-1.0.1.jar
rm  -f /opt/out/instance/server/default/deploy/pf-pingid-idp-adapter-2.10.jar
# P1
rm -f /opt/out/instance/server/default/deploy/pf-pingone-datastore-2.2.2.jar
rm -f /opt/out/instance/server/default/deploy/pf-pingone-quickconnection-2.2.2.jar
# P1 MFA
rm -f /opt/out/instance/server/default/deploy/pf-pingone-mfa-adapter-2.1.jar
# P1 Risk
rm -f /opt/out/instance/server/default/deploy/pf-pingone-risk-management-adapter-1.2.1.jar
# Agentless
rm -f /opt/out/instance/server/default/deploy/pf-referenceid-adapter-2.0.3.jar
# P1 Verify
rm -f /opt/out/instance/server/default/deploy/pf-pingone-verify-adapter-2.1.jar
# DaVinci
rm -f /opt/out/instance/server/default/deploy/pf-pingone-davinci-adapter-1.0.1.jar