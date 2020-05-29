# gradle-configs

Various configuration files to be used inside Liferay Workspace Gradle builds of most of the lfr-solution-desk repositories. This is the central store of the configs, so that we don't have to copy-and-paste them over and over, but just apply them by URL. 

# Available configs 

## gpr (GitHub Packages Repository)

Allows modules developed in Liferay Workspace to be published as Maven artifacts and consumed from as dependencies in another Gradle build. GitHub Packages repos hosted together with source code repos are used and the Maven repositories.  

For details, please check:
 * the sources in [gpr/src/gradle](gpr/src/gradle)
 * the tests of consuming in [gpr/src/gradleTest/gpr-consuming](gpr/src/gradleTest/gpr-consuming)
 * the tests of publishing in [gpr/src/gradleTest/gpr-publishing-local](gpr/src/gradleTest/gpr-publishing-local)

## sonar

Allows to analyze the source code of all custom modules using SonarScanner and push the data to SonarCloud / SonarQube. 

For details, please check:
 * the sources in [sonar/src/gradle](sonar/src/gradle)
 * the tests in [sonar/src/gradleTest/sonar-push](sonar/src/gradleTest/sonar-push)

## versions

**Deprecated**. This should not be used.

## workspace-extra

Adds some small pieces of convenience to your Liferay Workspace `rootProject` to make it more robust / usable.

For details, please check:
 * the sources in [workspace-extra/src/gradle](workspace-extra/src/gradle)
 * the tests in [workspace-extra/src/gradleTest/workspace-extra](workspace-extra/src/gradleTest/workspace-extra)

# Developer guide

All configs are placed under `src/gradle`, in a directory naming the configs. There is one or more `*.gradle` files inside, each being the implementation of the config.

Supported properties and their defaults should be documented in `gradle.properties` next the `*.gradle` files. 

If any other files / snippets are interesting, like a usage inside a `Jenkinsfile`, `.github/workflows/*.yml` files etc., they can be present as well.

Configuration is done using project properties, with a dedicated prefix, like `liferay.gpr.`.

## Usage in projects

In actual project, the configs are served by this GitHub repo directly, using `apply from: 'https://raw.githubusercontent.com/lfr-solution-desk/gradle-configs/...` URLs. As a result, the config file has to be self-contained - it cannot assume anything about where it will be physically located once applied. For example, it cannot load any external files by a relative path (or even absolute) path. I can, however, use files from the target Gradle project (where applied), as usual. 

The repository has to be public on GitHub. Gradle caches the response as any other remote artifact. For examples of how the configs are used, check our template repos:
 * [https://github.com/lfr-solution-desk/feature-template-repo](https://github.com/lfr-solution-desk/feature-template-repo)
 * [https://github.com/lfr-solution-desk/solution-template-repo](https://github.com/lfr-solution-desk/solution-template-repo) 

## Logging 

The configs should be logging properly (but not excessively) the useful information. Following Gradle log levels should be used:
 * `logger.quiet` - only infrequent and important messages, like a summary of some action, if possibly interesting to the user 
 * `logger.info` - regular messages; as a rule of thumb, no more than 1-5 should be generated per task 
 * `logger.debug` - anything else
 * `println` - should be avoided, this is equivalent to `logger.quiet`

Each config should prefix its message with a short key to clearly indentify from where is comes. Example:
```groovy
logger.info "[gpr] Publishing of 'sources' for ${project} will be skipped"
```

## Tests

`src/gradleTest` is used for tests of the configs. For the Gradle version(s) used for tests, see configuration of `gradleTest` in [build.gradle](build.gradle). Every config has to have at least a minimal test verifying that the config can be applied in a Liferay Workspace Gradle build (and therefore at least is parse-able).
  
## CI

GitHub Actions are used, see [.github/workflows/](.github/workflows/). `gradleTest` tests are run on every push and PR to selected branches.

## Releases

After thorough testing, not locally and and in CI, a release can be created, with a git tag like `v1.2`. Once pushed to `origin`,this will also create a Release on GitHub, which can be further updated to desccribe the released configs, if necessary.

For releases, see [https://github.com/lfr-solution-desk/gradle-configs/releases](https://github.com/lfr-solution-desk/gradle-configs/releases). 