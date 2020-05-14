# GitHub Packages repository (gpr)

These two configs cover using with GitHub Packages being used as a Maven repo for sharing artifacts between repos.

## gpr-publishing.gradle

This config should be applied to every project in your Liferay Worskpace which wants its custom modules to be shared, be it modules, themes or wars, as Maven artifacts uploaded to the Maven repository hosted by GitHub for every source code repository.
 
## Default behavior

Apply the config only to the projects you want to publish. You can use various Gradle constructs to do this, for example from `[root]/build.gradle`:
```
subprojects {
    if (!childProjects) {                     
        if (!project.name.contains("-test") {
            "https://raw.githubusercontent.com/lfr-solution-desk/gradle-configs/v0.3/src/gradle/gpr/gpr-publishing.gradle"
        }
    }
}
```

If you only want to publish a subset of your projects in Gradle, filter the undesirable projects out -- simply don't apply the config to the undesirable projects.

**Note**: If you apply the config to a non-leaf project in a typical Liferay Workspace, a POM-only will be published for the project, so make sure to check using something like `!childProjects` before applying.

The default behaviour is following (suited for Solution Desk repositories):
* common `groupId` (`com.liferay.soldesk.<repo-name>`) used for all published modules, 
* long `artifactId` is used (not just `project.name` as usual)
    * making it unique across all the repos and beyond (`com.liferay.soldesk.<repo-name>.<module-name>`)  
* the same version for all modules 
    * being the version of the `rootProject` when the build is started

SNAPSHOT artifacts are published by default, the version of `rootProject` has `-SNAPSHOT` appended in each module's pom.xml being used for the publication.  

Sources and Javadoc are published when both of these are satisfied:
* given module supports it (it's a Java-based module); and
* a RELEASE is being published
    * GitHub Packages has a limitation where it present re-upload or a SNAPSHOT artifact when -sources or -javadoc were previously uploaded for the same SNAPSHOT version.  
 
The behavior of the actuall configiguration being applied can be changed via supported configuration properties, which must be set _before_ the config is applied. See below for supported properties. 
 
### Supported configuration properties

Various project properties prefixed with `liferay.gpr.publishing.` can be used to configure how the config will be applied. For details, please check [gradle.properties](gradle.properties), the _GPR Publishing_ section.

All these are read on per-project basis, because of the default Gradle behavior, properties are inherited from any parent project(s) up to the root project. So for individual subproject, you can use `[root]/modules/form-api/gradle.properties` to set any of the properties to apply to just that one module. You can also use any other supported way to set project project properteis in gradle, like setting them via CLI (`-P`), `[root]/gradle.properties` or even an init script. Simply whatever Gradle supports.
 
### GitHub Actions

Publishing should really be done in CI, where every aspect of the runtime environment is controlled and trackable. For using GitHub Actions, you can check the recommended workflow files in [.github/workflows](.github/workflows). Put then into the root of your repository and GitHub will pick them up and registed as GitHub Actions once pushed to server.

You can easily convert these into e.g. a `Jenkinsfile` if you want, it's only a matter of invoking the Gradle build on certain events occurring in the repository and passing some GitHub credentials (with "packages:write") to the build.  
 
## gpr-consuming.gradle

This config should be applied on the root project of your Liferay Workspace:
```
// build.gradle
apply from: "https://raw.githubusercontent.com/lfr-solution-desk/gradle-configs/v0.3/gpr/gpr-consuming.gradle"
```                                                                         

On every project in the build, including the root project itself (`allprojects { ... }`), it adds the Maven repositories pointing to GitHub Packages repos being used by the declared dependencies of every configuration, so that they can be fetched. 

### Supported configuration properties

Various project properties prefixed with `liferay.gpr.consuming.` can be used to configure how the config will be applied. All these have to be set on the root project (where the config is applied), for example by setting them via CLI (`-P`), gradle.properties or even an init script. Simply whatever Gradle supports. 

For details, please check [gradle.properties](gradle.properties), the _GPR Consuming_ section.