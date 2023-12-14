# GenDroid
_Create Android projects directly from your Termux or Linux without installing Android Studio._

## Requirements 
You need to have these tools installed 
- jdk 17
- gradle 7.6.3
- git
- wget
- unzip

##

## Installing 
1. Clone this repo
```sh
git clone https://github.com/lipeedev/gendroid.git
```

2. Add to your path
```sh
mv gendroid ~/.local/share
export PATH=$PATH:~/.local/share/gendroid
```

3. Install Android SDK if you do not have
```sh
gendroid install-sdk
```

> If you are using termux, type "y" in "is your architecture aarch64?"


##

## Using 

You can create your projects using 
```sh
gendroid create
```

`App Name` - Project Name 


`Group` - Group Name (ex: com.lipe)

##

generate the APK using
```sh
./gradlew assemble

./gradlew assembleDebug

./gradlew assembleRelease
```

> use assembleDebug during development

APK file is on **app/build/outputs/apk/** folder

##

## Setting up IDE

- install [LunarVim (Neovim)](https://www.lunarvim.org/docs/installation)

- use this plugin to get autocomplete on LSP

```lua
lvim.plugins = {
  "hsanson/vim-android"
}
```

