# Vortex 2

## Prerequisite

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Chrome

## Release

```
$ flutter build web
$ rm -rf docs/web
$ cp -r build/web docs/
$ sed -i 's/<base\ href="\/">/<base\ href="\/vortex2\/web\/">/g' docs/web/index.html
```
