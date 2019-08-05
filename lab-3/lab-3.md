---
layout: default
title: Lab 3 Autonomous LAB, APEX Hands-On
---

# Lab 3: Autonomous LAB, APEX Hands-On

Build your first low code application with Oracle APEX on Oracle Autonomous Transaction Processing.

## Table of contents

* [Prerequisites](#prerequisites)
* [Introduction to your lab](#introduction-to-your-lab)
* [Lab guide](#lab-guide)
   * [Access lab resources](#access-lab-resources)
   * [Step-by-Step Guide](#step-by-step-guide)


## Prerequisites

- An Oracle Cloud Account
- Right permissions


## Introduction to your lab

In this lab we will build APEX Application.

# Lab guide

## Access lab resources

The only resource that you will need for this lab (except an Oracle Cloud Account) is the [sports2019.csv](https://github.com/alpsteam/autonomous-labs/blob/master/lab-3/sports2019.csv) file. You can download the file as a `.zip` below.

[Download .zip file](https://github.com/alpsteam/autonomous-labs/raw/master/lab-3/lab-3-resources.zip){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } 

## Step by Step Guide

Login to Application Using

![Image1](images/image1.png)

Press Next and choose your
Username : userXX (where XX represents 01 .. 10)
Password  : aaddbbllaabbU[xx] where XX represents 01..10)

![Image2](images/image2.png)

Choose Autonomous Transaction Databases, Create a Database

![Image3](images/image3.png)

Once done, choose the user corresponding Compartment

![Image4](images/image4.png)

Choose as Display Name and Database Name your username: Atpuser01, atpuser02

![Image5](images/image5.png)

Keep the pre-selected options on ATP and server-less, number of oCPUs and storage as predefined

![Image6](images/image6.png)

Use your password of choice or the one you used as login password (aaddbbllaabbU[01-10] )

![Image7](images/image7.png)

Press Create Autonomous Database, this step takes approximately 3-5 minutes
Then choose Service Console:


![Image8](images/image8.png)

![Image9](images/image9.png)

Choose Development on the left part of the screen.

![Image10](images/image10.png)

Choose APEX, you will be prompted for yet another password. 

![Image11](images/image11.png)

Now, create a Workspace:

![Image12](images/image12.png)

To keep it simple, use again the user username and password, workspace name defaults to username:

![Image13](images/image13.png)

After a few seconds you see a screen like that: Here, it is important to listen to the instructors and log out of this screen to re-login to the user just being created.

![Image14](images/image14.png)

Re-enter your credentials:

![Image15](images/image15.png)

Tataaahhhh: you should see this screen now:

![Image16](images/image16.png)

Choose App Builder and continue

![Image17](images/image17.png)

Choose `Create` and you see this:

![Image18](images/image18.png)

We will share a file via slack during the run of this session with you, download that file to your laptop location of your choice. It`s a small xls/csv file called sports2019.csv

![Image19](images/image19.png)

Open the file

![Image20](images/image20.jpg)

Choose `Configure` to customize the data load

![Image21](images/image21.jpg)

Remove COLUMN_, COL07 & COL08 from the list of columns to load and `SAVE changes`

![Image22](images/image22.jpg)

Enter Table Owner (it's the user you created), enter Table Name SPORTS_EVENTS, leave Error Table Name empty and choose `Load Data`

![Image23](images/image23.jpg)

You get a confirmation then choose `Continue to Create Application Wizard`

![Image24](images/image24.jpg)

Enter `Sports Events 2019` as Name and choose `Create Application`

![Image25](images/image25.jpg)

Application gets created, choose `Run Application`

![Image26](images/image26.jpg)

Provide Username and Password to start the application (it's the user you created)

![Image27](images/image27.jpg)

All created automatically. Keep layout in mind for later. Choose `Events`

![Image28](images/image28.jpg)

Application is fully functional. Choose an event to edit it.

![Image29](images/image29.jpg)

After applying the change you will see it in the events list

![Image30](images/image30.jpg)

Choose `Dashbord` to see a chart. Chart was created automatically based on the data loaded

![Image31](images/image31.jpg)

We create a new page in the application to see the Sports Events in a calendar. Choose `Create Page`

![Image32](images/image32.jpg)

From the Components list choose `Calendar` then `Next`

![Image33](images/image33.jpg)

Enter Page Name `Calendar` then choose `Next`

![Image34](images/image34.jpg)

Choose `Create a new navigation menu entry` then `Next`

![Image35](images/image35.jpg)

Enter Table / View Owner (it's the user you created) and Table / View Name `SPORTS_EVENTS (table)` then `Next`

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

Run the application

Congratulation! You successfully completed the autonomous Lab APEX.

 

