# Most Popular Articles
iOS App to display NYTimes Most Popular Articles

# Installation Steps:
1. Checkout the lastest code from 'main' branch into your local machine
2. Open Terminal and navigate to the checked out project path using cd <path of the directory> command
3. Run "pod install" command. Wait for command to complete the execution
4. Open the source code in latest Xcode using project workspace "ArticlesTest.xcworkspace" file
5. Search for "Constant.swift" file in project navigator of Xcode.
6. Update "most_popular_url" value with NY Times Most Popular url (copy paste "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=")
7. Update "api_key" value with API Key generated from NY Times API Dev Portal (https://developer.nytimes.com/my-apps)
8. Run the code from Xcode in simulator.
