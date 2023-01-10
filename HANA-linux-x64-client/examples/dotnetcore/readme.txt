# ***************************************************************************
# Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
# ***************************************************************************
These examples are intended to be used with the SAP HANA .NET Core provider.

The .NET Core SDK 2.1 or higher must be installed prior to building the examples.

Steps to build the examples:

1. Set the environment variable HDBDOTNETCORE to the client install directory
   containing the "dotnetcore" driver (containing libadonetHDB.so / .dylib / .dll or libadonetHDB32.dll):

   Linux / MacOS X:   export HDBDOTNETCORE=/usr/sap/hdbclient/dotnetcore
   Windows:           set "HDBDOTNETCORE=C:\Program Files\SAP\hdbclient\dotnetcore"

   Alternatively, run the environment script, included with the full HANA client install:

   Linux / MacOS X:    . /usr/sap/hdbclient/scripts/hdbclienv.sh
   Windows:            "C:\Program Files\SAP\hdbclient\scripts\hdbclienv.bat"

2. Change directories to the Example you wish to run:

   Linux / MacOS X:   cd /usr/sap/hdbclient/dotnetcore/Example1
   Windows:           cd "C:\Program Files\SAP\hdbclient\dotnetcore\Example1"

3. Edit the Example1.csproj file to verify the version of the .NET Core SDK being used.
   By default, the examples target the .NET Core 2.1 framework.

        <TargetFramework>netcoreapp2.1</TargetFramework>

   This can be changed to target higher .NET Core runtime versions, such as 3.1:

        <TargetFramework>netcoreapp3.1</TargetFramework>

4. Run the project file in the directory to build and run the Example with dotnet:

   dotnet run --project Example1.csproj
