# workspace-extra

This config currently does these things, on the `rootProject`:
* applies "net.saliman.properties"
    * to make sure values from `gradle-local.properties` are read for `build.gradle` as well, not only `settings.gradle`
* adds `verifyBundle` to confirm checksum of the file fetched by `liferay.workspace.bundle.url`
    * see [gradle.properties](gradle.properties) for details 