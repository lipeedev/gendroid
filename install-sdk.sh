#!/bin/sh 

function install () {
 if [ -v ANDROID_HOME ]; then 
    echo ">> ANDROID_HOME is already set."
    exit 1
 fi

  read -p "- Android SDK path: " android_sdk_path

  mkdir -p $android_sdk_path/cmdline-tools
  
  wget -q --show-progress "https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip?hl=pt-br" -O $android_sdk_path/cmdline-tools/cmdlt.zip  
  
  unzip $android_sdk_path/cmdline-tools/cmdlt.zip -d $android_sdk_path/cmdline-tools > /dev/null

  mv $android_sdk_path/cmdline-tools/cmdline-tools $android_sdk_path/cmdline-tools/latest

  chmod +x $android_sdk_path/cmdline-tools/latest/bin/*
  export ANDROID_HOME=$android_sdk_path

  bash $android_sdk_path/cmdline-tools/latest/bin/sdkmanager "platforms;android-34"

  read -p "is your architecture aarch64? [y/N] " is_aarch64

  case "$is_aarch64" in
  [yY][eE][sS]|[yY]) 
    cp -r $(dirname $0)/build-tools $android_sdk_path
    cp -r $(dirname $0)/platform-tools $android_sdk_path
    ;;
    *)
    
    bash $android_sdk_path/cmdline-tools/latest/bin/sdkmanager "build-tools;30.0.3"
    bash $android_sdk_path/cmdline-tools/latest/bin/sdkmanager "platform-tools"
    mv $android_sdk_path/build-tools/30.0.3 $android_sdk_path/build-tools/33.0.2
    ;;
  esac

  echo ">> add ( export ANDROID_HOME=$android_sdk_path ) to your *shrc file [zshrc, bashrc...]"
} 
