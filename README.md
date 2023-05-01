# Most Popular Articles
iOS App to display NYTimes Most Popular Articles

# Installation Steps:
1. Go to NY Time API Dev Portal (https://developer.nytimes.com/my-apps) and create a new app.
2. Generate a new API Key for the app.
3. Check-out the latest code from 'main' branch into your local machine.
4. Open Terminal and navigate to the checked out project path using "cd <path of the directory>" command.
5. Run "pod install" command. Wait for command to complete the execution.
6. Open the source code in latest Xcode using project workspace "ArticlesTest.xcworkspace" file.
7. Search for ".xcconfig" files in project navigator of Xcode.
9. Update "API_KEY" value in 3 different configuration files (app.debug, app.staging, app.release) with API Key generated from NY Times API Dev Portal in step 2 above
10. Run the code from Xcode using simulator.
