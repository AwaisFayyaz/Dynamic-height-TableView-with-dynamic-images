# Dynamic-hieght-TableView-with-dynamic-images
This is a demo project for an answer of a stack overflow question (https://stackoverflow.com/q/55128485/7698092)

# The Problem
See the detailed problem description in the above question link. Breif summary of problem is as follows.

Implement a table view with dynamic height cells with following configuration.

Each cell should contain 2 labels and an image. content(text) of labels is dynamic so labels heights should be dynamic. Image width should be equal to device width and its height should be dynamic. images are to be downloaded from web using some 3rd party such as KingFisher. Images should not appear stretched(maintain aspect ratio). So, Height of cell should be dynamic, based on labels content and the image height.


# Solution
Used a table view with following configuration

number of sections == count of data source

number of rows in a section == 3. 

first row corresponds to title, second row corresponds to subtitle and the 3rd corresponds to the image.

Height of first row (title) and second row (subtitle) is calculated by tableView itself. (using 
UITableView.AutomaticDimension). 

Height of image is calculated based on the screen width, while maintaining image aspect ratio. If aspect ratio is not maintained, image would look stretched.

If any Questions or Queries

tweet me @abulkhairawais
or mail me @ awaisfayyaz17@gmail.com

# Related Links

The following article shows how to implement dynamic cells that contain labels only. Concepts from the below artile were used in this demo. (I Recommended to read it also)

https://medium.com/mobile-app-developers/self-sizing-cells-40b9cc8c8fc5

Awais Fayyaz

iOS Developer @ BugDevStudios.com

Lahore, PAK


