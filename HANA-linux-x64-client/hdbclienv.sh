#!/bin/bash
#
echo "**********************************************************************"
echo "Copyright (c) SAP SE or an SAP affiliate company. All rights reserved."
echo "**********************************************************************"
echo
#
# Change this path if you move the HANA client directory
#
HDB_CLIENT_HOME=/opt/sap/client
export HDB_CLIENT_HOME

PATH="${HDB_CLIENT_HOME}:${PATH:-}"
export PATH

HDBDOTNETCORE=${HDB_CLIENT_HOME}/dotnetcore
export HDBDOTNETCORE

HDB_CLIENT_SOEXT=".so"

if [[ "${OSTYPE}" == darwin* ]]; then
    MACVER=`sw_vers -productVersion`
    MACSUBVER=${MACVER%.*}
    if (( $(echo "$MACSUBVER >= 10.11" |bc -l) )); then
        command -v csrutil >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            if [[ `csrutil status` = *enabled* ]]; then
                echo "WARNING: System Integrity Protection is enabled, DYLD_LIBRARY_PATH is disabled"
                echo
            fi
        fi
    elif (( $(echo "$MACSUBVER >= 10.15" |bc -l) )); then
        echo "WARNING: Running macOS Catalina (10.15) or higher, DYLD_LIBRARY_PATH is disabled"
    fi
    DYLD_LIBRARY_PATH="${HDB_CLIENT_HOME}:${DYLD_LIBRARY_PATH:-}"
    export DYLD_LIBRARY_PATH
    HDB_CLIENT_SOEXT=".dylib"
else
    LD_LIBRARY_PATH="${HDB_CLIENT_HOME}:${LD_LIBRARY_PATH:-}"
    export LD_LIBRARY_PATH
fi

#
# Check for an SAP CommonCryptoLib installation (preferred)
# See: https://help.sap.com/viewer/8e208b44c0784f028b948958ef1d05e7/latest/en-US/463d3ceeb7404eca8762dfe74e9cff62.html
#
if [[ -f "${HDB_CLIENT_HOME}/libsapcrypto${HDB_CLIENT_SOEXT}" ]]; then
  if [[ ! -f "${HDB_CLIENT_HOME}/sapcli.pse" ]]; then
      echo "  WARNING: ${HDB_CLIENT_HOME}/sapcli.pse does not exist! Please run:"
      echo
      echo "   \"${HDB_CLIENT_HOME}/sapgenpse\" gen_pse -p \"${HDB_CLIENT_HOME}/sapcli.pse\""
      echo
      echo "  to create a CommonCryptoLib client encryption keystore. Accept the defaults,"
      echo "  do not provide a PIN, and use \"CN=Client 001\" as the Distinguished Name."
      echo "  After creating the keystore, import the public certificate of the Certificate"
      echo "  Authority for the HANA server you are connecting to:"
      echo
      echo "   \"${HDB_CLIENT_HOME}/sapgenpse\" maintain_pk -p \"${HDB_CLIENT_HOME}/sapcli.pse\" -a public-ca-cert.crt"
      echo
      echo "  When connecting to an SAP HANA Cloud or SAP HANA Service cloud instance, import the"
      echo "  'DigiCert Global Root CA' certificate from:"
      echo
      echo "    https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt"
      echo
  fi
  SECUDIR="${HDB_CLIENT_HOME}"
  export SECUDIR
fi

