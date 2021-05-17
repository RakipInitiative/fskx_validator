# fskx_validator
Service for validating FSKX files

## Configuration
The application requires a configuration file named *fskx_validator.properties* with settings needed for execution. This file can be either located at the user folder or at `CATALINA_HOME` (KNIME Server). In case both locations have the file, the file at the user folder takes precedence.

### How to find CATALINA_HOME
The environment variable `CATALINA_HOME` holds the path to the base directory of a Catalina environment. This can be checked when running the KNIME Server at the beginning. For example when running the startup script of the KNIME server or doing catalina run:

```
Using CATALINA_BASE:   /Applications/KNIME Server/apache-tomee-plus-7.0.5
Using CATALINA_HOME:   /Applications/KNIME Server/apache-tomee-plus-7.0.5
Using CATALINA_TMPDIR: /Applications/KNIME Server/apache-tomee-plus-7.0.5/temp
Using JRE_HOME:        /Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home
Using CLASSPATH:       /Applications/KNIME Server/apache-tomee-plus-7.0.5/bin/bootstrap.jar:/Applications/KNIME Server/apache-tomee-plus-7.0.5/bin/tomcat-juli.jar
Tomcat started.
```

### Contents of the file

The *fskx_validator.properties* is a simple Java properties file with the following keys:
* `base_url`: Url to application.
* `context`: Path of the application if deployed under an application container. For example for https://knime.bfr.berlin/fskx_validator the context is `fskx_validator`. This can be omitted for local applications not running in a container.

Example fskx_validator.properties file:
```
base_url=http://localhost:8080/
context=fskx_validator
```