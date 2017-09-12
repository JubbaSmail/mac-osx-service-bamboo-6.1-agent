# mac-osx-service-bamboo-6.1-agent
Run Bamboo 6.1 Agent on Mac OS X as a background service to build iOS IPA and Android APK

<img width="250" src="https://www.apple.com/hk/en/macos/images/og.jpg?201705142356"/><img width="300" src="https://wac-cdn.atlassian.com/dam/jcr:4f99ae3f-808f-44f1-9647-2b7cb87bb0e6/bamboo_rgb_slate.png?cdnVersion=fr"/><img width="250" src="https://docs.particle.io/assets/images/apple-android.png"/>

# Installing
Clone the project to your directory
```bash
git clone https://github.com/Ismail-AlJubbah/mac-osx-service-bamboo-6.1-agent.git
```
# Running


# Connect the Agent to Bamboo server
Follow the following steps to make sure your Bamboo agent can connect to Bamboo server:
1. Go to your Bamboo server settings -> System -> General Configureation: 
   Make sure Broker client URL is not pointing to localhost, it shoud point to your server ip or hostname
2. Make sure the ports 54663 443 80 in your Bamboo server are open, try to telnet it from the agent host:
   ```bash
   telnet BAMBOO-SERVER 54663
   telnet BAMBOO-SERVER 443
   telnet BAMBOO-SERVER 80
   ```
3. If you would like to forse agent to use authentication token: 
	Go to your Bamboo server settings -> Agents, click on Enable Authentication Token, then click on Install Remote Agent, copy the token after -t from the command
4. Go to your Bamboo server settings -> Agents -> Agent authentication: and aprrove the agent request.
5. Go to your Bamboo server settings -> Agents -> Online Remote Agent: and wait unit the agent register it self to the server, it may take 2 mins (you may need to refresh the page manually).

# Configure Build Plan:
1. Go to Configure Plan in your plan settings, in Task, click Add task, select Command, and enter the following values:
        a. Task description: Build APK
        b. Executable: gradelw

# Links
More information can be found on the following links:

1. [Run Bamboo Agent as docker to build Android APK](https://github.com/Ismail-AlJubbah/docker-bamboo-6.1-agent-android)
