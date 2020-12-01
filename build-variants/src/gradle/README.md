# Build variants (build-variants)

Sometimes we want to use the custom modules in multiple DXP versions (7.2 and 7.3), so we need the build to be parametrized. This config makes that possible, by introducing the `buildVariant` project property. It's processed during evaluations of `settings.gradle` and allows us to supply different project properties to Gradle based on which DXP version is targeted. The properties for the variants can be seen in these example files:
* [buildVariants/dxp-7.2.properties](buildVariants/dxp-7.2.properties)
* [buildVariants/dxp-7.3.properties](buildVariants/dxp-7.3.properties)

Examples:
1. If you don't provide any `-PbuildVariant=` on command line, the default variant will be built (`dxp-7.2`, set in `gradle.properties`). This mimics exactly as the default workspace's behavior. Properties from [buildVariants/dxp-7.2.properties](buildVariants/dxp-7.2.properties) are loaded, overriding the ones in [gradle.properties](gradle.properties) (or gradle-local.properties) where same keys are defined.

    ``` 
    $ ./gradlew initBundle  
    $ ./gradlew deploy  
    ...
    $ bundles/tomcat-9.0.17/bin/catalina.sh run
    ```

2. If you provide a `-PbuildVariant=...` on command line, the selected variant (e.g. `dxp-7.3`) will be built. You have to choose one of defined variants ~ properties files in [buildVariants/](buildVariants/) directory. E.g. `dxp-7.3` will read from [buildVariants/dxp-7.3.properties](buildVariants/dxp-7.3.properties), which will then amend or override the properties defined the usual way.

For 7.3, the configs from `configs-7.3` directory are copied into the bundle. `initBundle` creates the directory named `bundles-7.3`, this way 7.2 and 7.3 bundles can be initialized side by side. If you wan to also run these side by side, you'd have to adjust the Tomcat ports to prevent conflicts.

    ``` 
    $ ./gradlew initBundle -PbuildVariant=dxp-7.3
    $ ./gradlew deploy -PbuildVariant=dxp-7.3
      ...
    $ bundles-7.3/tomcat-9.0.37/bin/catalina.sh run