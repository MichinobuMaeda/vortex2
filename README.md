# Vortex 2

## Demo

http://pages.michinobu.jp/vortex2

## Prerequisite

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Chrome

## Local

```
$ git clone git@github.com:MichinobuMaeda/vortex2.git
$ flutter run -d chrome
```

## Release

```
$ flutter build web
$ rm -rf docs/web
$ cp -r build/web docs/
$ sed -i 's/<base\ href="\/">/<base\ href="\/vortex2\/web\/">/g' docs/web/index.html
```
