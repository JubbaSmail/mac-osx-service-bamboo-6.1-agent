#! /bin/bash
cp bamboo.agent.plist /Library/LaunchDaemons/
chmod a+r /Library/LaunchDaemons/bamboo.agent.plist
cp -r ../../../BambooAgent.app /Applications/
chmod -R a+rwx /Applications/BambooAgent.app
osascript -e 'tell app "System Events" to display dialog "BambooAgent.app: Installation Completed, please run the application from the App Center."'