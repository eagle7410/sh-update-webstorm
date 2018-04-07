#!/usr/bin/env bash
# @examle run `sudo sh installer-webstom.sh WebStorm-181.4203.535`

echoColor () {
	color=$1;
	string=$2;

	case $color in
		"err"*)  code="0;31";;
		"done"*) code="0;32";;
		"warn"*) code="1;33";;
		"info"*) code="0;34";;
		*) code="1;37"
	esac

	echo "\033[${code}m $string \033[0m";

}

echoColor 'done' 'Run install WebStorm ...'

src_dir="$1"

if [ -z "${src_dir##*WebStorm*}" ]
then
	type_app='webstorm'
else
	type_app='phpstorm'
fi

echoColor 'info' "..Type Application is $type_app"


if [ ! "$src_dir" ]
then
	echoColor 'err' 'Error! Not argument src_dir name source dir install. Example WebStorm-181.4203.535'
	exit
fi

pathToStormFolder="$HOME/soft/storms/$src_dir";

if [ -e "$pathToStormFolder" ]
then
	echoColor 'info' '..Check src_dir Ok'
else
	echoColor 'err' "Error! $pathToStormFolder not found."
	exit
fi

echoColor "info" "..Attach ctr-v ctr-c fix_hot_keys Start"

	pathToFixFolder="$HOME/soft/fix_hot_keys/fix/build";
	fileInclude="LinuxJavaFixes-1.0.0-SNAPSHOT.jar";

	if [ -e "$pathToFixFolder/$fileInclude" ]
	then
		echoColor 'info' '....Check exists fix file Ok'
	else
		echoColor 'err' "Error! $pathToFixFolder/$fileInclude not found."
		exit
	fi

	pathToWriteFile="$pathToStormFolder/bin/${type_app}64.vmoptions";

	if [ -e "$pathToWriteFile" ]
	then
		echoColor 'info' '....Check exists file set fix Ok'
	else
		echoColor 'err' "Error! $pathToWriteFile not found."
		exit
	fi

	echo "\n-javaagent:$pathToFixFolder/$fileInclude" >> "$pathToWriteFile";

echoColor "info" "..Attach ctr-v ctr-c fix_hot_keys End"
echoColor "info" "..Create label Start"

	echo "	[Desktop Entry]
	Name=$pkg_name
	Comment=
	GenericName=
	Keywords=
	Exec=sh "$pathToStormFolder/bin/${type_app}.sh"
	Terminal=false
	Type=Application
	Icon="$pathToStormFolder/bin/${type_app}.png"
	Path=
	Categories=IDE
	NoDisplay=false
	" > "$HOME/.local/share/applications/${type_app}.desktop"

echoColor "info" "..Create label end"
echoColor "done" "Install ${type_app} Success ...";
