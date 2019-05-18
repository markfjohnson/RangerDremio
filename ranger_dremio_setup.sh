#!/usr/bin/env bash
#TODO Make certain the keys are correct in ranger
# Setup the credentials files
#TODO is it possible to specify the FQDN for the first and last name of the ticket
sudo hadoop credential create sslKeyStore -value xasecure -provider localjceks://file/rangeradmin_keystore.jceks
sudo hadoop credential create sslTrustStore -value xasecure -provider localjceks://file/rangeradmin_truststore.jceks

cd /etc/ranger/admin
sudo keytool -genkey -keyalg RSA -alias rangeradmin -keystore rangeradmin_keystore.jks -storepass xasecure -validity 360 -keysize 2048
sudo chown ranger:ranger rangeradmin_keystore.jks
sudo chmod 400 rangeradmin_keystore.jks


# Only Hive plugin required to work with dremio
cd /etc/hive/conf
sudo keytool -genkey -keyalg RSA -alias rangerplugin -keystore ranger-plugin-keystore.jks -storepass xasecure -validity 360 -keysize 2048
sudo chown ranger:ranger ranger-plugin-keystore.jks
sudo chmod 400 ranger-plugin-keystore.jks

cd /etc/ranger/admin/conf
sudo keytool -export -keystore ranger-admin-keystore.jks -alias rangeradmin -file rangeradmin.cer -storepass xasecure
sudo keytool -import -file rangeradmin.cer -alias rangeradmin -keystore ranger-plugin-truststore.jks -storepass xasecure

cd /etc/hive/conf
sudo keytool -export -keystore ranger-plugin-keystore.jks -alias rangerplugin -file rangerplugin.cer -storepass xasecure
sudo keytool -import -file rangerplugin.cer -alias hiverangerplugin -keystore /etc/ranger/admin/conf/ranger-admin-truststore.jks -storepass xasecure



##
xasecure.policymgr.clientssl.keystore=/etc/hive/conf/ranger-plugin-keystore.jks
xasecure.policymgr.clientssl.keystore.password=xasecure
xasecure.policymgr.clientssl.truststore=/etc/hive/conf/ranger-plugin-truststore.jks
xasecure.policymgr.clientssl.truststore.password=xasecure
##

java-home/bin/keytool -genkey -alias ranger -keyalg RSA -keypass hadoop -storepass hadoop -keystore keystore.jks

hadoop credential create ssl.server.keystore.password -value hadoop -provider localjceks://credentials_keystore.jceks
hadoop credential create sslTrustStore -value hadoop -provider localjceks://credentials_truststore.jceks
keytool -genkey -keyalg RSA -alias rangeradmin -keystore ranger_keystore.jks -storepass hadoop -keysize 2048 -validity 30

keytool -export -alias rangeradmin -keystore ranger_keystore.jks -file ranger_keystore.cer
keytool -import -file ranger_keystore.cer -alias rangeradmin -keystore ranger_keystore.jks -storepass hadoop


https://dremio.atlassian.net/wiki/spaces/PSPE/pages/280592546/How+to+enable+Dremio+Ranger+SSL+Kerberos

hadoop credential create sslKeyStore -value hadoop --provider localjceks://credentials_keystor.jceks

keytool -genkey -keyalg RSA -alias ranger-admin -keystore rangeradmin.jks -storepass reflection -validity 360 -keysize 2048