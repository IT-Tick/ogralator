# Ogralator

## Flutter version

This project uses [FVM](https://fvm.app/) to control flutter version.

To install FVM:

```bash
dart pub global activate fvm
```

To use the correct flutter version:

```bash
fvm use
```

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

#### Setup Github Secrets
1. For each of the secret files:

   - `play_config.json`
   - `upload-keystore.jks`
   - `key.properties`

   create a base64 version of them using:

   ```bash
   base64 -i play_config.json > play_config.json.b64
   ```

2. Add each file content to its corresponding repository secret in Github:

   - `PLAY_CONFIG_JSON`
   - `UPLOAD_KEYSTORE_KJS`
   - `KEY_PROPERTIES`


