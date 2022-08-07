# Ogralator

## Flutter version

This project uses [FVM](https://fvm.app/) to control Flutter version.

To install FVM:

```bash
dart pub global activate fvm
```

To use the correct flutter version:

```bash
fvm use
```

## Ruby version

For deployment to Android and iOS, this app uses [fastlane](https://docs.fastlane.tools/) which requires [Ruby](https://www.ruby-lang.org/) to be installed.

This project uses [RVM](https://rvm.io/) to control Ruby version. To isntall RVM:

- macOS or Linux: Follow [official documentation](https://rvm.io/rvm/install)
- Windows: If official documentation doesn't work, try following [this Gist](https://gist.github.com/kirkelifson/2611affe02ce56ae6b04)

Github actions run on linux system, so it's important to make sure `x86_64-linux` platfor is supported by running:

```bash
bundle lock --add-platform x86_64-linux
```

## Upgrade app version

You can upgrade app version and build number automatically by running:

```bash
sh create-release.sh
```

The script determines the new version using git conventional commits as:
- `BREAKING CHANGE`: increase major version
- `feat`: increase minor version
- `fix` and `perf`: increase patch version

Build number is always increased automatically.

The script will:
- Update `pubspec.yaml` version
- Update `CHANGELOG.md`
- Add fastlane android change log
- Commit to git
- Create a new tag with the version number

## Android Deployment

Resources used for creating deployment pipeline:
- [Flutter release guild](https://docs.flutter.dev/deployment/android)
- [Medium article](https://medium.com/scalereal/automate-publishing-app-to-the-google-play-store-with-github-actions-fastlane-ac9104712486).

Secret files needed:
- `upload-keystore.jks`
- `key.properties`
- `play_config.json`

### Manual Deployement

To manually deploy the application:

1. Install [Ruby](https://www.ruby-lang.org/)
2. Install [fastlane](https://docs.fastlane.tools/):

  ```bash
  gem install fastlane -NV
  ```

3. Go to `/android` folder `cd ./android`
4. Add secret files:
  - `play_config.json`
  - `upload-keystore.jks`
  - `key.properties`
5. Publish to Google Play
  - To publish to internal testing:

    ```bash
    fastlane internal
    ```

  - To publish to alpha testing:

    ```bash
    fastlane alpha
    ```

  - To publish to prodcution:

    ```bash
    fastlane production
    ```

### Auto-Deployment

Automatic deployment is just running `fastlane` deployment commands on Github actions.

### Workflows available

- Pre-release:
  - On `master` branch
  - Create a development build
  - Release on Github as "Pre-release"
  - Automatically create `latest` tag
- Tagged Release
  - On `v*` tags
  - Release on Github
  - Release on Alpha track on Play Store
- Production Release
  - Dispatched manually
  - Release on production track on Play Store
  - Promote Alpha to Production

#### Setup Github Secrets
1. For each of the secret files:

  - `play_config.json`
  - `upload-keystore.jks`
  - `key.properties`

  create a base64 version of them using:

  ```bash
  base64 -i play_config.json > play_config.json.b64
  ```

  or by running:

  ```bash
  sh generate-secrets.sh
  ```

2. Add each file content to its corresponding repository secret in Github:

   - `PLAY_CONFIG_JSON`
   - `UPLOAD_KEYSTORE_KJS`
   - `KEY_PROPERTIES`


