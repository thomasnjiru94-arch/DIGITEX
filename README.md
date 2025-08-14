# DIGITEX (romantic build)

This repo is ready for GitHub Actions to build an **Android debug APK** without local Android setup.

## How to use (web upload)

1. Create a new repo named **DIGITEX** in your GitHub account.
2. Upload all files/folders from this ZIP (keep the structure).
3. Go to **Actions** → the workflow will run automatically (or click “Run workflow”).
4. After it finishes, download the artifact **digitex-debug-apk** → `app-debug.apk`.

> The workflow creates the Android platform via `flutter create` and then overwrites the pubspec with the DIGITEX config, fetches packages, and builds the APK.

### Notes
- This is a UI scaffold to let you produce an APK quickly. You can expand features (auth, OTP, geofence, calls) later.
- To build release-signed AAB/APK later, add a new workflow with signing steps and secrets.
