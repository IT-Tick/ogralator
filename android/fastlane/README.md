fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android internal

```sh
[bundle exec] fastlane android internal
```

Submit a new Beta Build to Google Play internal testing

### android internal_info

```sh
[bundle exec] fastlane android internal_info
```

Internal track currently promoted version codes and release name

### android alpha

```sh
[bundle exec] fastlane android alpha
```

Submit a new Beta Build to Google Play internal testing

### android alpha_info

```sh
[bundle exec] fastlane android alpha_info
```

alpha track currently promoted version codes and release name

### android production

```sh
[bundle exec] fastlane android production
```

Deploy a new version to the Google Play

### android info

```sh
[bundle exec] fastlane android info
```

informational lane that displays the currently promoted version codes or release name

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
