# Sonar

This config allows your custom modules in Liferay Workspace to be analyzed by SonarScanner and push the data into a remote Sonar server, like SonarCloud or SonarQube. The conffig was created based on:
* https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-gradle/
* https://github.com/SonarSource/sonar-scanner-gradle

## Usage in a project

1. Apply the config from your `rootProject`.
2. Set up all the mandatory properties, see [gradle.properties](gradle.properties), in your properties file(s) or pass it to the build inside a CI job.

## Supported configuration properties

Please check [gradle.properties](gradle.properties).

## CI integration

### Jenkins

Please check [Jenkinsfile](Jenkinsfile) -> `Quality Analysis` for the sample snippet. Make sure to create the `sonarcloud` credentials, with your token being the secret text, before running the pipeline.

### GitHub Actions

Please check [.github/workflows/main.yml](.github/workflows/main.yml) -> `sonarcloud`. Make sure to have the `SONAR_TOKEN` secret available to the workflow, either from the repo itself of shared from its organization on GitHub.

## Customizations

These are just some basic examples, details can be found in the SonarScanner docs:
* https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-gradle/
* https://github.com/SonarSource/sonar-scanner-gradle

### Skipping selected subproject

If you don't want a particular project (or projects) analyzed using SonarCloud, you can use following snippet in project's `build.gradle`:
```groovy   
// build.gradle

sonarqube {
    skipProject = true
}
```

You can configure this for multiple projects using some supported Gradle construct, like a filter 
on `subprojects` etc. 

### Adding custom sources dir to be analyzed for a project

```groovy 
// build.gradle
sonarqube {
    properties {
        properties['sonar.sources'] += 'src/other/java'   
    }
}
```   

Make sure you don't add overlapping directories: if `src/main/java` is already set to be analyzed (which is by default for any 'java' project detected), you cannot for example add `src` or `src/main`. You'd need to first remove the `src/main/java` entry from `sonar.sources` and then add its parent directory to the list.

### Adding custom tests dir to be used (for coverage etc) for a project

```groovy 
// build.gradle
sonarqube {
    properties {
        properties['sonar.tests'] += 'src/testCustom/java'   
    }
}
```     

Same restriction as for `sonar.sources` mentioned above applies: entries cannot overlap (e.g. `src/test/java` and `src/test` cannot be configured together). 