#!/bin/sh
#
function create() {
programs="javac git wget gradle unzip"

for program in $programs; do
  if ! [ -x "$(command -v $program)" ]; then
    echo ">> $program is not installed"
    exit 1
  fi
done 

if ! [ -v ANDROID_HOME ]; then
   echo ">> You must to set ANDROID_HOME enviroment variable"
   exit 1
fi 

if ! [ -v JAVA_HOME ]; then
   echo ">> You must to set JAVA_HOME enviroment variable"
   exit 1
fi

files_dir="$(dirname $0)/files"

read -p "- App name: " app_name 
read -p "- Group: " group_name
package="$group_name.$app_name"

mkdir -p $app_name 

cp -r $files_dir/* $app_name

sed -i "s#(APP_NAME)#$app_name#g"  $app_name/settings.gradle

sed -i "s#(ANDROID_SDK)#$ANDROID_HOME#g" $app_name/gradle.properties
sed -i "s#(JAVA_HOME)#$JAVA_HOME#g" $app_name/gradle.properties

sed -i "s#(APP_ID)#$package#g" $app_name/app/build.gradle

sed -i "s#(APP_NAME)#$app_name#g" $app_name/app/src/main/AndroidManifest.xml

sed -i "s#(APP_PACKAGE)#$package#g" $app_name/app/src/main/java/MainActivity.java

package_dir=$app_name/app/src/main/java/$(echo $package | sed "s/\./\//g")

mkdir -p $package_dir

default_package_dir=$app_name/app/src/main/java

mv $default_package_dir/MainActivity.java $package_dir 

}
