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

## Manual Deployement

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

   - To publish to prodcution:

    ```bash
    fastlane deploy
    ```
