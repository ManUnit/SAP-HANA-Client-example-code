# ***************************************************************************
# Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
# ***************************************************************************
These examples are intended to be used with the SAP HANA .NET ADO.NET Framework provider.

Steps to build the examples:

1. Install Visual Studio (2010 and up supported)

2. Install the SAP ADO.NET Provider using the "ado.net\v4.5\SetupNet.v4.5.exe -install" utility,
   if not already installed with the full HANA Client Install

3. If necessary, set the environment variable HDBADONET to the client install directory
   containing the matching libadonetHDB.dll or libadonetHDB32.dll:

   GUI:
       * Control Panel > System and Security > System
       * Advanced system settings
       * Environment Variables...
       * (User or System Level) New...
       * Variable Name: HDBADONET, Variable Value: C:\Program Files\SAP\hdbclient\ado.net
       * OK

   Command Line:
       set "HDBADONET=C:\Program Files\SAP\hdbclient\ado.net"

4. In a Visual Studio Command Prompt, change directories to the DemoSetup example:

   cd "C:\Program Files\SAP\hdbclient\examples\ADO.NET\DemoSetup"

5. Run msbuild:

   msbuild /p:Configuration=Release /p:Platform="Any CPU" DemoSetup.sln

6. Run the DemoSetup project:

   bin\Release\DemoSetup.exe

7. * Change the connection string to match you HANA installation
   * "Connect" to your HANA server, "Create demo objects", and finally "Disconnect"
   * Close the application

8. Back in the Visual Studio Command Prompt, change directories to another example:

   cd "C:\Program Files\SAP\hdbclient\examples\ADO.NET\TableViewer"

9. Run msbuild:

   msbuild /p:Configuration=Release /p:Platform="Any CPU" TableViewer.sln

10. Run the example:

   bin\Release\TableViewer

11. Change the connection string to match your HANA installation, "Connect" and use the example

