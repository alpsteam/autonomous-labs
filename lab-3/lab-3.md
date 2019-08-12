---
layout: default
title: Lab 3 APEX on Autonomous DB (ATP)
---

# 🚀 Lab 3: APEX on Autonomous DB (ATP)

Build your first low code application with Oracle APEX on Oracle Autonomous Transaction Processing.

## Table of contents

* [APEX Lab as Youtube Video](#apex-lab-as-youtube-video)
* [Prerequisites](#prerequisites)
* [Introduction to APEX and Autonomous DB](#introduction-to-apex-and-autonomous-db)
* [Lab guide](#lab-guide)
   * [Access lab resources](#access-lab-resources)
   * [Step-by-Step Guide](#step-by-step-guide)

## APEX Lab as Youtube Video

You can view the contents of this lab as a Youtube video by clicking the thumbnail below.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=-wHhksetQv0" target="_blank"><img src="http://img.youtube.com/vi/-wHhksetQv0/0.jpg" 
 border="10" /></a>

## Prerequisites

- An Oracle Cloud Account
- Web browser
- 60-90 minutes to complete the lab

## Introduction to APEX and Autonomous DB

### What is Oracle APEX?

[Oracle Application Express (APEX)](https://apex.oracle.com/) is a low-code development platform that enables you to easily build enterprise apps, with world-class features, that can be deployed anywhere.

> **Build scalable, secure enterprise apps. Fast.**

Learning Oracle APEX is easy and it won't take long to pick up the basics. Check out the [learning section](https://apex.oracle.com/en/learn/) of APEX. For this lab, we don't require any prior experience with Oracle APEX.

### What is Oracle Autonomous DB?

With Oracle Autonomous Database Cloud services, you can develop and deploy on a preconfigured, **fully managed, and secured  environment** (database including services like Oracle APEX) without any of the hassles of upkeep or manual maintenance.

Oracle Autonomous Transaction Processing and Autonomous Data Warehouse deliver self-driving, self-securing, self-repairing database services that scale instantly to meet the demands of mission critical applications.

No IT skills required, meaning you don't need to be a database administrator, network engineer, security expert, or systems architect. Oracle takes care of it all, from configuration, tuning, backup, to patching, encryption, scaling and more, so that you can concentrate on solving business problems.

# Lab guide

## Access lab resources

The only resource that you will need for this lab (except an Oracle Cloud Account) is the `sports2019.csv` file. You can download the file as a `.zip` below.

[Download .zip file](https://github.com/alpsteam/autonomous-labs/raw/master/lab-3/lab-3-resources.zip){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [View .csv file](https://github.com/alpsteam/autonomous-labs/tree/master/lab-3/sports2019.csv){: .btn .fs-5 .mb-4 .mb-md-0 }

## Step by Step Guide

Head to the [Oracle Cloud login page](https://cloud.oracle.com/en_US/sign-in) and enter your tenancy name.

![Image1](images/image1.png)

Enter your login credentials for your tenancy.

![Image2](images/image2.png)

From the hamburger menu in the top left, choose `Autonomous Transaction Processing`. The, create a database.

![Image3](images/image3.png)

Once done, choose the corresponding compartment.

![Image4](images/image4.png)

Choose a display name and database name for ATP instance.

![Image5](images/image5.png)

Keep the pre-selected options on ATP and choose `serverless`, number of OCPUs and storage as predefined.

![Image6](images/image6.png)

Choose a password with strong security for the database instance.

![Image7](images/image7.png)

Press `Create Autonomous Database`, this step takes approximately 3-5 minutes. 

![Image8](images/image8.png)

Then choose `Service Console`.

![Image9](images/image9.png)

Choose `Development` on the left part of the screen.

![Image10](images/image10.png)

Choose APEX, you will be prompted for yet another password. Enter your database password that you chose earlier.

![Image11](images/image11.png)

Now, create a workspace.

![Image12](images/image12.png)

Choose a workspace name, username and password to begin working in APEX.

![Image13](images/image13.png)

After a few seconds you see a screen like that: Here, it is important to listen to the instructors and log out of this screen to re-login with the new workspace and new user that was just created.

![Image14](images/image14.png)

Re-enter your credentials.

![Image15](images/image15.png)

Tadaaahhh, you should see this screen now.

![Image16](images/image16.png)

Choose `App Builder` and continue.

![Image17](images/image17.png)

Choose the big `Create` button and you see this.

![Image18](images/image18.png)

Upload the `sports2019.csv` file that you previously downloaded [here](https://alpsteam.github.io/autonomous-labs/lab-3/lab-3.html#access-lab-resources).

![Image19](images/image19.png)

Afterwards you should see this screen.

![Image20](images/image20.jpg)

Choose `Configure` to customize the data load.

![Image21](images/image21.jpg)

After the `Configure` screen has opened, switch to the `Columns to load` tab. Afterwards remove the columns `COLUMN_`, `COL007` and `COL008` by unticking them and `Save changes`.

![Image22](images/image22.jpg)

Enter table owner (it's the user you created for the workspace), enter a table name `SPORTS_EVENTS`, leave `Error Table Name` empty and choose `Load Data`.

![Image23](images/image23.jpg)

You get a confirmation then choose `Continue to Create Application Wizard`.

![Image24](images/image24.jpg)

Enter `Sports Events 2019` as Name and choose `Create Application`.

![Image25](images/image25.jpg)

Application gets created, choose `Run Application`.

![Image26](images/image26.jpg)

Provide your username and password to start the application (it's the user you created for the workspace).

![Image27](images/image27.jpg)

All created automatically. Keep layout in mind for later. Choose `Events`.

![Image28](images/image28.jpg)

Application is fully functional. Choose an event to edit it.

![Image29](images/image29.jpg)

After applying the change you will see it in the events list.

![Image30](images/image30.jpg)

Choose `Dashbord` to see a chart. Chart was created automatically based on the data loaded.

![Image31](images/image31.jpg)

We create a new page in the application to see the Sports Events in a calendar. Choose `Create Page`.

![Image32](images/image32.jpg)

From the components list choose `Calendar` then `Next`.

![Image33](images/image33.jpg)

Enter page name `Calendar` then choose `Next`.

![Image34](images/image34.jpg)

Choose `Create a new navigation menu entry` then `Next`

![Image35](images/image35.jpg)

Enter table / view owner (it's the user you created) and table / view name `SPORTS_EVENTS (table)` then `Next`.

![Image36](images/image36.jpg)

Enter Display Column `SPORT`, Start Date Column `START_DATE`, End Date Column `END_DATE` then choose `Create`

![Image37](images/image37.jpg)

Choose `Save and Run` in the top right corner to test the new page

![Image38](images/image38.jpg)

Et voilá, calendar page with a navigation menu entry on the left. On mouse-over of an event you see some details but we like to see and edit all details. For that return to Page Designer

![Image39](images/image39.jpg)

In the Navigator pane (left) choose `Attributes` under Region ` Content Body ` Calendar. In the Attributes pane (right) choose `View / Edit Link`

![Image40](images/image40.jpg)

In Page enter `3` (Event), for Set Items enter Name `P3_ID` and Value `ID` then choose `Ok`

![Image41](images/image41.jpg)

`Save and Run` the page

![Image42](images/image42.jpg)

If you choose an event you are now able to edit the details of the event.

![Image43](images/image43.jpg)

We add a Pie-Chart to the Dashboard Page. In the Navigator pane choose `Sport` under Region `Content Body`, from hamburger menu choose `Duplicate`

![Image44](images/image44.jpg)

In the Navigator page choose `Attributes` under Region ` Content Body ` Sport (2nd), in the Attributes pane enter Chart Type `Pie`

![Image45](images/image45.jpg)

In the Navigator page choose `Series 1` under Region ` Content Body ` `Sport (2nd) ` Series, in the Attributes pane enter Label Show `Yes` and Display As `Label ` Percentage (Value)`

![Image46](images/image46.jpg)

`Save and Run` the page, the Dashboard page contains 2 Charts.
Now remember the content of the homepage, it contains an Event and Dashboard item. 


![Image47](images/image47.jpg)

Navigate to the Page Designer of the page Home. In the Navigator pane choose tab `Page Shared Components` (right)

![Image48](images/image48.jpg)

In the Navigator pane choose `Page Navigation` under Lists. In the Lists pane (right)  choose `Edit Component`

![Image49](images/image49.jpg)

Choose `Create Entry`

![Image50](images/image50.jpg)

Enter Page `5` (Calendar) and List Entry Label `Calendar`, choose an Image/Class of your choice. Choose `Create List Entry`

![Image51](images/image51.png)

Now, run the application.

**Congratulations!** You have successfully completed the `Autonomous Lab 3: APEX`.

 

