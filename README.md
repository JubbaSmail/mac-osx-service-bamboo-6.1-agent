# mac-osx-service-bamboo-6.1-agent
Run Bamboo 6.1 Agent on Mac OS X as a background service to build iOS IPA and Android APK

<img width="250" src="https://www.apple.com/hk/en/macos/images/og.jpg?201705142356"/><img width="300" src="https://wac-cdn.atlassian.com/dam/jcr:4f99ae3f-808f-44f1-9647-2b7cb87bb0e6/bamboo_rgb_slate.png?cdnVersion=fr"/><img width="250" src="https://docs.particle.io/assets/images/apple-android.png"/>

# Before you start, prepare your Mac:
Bamboo Agent require Java 8 or later, follow the steps:
1. Install Brew
   ```bash
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   ```
2. Install Java 8:
   ```bash
    brew update
    brew cask install java
    ```
3. Bamboo Agent will use the hostname as it's name to be displayed in Bamboo Server Agent Mangment insterface, to edit the hostname on you machine do the following:
	- Apple -> System Prefrence -> Sharing -> Computer Name
	- Set a uniqe name in your network, to make it easier to trak the agents later.

4. If you need the agent to be always ready to build then you need to set you machine to never to sleep:
	- Apple -> System Prefrence -> Energy Server -> Computer Sleep : Never
	
# Are your Bamboo Server ready to recive connections ?
1. Go to your Bamboo server settings -> System -> General Configureation: 
   Make sure Broker client URL is not pointing to localhost, it shoud point to your server ip or hostname
2. Make sure the ports 54663m, 443 and 80 in your Bamboo server are open, try to telnet it from the agent host:
   ```bash
   telnet BAMBOO-SERVER-IP 54663
   telnet BAMBOO-SERVER-IP 443
   telnet BAMBOO-SERVER-IP 80
   ```
3. If you would like to forse agent to use authentication token: 
	Go to your Bamboo server settings -> Agents, click on Enable Authentication Token, then click on Install Remote Agent, copy the token after -t from the command

# Download the Mac App
The app size on Github is larger than 100 MB, you need to use git lfs to clone it to your machine:
```bash
brew install git-lfs
git lfs install
git lfs clone https://github.com/Ismail-AlJubbah/mac-osx-service-bamboo-6.1-agent.git
```

# Configure the Agent to connect to Bamboo Server
The App contains a configuration file to save Bamboo Server URL and tocken
```bash
cd mac-osx-service-bamboo-6.1-agent
vi BambooAgent.app/Contents/Resources/BambooAgent.conf
```
now edit the value of the variables bamboo_url and bamboo_token to work with your Bamboo Server

# To Build iOS App
On the Mac OSX which will host the agent, do the following:
1. Install Xcode from App Store
2. For each new build plan, install Apple development and release private keys on the Keychain manaully.
3. For each new build plan, copy *.mobileprovision to "~/Library/MobileDevice/Provisioning\ Profiles/", if you keep the provisioning profiles in your GIT repo then you can do this step automatically by adding Command Task in the build plan in Bamboo Server.

# To Build Android App
On the Mac OSX which will host the agent, do the following:
1. Install Android SDK:
   ```bash
   brew tap caskroom/cask
   brew cask install android-sdk
   echo "export ANDROID_HOME=/usr/local/share/android-sdk" >> ~/.bash_profile
   echo "export PATH=$ANDROID_HOME/platform-tools:$PATH" >> ~/.bash_profile
   echo "export PATH=$ANDROID_HOME/tools:$PATH" >> ~/.bash_profile 
   ```
# Install BambooAgent
Using Finder, go the repo folder, double click on BambooAgent, this will copy the App to your Application folder and set it to run automatically on login

# Running
1. Go to LaunchPad and run BambooAgent
2. After running the agent go to your Bamboo server settings -> Agents -> Agent authentication: and aprrove the agent request.
3. Go to your Bamboo server settings -> Agents -> Online Remote Agent: and wait unit the agent register it self to the server, it may take 2 mins (you may need to refresh the page manually).


# Configure Build Plan for Android APK:
1. Go to Configure Plan in your plan settings, in Task, click Add task, select Command, and enter the following values:
	- Task description: Build APK
	- Executable: gradelw
	- Argument to build a relase APK: clean assembleRelease
	- Environment variables: ANDROID_HOME="/usr/local/share/android-sdk"
	
# Configure Build Plan for iOS IPA:
1. Go to Configure Plan in your plan settings, in Task, click Add task, select XCode, and enter the following values:
	- Task description: Build IPA
	- Apple SDK: iOS 10.3, run the command xcodebuild -showsdks to get the SDK name in your machine.
	- Make sure to enter the values of: Workspace and Scheme.
	- Check Build an .ipa for iOS Application Distribution, and fill the values: iOS application path, Development Team and Distribution Method: Application Store.

# Debuging
Run the following commmand to check the agent logs:
   ```bash
   tail -f ~/bamboo-agent-home/BambooAgent.log
   ```
# Links
More information can be found on the following links:
1. [Run Bamboo Agent as docker to build Android APK](https://github.com/Ismail-AlJubbah/docker-bamboo-6.1-agent-android)
