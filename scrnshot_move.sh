#!/bin/bash

SCREENSHOT_DIR=~/Pictures/Screenshots.localized

if [ -z $(defaults read com.apple.screencapture location 2>/dev/null) ]
then
	echo "current scrnshot dir is DEFAULT."
	if [ ! -e $SCREENSHOT_DIR ]
	then
		mkdir -p $SCREENSHOT_DIR/.localized
		cd $SCREENSHOT_DIR/.localized/
		echo "\"Screenshots\" = \"스크린샷\";" > ko.strings
		echo "\"Screenshots\" = \"スクリーンショット\";" > ja.strings
	fi
	defaults write com.apple.screencapture location $SCREENSHOT_DIR
	echo "-> scrnshot dir is now CUSTOM($SCREENSHOT_DIR)."
else
	echo "scrnshot dir is currently CUSTOM($SCREENSHOT_DIR)."
	echo "return to default directory? (Y\n):"
	read sel
	if [ "$sel" != "n" ]
	then
		defaults delete com.apple.screencapture location
		echo "-> scrnshot dir is now DEFAULT."
	else
		echo "-> scrnshot dir remains default."
	fi
fi
killall SystemUIServer

unset SCREENSHOT_DIR