# GitHub Packages repository (gpr)

These two configs cover using with GitHub Packages being used as a Maven repo for sharing artifacts between repos.

## gpr-publishing.gradle

This config should be applied to a project which want to share its custom modules, themes or wars as Maven artifacts uploaded to the Maven repository hosted on GitHub
 
## Default behavior

Suited for Solution Desk repositories. All custom modules, themes and wars are published with: 
* common `groupId` (`com.liferay.soldesk.<repo-name>`), 
* long `artifactId`, making it unique across all the repos and beyond (`com.liferay.soldesk.<repo-name>.<module-name>`)  
* the same version for all modules 
    * being the version of the `rootProject` when the build is started

SNAPSHOT artifacts are published by default, the version of `rootProject` has `-SNAPSHOT` appended in eahc module's pom.xml being used for the publication.  

Sources and Javadoc are published when both of these are satisfied:
* given module supports it (it's a Java-based module); and
* a RELEASE is being published
    * GitHub Packages has a limitation where it present re-upload or a SNAPSHOT artifact when -sources or -javadoc were previously uploaded for the same SNAPSHOT version.  
 
### Supported configuration properties

Various project properties prefixed with `liferay.gpr.publishing.` can be used to configure how the config will be applied. All these have to be set on the root project (where the config is applied), for example by setting them via CLI (`-P`), gradle.properties or even an init script. Simply whatever Gradle supports. 

For details, please check [gradle.properties](gradle.properties), the _GPR Publishing_ section.
 
### GitHub Actions

Publishing should really be done in CI, where every acpect of the runtime environment is controlled and trackable. For using GitHub Actions, you can check the recocmmended workflow files in [.github/workflows](.github/workflows). Put then into the root of your repository and GitHub will pick them up and registed as GitHub Actions oncce pushed to server.

You can easily convert these into e.g. a Jenkinsfile if you want, it's only a matter of invoking the Gradle build on certain events occuring in the repository.  
 
## gpr-consuming.gradle

TODO

### Supported configuration properties

Various project properties prefixed with `liferay.gpr.consuming.` can be used to configure how the config will be applied. All these have to be set on the root project (where the config is applied), for example by setting them via CLI (`-P`), gradle.properties or even an init script. Simply whatever Gradle supports. 

For details, please check [gradle.properties](gradle.properties), the _GPR Consuming_ section.