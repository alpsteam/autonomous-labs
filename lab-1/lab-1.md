---
layout: default
title: Lab 1 Oracle Autonomous Cloud Services Labs
---

# ðŸš€ Lab 1: Oracle Autonomous Cloud Services Labs


## Table of contents

1. [Oracle Autonomous Cloud Services Labs](#oracle-autonomous-cloud-services-labs)
2. [About Autonomous Database Cloud](#about-autonomous-database-cloud)
3. [Prerequisites](#prerequisites)
4. [Autonomous Data Warehouse](#autonomous-data-warehouse)
   1. [Provisioning an ADW service](#provisioning-an-adw-service)
   2. [Connecting to ADW](#connecting-to-adw)
   3. [Creating a new ADB user](#creating-a-new-adw-user)
   4. [Generating Swift Password for Object Storage](#generating-swift-password-for-object-storage)
   5. [Data Loading into Cloud Object Storage](#aata-loading-into-cloud-object-storage)
   6. [Data Loading from Cloud Object Storage to ADW using the SQL Developer Import Wizard](#data-loading-from-cloud-object-storage-to-adw-using-the-sql-developer-import-wizard)
   7. [Connecting to Swingbench](#connecting-to-swingbench)
   8. [Comparing the consumer groups](#comparing-the-consumer-groups)
   9. [Monitoring your ADW instance](#monitoring-your-adw-instance)
   
5. [Autonomous Transaction Processing](#autonomous-transaction-processing)
   1. [Provisioning an ATP service](#provisioning-an-atp-service)
   2. [Connecting to ATP](#connecting-to-atp)
   3. [Creating new ADB user](#creating-new-adb-user)
   4. [Generating Swift Password for Object Storage](#generating-swift-password-for-object-storage)
   5. [Data Loading to Cloud Object Storage](#data-loading-to-cloud-object-storage)
   6. [Data Loading from Cloud Object Storage to ATP using the SQL Developer Import Wizard](#data-loading-from-cloud-object-storage-to-atp-using-the-sql-developer-import-wizard)
   7. [Connecting to Swing bench](#connecting-to-swing-bench)
   8. [Comparing the consumer group](#comparing-the-consumer-group)
   9. [Monitoring your ATP instance](#monitoring-your-atp-instance)

# Oracle Autonomous Cloud Services Labs
   
## Autonomous Data Warehouse Cloud (ADW)
## Autonomous Transaction Processing (ATP)

In this hands-on lab you will get first-hand experience with the Oracle Autonomous Database Cloud. You’ll utilize the established, free workload generator “Swingbench”, which provides a selection of tailored workload profiles. The sections for ATP and ADW are self-contained and therefor can be executed separately or in combination. You will perform following workloads to exploit service features and to stress the abilities of ADW and ATP: 

-	ATP – Swingbench “OrderEntry” is based on the "oe" demo schema that ships with the Oracle database, it introduces heavy contention on a small number of tables and is designed to stress interconnects and memory. 
-	ADW – Swingbench “SalesHistory” is based on the “sh” demo schema that ships with the Oracle database, it is read-only and designed to test the performance of complicated analytical queries running against large tables.

In a first step, using the Oracle Cloud interface, you will provision the according Autonomous Database and see how you can connect your accustomed tools to your new database. You will make yourself familiar with the service console that enables you to administer and monitor your Autonomous Database(s).

Next, we will upload two Data Pump export files containing the corresponding “on-premise” Swingbench demo schemas into the Oracle Cloud Object Storage.  With the help of the comfortable SQL Developer Import Wizard, we then will import those datasets into your Autonomous database(s).

For the ADW workload, you will start the Swingbench Java client to connect to your ADW instance. You will start with a given number of active users busily executing a customizable set of sophisticated analytic queries (such as cubes, rollups, top-n, moving average) in parallel and observe performance indicators like number of queries executed and average response time. Then by doubling the number of users on the fly you will notice that query statements obviously start queuing since the response time will start to rise alarmingly. You’ll solve the situation by scaling the service online and without downtime to bring the response time back within assumed SLA limits. 

For the ATP workload, and before starting the actual workload, you will use Oracle SQL Developer to understand how the provided consumer groups (High, Medium, Low) have been defined and how they will divide up resources. Next, you will start three parallel Swingbench clients, each with a number of users connecting to the distinct consumer groups, stressing the database, deliberately causing contention. You will observe how the users’ transactions will compete for resources and how the service will prioritize consumer groups according to the resource allocation plan. You then will provide more resources by scaling the service online and without downtime. Since the database now can “breath more freely” and contention is removed, all three consumer groups will benefit - as you will observe with the help of performance indicators like number of transactions executed and average response time.

Concluding the lab, you will cease Swingbench workloads and terminate your Autonomous Databases using the Oracle Cloud console.


## About Autonomous Database Cloud

Oracle’s unique autonomous database framework ensures high availability and automatic security–without requiring any additional tasks. Scale as needed - create and expand your database compute and storage capacity on demand and independently of each other with no downtime. Pay only for the resources you consume.  It integrates directly with the full spectrum of business analytics, data integration and IoT services within Oracle's comprehensive range of integrated cloud solutions. All aspects of performance tuning are automatically managed so the service requires no database tuning. 

The Oracle Autonomous Data Warehouse Cloud provides an easy-to-use, fully autonomous database that scales elastically, delivers fast query performance and requires no database administration. It is a fully-managed cloud service that makes it very simple to provision a data warehouse, and to quickly and easily load data and query that data using built-in web-based tools such as notebooks. It delivers high performance data warehousing straight out-of-the-box with unparalleled scalability and reliability. It is built on key Oracle Database capabilities: parallelism, columnar processing and compression. 

Autonomous Transaction Processing provisions mission-critical, scale-out databases and
supports a complex mix of high-performance transactions, but also reporting, batch, IoT, and machine learning in a single database, allowing much simpler application development and deployment.

This is an instructor led lab, please follow the instructor’s guidance before doing the exercises. Stop and wait for indications before moving on to the next section. 

## Prerequisites

- Oracle cloud account
- Set of data files
- Oracle SQL Developer
- Swingbench

## Oracle cloud account
You will be allocated with the cloud account details( identity domain, username and password) prior to the start of the workshop. Please check with the instructor for any issues.

## Set the data files
We will use a .dmp file as an example to load it in object store and in turn import the same using SQL Developer. There are two dump files- One for ADW and the other one for ATP. The dumpfiles are zipped and attached below. Please download the zip file and save it in your local repository and unzip the same.

[Download .zip file](https://github.com/alpsteam/autonomous-labs/raw/master/lab-1/Dumpfiles.zip){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

## Oracle SQL Developer
Oracle SQL Developer is a free, integrated development environment that simplifies the development and management of Oracle Database in both traditional and Cloud deployments. SQL Developer offers a worksheet for running queries and scripts, a DBA console for managing the database, a reports interface, a complete data modelling solution, and a migration platform for moving your 3rd party databases to Oracle.

(https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html)

Make sure to accept the License Agreement or the download option won’t appear. 
Then select your appropriate architecture and download.

PLEASE NOTE Mac OS X and Linux: Java SE Development Kit 8u181 is required and can be installed from here (please read SQL Developer installation notes for Max OSX and Linux RPM:


You can download SQL Developer Version 18.4 from OTN (make sure you download the correct version 
for your type of computer and operating system, you can also search for Oracle SQL Developer download if you have problems with the link):

(https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

## Swingbench
To run swingbench requires 3 components:
-	Unix Bash Shell
-	Java JRE 1.8xx
-	Swingbench (and optional modules)

### Installing Unix Bash Shell:

To run Swingbench on Windows you need to simulate running a Unix shell and that can be done in many ways. This lab uses the Git BASH shell. The latest version of Windows 10 includes this functionality natively but you many need to enable/install it. The steps for getting BASH running will not be covered in this lab but for Windows 10 you can find detailed instructions here:

(https://www.windowscentral.com/how-install-bash-shell-command-line-windows-10)

For older versions of Windows, you can download and install BASH

(https://gitforwindows.org/)

### Installing Java JRE 1.8xx:

Swingbench requires Java 8 to run. You must install it if you don’t have it installed. Please notice of you already have SQL Developer running then you have the correct Java installed already. You can test to see if you have it installed by running the following command in command prompt window.

java -version

Java can be downloaded and installed from (pick the appropriate operating system and architecture)

(https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

### Installing and running Swingbench:

Download swingbench from:

(http://www.dominicgiles.com/downloads.html)

For the section, to run the workload on swingbench and compare between the different consumer groups, you would require an xml file and .sh file. Attached are the files, please download and save it in your local repository.

[Download .zip file](https://github.com/alpsteam/autonomous-labs/raw/master/lab-1/lab-1-resources.zip){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

## Autonomous Data Warehouse

### Provisioning an ADW service

In this section, you will provision a ADW instance using the UI capabilities of the service.

Note: The cloud credentials such as cloud account name, username and password, will be provided separately to this lab guide by the host. 


1.	Go to cloud.oracle.com and click on Sign In to login to your Oracle cloud account.

![I1](images/i1.png)

2.	Enter the Cloud Account Name provided by the host. In this example, the Cloud Account Name is gse00014613. Click Next

![I2](images/i2.png)

3.	On the login page, fill in the Username and Password for the cloud account. Click Sign In

![I3](images/i3.png)

4.	On the Dashboard page, click on the top-left MENU button, browse through the list of services and click the Autonomous Data Warehouse service.

![I4](images/i4.png)

5.	On the service home page, click Create Autonomous Database to create a new database instance.

![I5](images/i5.png)

6.	Enter the following information in the Create Autonomous Data Warehouse screen:
Workload Type: Select AUTONOMOUS DATA WAREHOUSE

![I6](images/i6.png)

Database Information:
Compartment - Demo
Display Name: ADW<no> - Choose a unique number if multiple attendees are allocated to the same cloud account

Database Name: ADW<no>
Note: Do not use any special characters as the provisioning wizard will not allow you to continue.
CPU Count: 2
Storage Capacity (TB): 1


![I7](images/i7.png)

Administrator Credentials:
Password: Welcome12345
Confirm Password: Welcome12345


![I8](images/i8.png)

License Type: 
Select SUBSCRIBE TO NEW DATABASE SOFTWARE LICENSES AND THE DATABASE CLOUD SERVICE


![I9](images/i9.png)

Click Create Autonomous Database to start provisioning the instance

![I10](images/i10.png)

7.	The new instance is listed on the service home page in the Provisioning State. Monitor it until the state changes to “Available”

![I11](images/i11.png)

8.	The full set of actions becomes available after the service has been provisioned, typically within approx. 5 minutes

![I12](images/i12.png)

## Connecting to ADW

In this section, you will go through the steps of accessing the credentials for connecting to your ADW instance with external clients, like SQL Developer.

1.	The first step in accessing the credentials is to connect to the DB Connection associated to your ADW instance. In the list of actions, click DB Connection


![I13](images/i13.png)

2.	Click Download

![I14](images/i14.png)

3.	Enter a password before downloading the wallet zip containing the credentials. This password will protect the sensitive data residing in the file. You can use Welcome12345 as the password and then re-type it for confirmation.

Click Download and save the file on your local computer.

![I15](images/i15.png)

4.	Open SQL Developer and Right click on Oracle Connections and click to create a new connection.

![I16](images/i16.png)

5.	Fill in the details to connect to the database as follows: 
             Connection Name: adw1_low 
Username: admin 
Password: Welcome12345 
Connection Type: Cloud Wallet 
Role: default 

Configuration File: Browse to the location of the zipped wallet and select it 
Service: adw1_low 

### If you’re connecting from behind a proxy, please enter the proxy host and port settings as directed by the instructor.

![I17](images/i17.png)

6.	If the test is successful, Save the connection and click Connect to access the database.
7.	Create a similar connection adw1_high


![I18](images/i18.png)

## Creating a new ADB user 

In this section, we will create a new ADB user.

1.	From the Oracle Cloud Infrastructure home page, click on the top-left MENU button and navigate to Identity -> Users.  This will display the list of users available on the cloud account.

2.	Click on Create User to create a user


![I19](images/i19.png)

3.	Fill in the following details to create a new user
Name: ADBuser<no> - Choose a unique number if multiple attendees are allocated to the same cloud account
Description: Autonomous Database User
Email: Please provide your email address


![I20](images/i20.png)

Click Create

## Generating Swift Password for Object Storage

Swift is the OpenStack object store service. The Swift Password is a special password that Oracle provides and is associated with your Console user login. These credentials allow you to access data stored in Object Storage.

1.	From the Oracle Cloud Infrastructure home page, click on the top-left MENU button and navigate to Identity -> Users. This will display the list of users available on the cloud account.


![I21](images/i21.png)

2.	In this example, the user is ADBuser1 created in the previous section

![I22](images/i22.png)

3.	On the user details page, on the left menu, click Auth Tokens


![I23](images/i23.png)

4.	To create a new Authentication Token, click Generate Token

![I24](images/i24.png)

5.	First you need to fill in a short description and then click on Generate Token

![I25](images/i25.png)

6.	The resulting password is a string of characters which together with the ADBuser1 will allow you to access the Object Storage. Click Copy and make sure you save it, as this password will no longer be accessible from the UI.

![I26](images/i26.png)

Note: You cannot have more than two tokens generated for a user. If the cloud account hosts more than two attendees, than the tokens should be shared. One option would be for the instructor to generate the token prior to the event and share it with attendees.

## Data Loading into Cloud Object Storage

In this section, you will prepare the Object Storage as an intermediate step to loading the data into the ADW/ATP instance. To do that, you will create a new storage bucket and load the data files into it.

Note: The datafiles are provided in the pre-requisites section. Please download the same and place it your local repository. 

1.	From the Oracle Cloud Infrastructure home page, click on the top-left MENU button and navigate to Object Storage -> Object Storage. This will display the list of buckets available on the Object Storage.

![I27](images/i27.png)

2.	Create a new storage bucket to store your data files. Click Create Bucket.

![I28](images/i28.png)

3.	Fill in ADB_DATA as the bucket name and click Create Bucket.

![I29](images/i29.png)

4.	Click the newly created bucket ADB_DATA

![I30](images/i30.png)

5.	Under the objects section, click Upload Object.

![I31](images/i31.png)

6.	Click Browse and navigate to the location where your data files are saved. (The data files will be provided by the instructor).

![I32](images/i32.png)

7.	Select the file exp_ssh_12M.dmp

![I33](images/i33.png)

8.	Click Upload Objects

![I34](images/i34.png)

9.	Similarly, rest of the files can be uploaded.

Data Loading from Cloud Object Storage to ADW using the SQL Developer Import Wizard

In this section you will load data from the Cloud Object Storage to ADW instance using SQL Developer data import wizard.
Beginning with SQL Developer 18.2 the data import wizard supports loading data from files stored in the Object Store straight into your Autonomous Data Warehouse.

1.	In SQL Developer, open the adw1_low connection and create the credentials to the Object Storage.

```shell
set define off 
begin 
DBMS_CLOUD.create_credential( 
credential_name => 'ADB_CRED', 
username => 'ADBuser1', 
password => '<Swift Password>' 
); 
end;
/

```

2.	In SQL Developer, open the adw1_high connection and create a user ssh and grant dwrole;

```shell
create user ssh identified by Welcome12345;
grant dwrole to ssh;

```

![I35](images/i35.png)

3.	Create a connection for user ssh with below details:

Connection Name: adw1_ssh
Username: ssh
Password: Welcome12345
Connection Type: Cloud Wallet
Configuration file: Browse to the location of the zipped wallet and select it
Service: adw1_high

Note: If you’re connecting from behind a proxy, please enter the proxy host and port settings as directed by the instructor.

Click Test to check the connection.

![I36](images/i36.png)

4.	If successful, Click Connect
5.	Click on View in the menu bar and select DBA


![I37](images/i37.png)

6.	Click on the + sign to add a new connection and select adw1_high from the connection list

![I38](images/i38.png)

7.	Expand the adw1_high connection and expand the Data Pump option 

![I39](images/i39.png)

8.	Right click on Import Jobs and click Data Pump Import Wizard

![I40](images/i40.png)

9.	On the import wizard, fill in the following details,

Job Name: import_ssh
Data or DDL: Data and DDL
Type of import: Schemas
Choose Input files -
Credentials or Directories: Select CREDENTIAL: ABD_CRED
File Names and URI: (https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/gse00014613/ADB_DATA/exp_ssh_12M.dmp)


![I41](images/i41.png)

Click Next
The above file names and URI needs to be built by you. 
Login to the object storage on cloud console. Move in to Demo compartment. Select ADB_DATA bucket created earlier.


![I42](images/i42.png)

Inside the ADB_DATA bucket, click on the menu option beside the object exp_ssh_12M.dmp. Click on View Object Details.

![I43](images/i43.png)

The details will pop out a window with the details of the object. Copy the URL Path(URI) and save it. It will be as below:
(https://objectstorage.us-ashburn-1.oraclecloud.com/n/gse00014613/b/ADB_DATA/o/exp_ssh_12M.dmp)
Construct the swift URL link as below:
(https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/<<identity domain>>/<<bucket>>/<<object_name>>)
Replace the identity domain, bucket, object_name from the URL copied above.
The Swift URL would look like: (https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/gse00014613/ADB_DATA/exp_ssh_12M.dmp)
Use the newly constructed Swift URL as File Names and URI.

10.	Select the SSH schema

![I44](images/i44.png)

Click Next

11.	Do not add anything in remapping tab. Click Next


![I45](images/i45.png)

12.	Do not change anything on the options tab. Click Next

![I46](images/i46.png)

13.	Keep the schedule option intact. Click Next

![I47](images/i47.png)

14.	On the summary page, click Finish

![I48](images/i48.png)

15.	On the Import Jobs session, Data pump import can be monitored.

![I49](images/i49.png)

16.	Once the status changes to “NOT RUNNING”, connect to adw1_ssh and execute

```shell
Select count(*) from sales;
```

![I50](images/i50.png)

## Connecting to Swingbench

Swingbench is a free load generator (and benchmarks) designed to stress test an Oracle database.

1.	Launch the swingbench client 


![I51](images/i51.png)

2.	Select Sales_History as the Configuration File and click OK

![I52](images/i52.png)

3.	Fill in the following details to connect ssh user in ADW instance

Username: ssh
Password: Welcome12345
Connect String: adw1_high
Credential File: Browse to the wallet file generated for ADW instance

Note: We would first connect to the “adw1_high” consumer group with highest resource utilization.

![I53](images/i53.png)

Click Connect
4.	On successful connection, a message will pop out. Click OK


![I54](images/i54.png)

5.	In the upper right section, we have a mix of analytical query that are executed by a number of users. Example, roll outs, moving averages, top lists etc. You can switch the queries ON/OFF and change the load ratios.

![I55](images/i55.png)

6.	Once connected, click on the Properties tab. Click on the + symbol in the Connection Initialisation Commands and enter

Alter session set sql_trace = false


![I56](images/i56.png)

7.	On the Configuration tab, Select the number of users as 4 to bombard the instance with analytical queries. Click on the Run sign to start the benchmarking.

![I57](images/i57.png)

8.	The transaction will start to ramp up. The below screenshot is sample output at a certain point in time.

![I58](images/i58.png)

The chart shows the information about transactions per minute, transactions per second, response time and the DML operations being executed for 4 users. The current average time shows as ~5 seconds. 

Now we will look at the benchmarking chart with 8 users. Increase the count of users to 8.


![I59](images/i59.png)

Below is a screenshot of chart taken at a certain point in time.

![I60](images/i60.png)

You can see that with the addition of more users, 1 OCPU (and amount of memory associated) is insufficient. Average response time has gone up and the number of transactions per minutes have reduced.
To handle this workload, let us add more CPU  (and associated memory) to the ADW instance.
ADW allows the users to scale up compute and storage individually without any downtime. 

9.	Connect to the ADW1 instance. Click on Scale Up/Down


![I61](images/i61.png)

10.	Increase the CPU count from 1 to 3 OCPUs. Click Update

![I62](images/i62.png)

You also have the option to auto scale where the resources will be auto allocated up to three times the base count to meet the workload. As part of this workshop, we won’t enable the auto scaling option.

11.	Scaling is in progress


![I63](images/i63.png)

Once the scaling is complete, we will now review the Swingbench benchmark with 3 OCPUs and 8 users.
The below screenshot has been taken a certain point in time.

![I64](images/i64.png)

We could see the response time have also come down drastically. The number of transactions is mounting again. 

Note: Please scale down the CPU to 1 again to save resources.

## Comparing the consumer groups

High, Medium and Low are the three different consumer groups associated with an Autonomous Database instance.

The basic characteristics of the consumer groups are as below:

HIGH –
•	Highest resources, lowest concurrency
•	Queries run in parallel
MEDIUM –
•	Less resources, higher concurrency
•	Queries run in parallel 
LOW –
•	Least resources, highest concurrency
•	Queries run serially

Let us compare the difference in performance between the three consumer groups using Swingbench.
1.	Please use the xml file and the sh file (provided in pre-requisites) to start the swingbench for high, medium and low simultaneously.

2.	Create a repository SB_Configs under /home/oracle/ as below:

```shell
[oracle@swingbench-client ~]$ pwd
/home/oracle
[oracle@swingbench-client ~]$ mkdir SB_Configs

```

3.	Place the files under this repository
4.	Open the ADW1_SSH_minibench.sh file and make the following changes

```shell
export SB_HOME=<<Location of Swingbench home>>
export SB_CONF=<<Location of the xml file or SB_Configs directory>>

```

5.	Open the ADW1.xml file and change the password of ssh user in the file and the location of wallet file.

```shell
<UserName>ssh</UserName>
<Password>Welcome12345</Password>
<ConnectString>ADW1_high</ConnectString>
<DriverType>Oracle jdbc Driver</DriverType>
<CloudCredentailsFile>/home/oracle/wallet_ADW1.zip</CloudCredentailsFile>

```

Save the changes.

6.	Execute the ADW1_SSH_minibench.sh script to start Swingbench for all the three consumer groups

```shell
./ADW1_SSH_minibench.sh
```

7.	Arrange the 3 windows so they can easily be compared. Below is the sample screenshot taken at a point in time.

![I65](images/i65.png)

## Monitoring your ADW instance

You can use the ADW service console to monitor the performance of your ADW instance. Service console provides dashboards to monitor the real-time and historical CPU and storage utilization, and database activity like the number of running or queued statements. It also provides Real-Time SQL Monitoring to look at current and past long running SQL statements in your instance and allows you to cancel long running queries or set thresholds for ADW to automatically cancel them for you.
1.	Connect to the ADW1 instance 
2.	Click on Service Console


![I66](images/i66.png)

3.	This page shows you your provisioned storage capacity and actual storage usage as of now. It also shows you the CPU utilization, number of SQL statements, and average SQL response time for the past 8 days by default.

![I67](images/i67.png)

To view more detailed information on database activity click the Activity tab on the top right corner of the page. The Activity page shows you real-time information on database wait events, CPU utilization, number of running and queued statements in each database service for the past hour.

![I68](images/i68.png)

In this example, you see that current CPU utilization is around 100%, there are around 20 statements running and around 18 statements waiting in the queue. These charts give you information about whether you want to scale up/down your system or not. For example, if you see that a lot of statements are waiting in the queue you might want to scale up your instance so that more users can run queries concurrently.

You can click the Time Period button to see historical activity if you want to see data earlier than the past hour.


![I69](images/i69.png)

This page allows you to select a time period using the calendar. By default, ADW stores performance data for the past 8 days.

Click the Monitor SQL tab to look at the SQL statements in your instance. This page shows you a list of long running statements that are running or were completed.  You can see if the statement is running, completed, or queued, the start and end time, duration, etc…


![I70](images/i70.png)

To download an active real-time SQL Monitor report for a statement, select that statement and click the Download Report button. This will save a local SQL Monitor report to your client machine.

To see the detailed execution plan for a statement, select that statement and click the Show Details button. This shows you more detailed information on the statement, like the full SQL text, database activity, IO activity, etc…


![I71](images/i71.png)

Click on the Plan Statistics and Parallel buttons to see the detailed execution plan and parallelism activity.

## Autonomous Transaction Processing

### Provisioning an ATP service

1.	On the same cloud account, click the top-left MENU button, browse through the list of services and click the Autonomous Transaction Processing service. 

![I72](images/i72.png)

2.	On the service home page, click Create Autonomous Transaction Processing Database

![I73](images/i73.png)

3.	Enter the following information in the Create Autonomous Transaction Processing screen:
Workload Type: Select Autonomous Transaction Processing


![I74](images/i74.png)

Database Information:
Compartment: Demo
Display Name: ATP<no> - Choose a unique number if multiple attendees are allocated to the same cloud account
Database Name: ATP<no>

Note: Do not use any special characters as the provisioning wizard will not allow you to continue.

CPU count: 2
Storage Capacity(TB): 1

![I75](images/i75.png)

Administrator Credentials:
Password: Welcome12345
Confirm Password: Welcome12345


![I76](images/i76.png)

License Type:
Select SUBSCRIBE TO NEW DATABASE SOFTWARE LICENSES AND THE DATABASE CLOUD SERVICE

![I77](images/i77.png)

Click Create Autonomous Database to start provisioning the instance.

![I78](images/i10.png)

4.	The new instance is listed on the service home page in the Provisioning state. Monitor it until the state changes to Available.

![I78](images/i78.png)

5.	Click the ATP1 instance to see more details and actions associated to it.

![I79](images/i79.png)

## Connecting to ATP

In this section, you will go through the steps of accessing the credentials for connecting to your ATP instance with external clients, like SQL Developer.

8.	The first step in accessing the credentials is to connect to DB Connection associated to your ATP instance. In the list of actions, click DB Connection.


![I80](images/i80.png)

9.	Click on Download.

![I81](images/i81.png)

10.	Enter a password before downloading the wallet zip containing the credentials. This password will protect the sensitive data residing in the file. You can use Welcome12345 as the password and then re-type it for confirmation.

Click Download and save the file on your local computer.


![I82](images/i82.png)

11.	Open SQL Developer and click to create a new connection.

![I83](images/i83.png)

12.	Fill in the details to connect to the database as follows:

Connection Name: atp1_low
Username: admin
Password: Welcome12345
Connection Type: Cloud Wallet
Role: Default
Configuration File: Browse to the location of the zipped wallet and select it
Service: atp1_low

Note: If you’re connecting from behind a proxy, please enter the proxy host and port settings as directed by the instructor.

Click Test to check the connection.

![I84](images/i84.png)

13.	If the test is successful, Save the connection and click Connect to access the database.
14.	Create a similar connection with atp1_high


![I85](images/i85.png)  

## Creating new ADB user 

In case you have already created the ADB user in the ADW section, please skip this. Else refer here to create a new ADB user.

## Generating a Swift Password for Object Storage
In case you have already generated the swift password for the ADB user in the ADW section, please skip this. Else refer here to generate a swift password.

## Data Loading to Cloud Object Storage
In case you have already created a bucket in the ADW section, please skip this. Else refer here to create a new bucket and upload the files onto it.

## Data Loading from Cloud Object Storage to ATP using the SQL Developer Import Wizard

In this section you will load data from the Cloud Object Storage to ATP instance using SQL Developer data import wizard.
Beginning with SQL Developer 18.2 the data import wizard supports loading data from files stored in the Object Store straight into your Autonomous Transaction Processing.

1.	In SQL Developer, open the atp1_low connection and create the credentials to the Object Storage.

```shell
set define off 
begin 
DBMS_CLOUD.create_credential( 
credential_name => 'ADB_CRED', 
username => 'ADBuser1', 
password => '<Swift Password>' 
); 
end;
/

```

2.	In SQL Developer, open the atp1_high connection and create a user soe and grant dwrole;

```shell
Create user soe identified by Welcome12345;
Grant dwrole to soe;

```


![I86](images/i86.png)

3.	Create a connection for user soe with below details:
Connection Name: atp1_soe
Username: soe
Password: Welcome12345
Connection Type: Cloud Wallet
Role: Default
Configuration file: Browse to the location of the zipped wallet and select it
Service: atp1_high

Click Test to check the connection

![I87](images/i87.png)

4.	If successful, Click Connect
5.	Click on View in the menu bar and select DBA



![I88](images/i88.png)

6.	Click on the + sign to add a new connection and select atp1_high from the connection list

![I89](images/i89.png)

7.	Expand the atp1_high connection and expand the Data Pump option 

![I90](images/i90.png)

8.	Right click on Import Jobs and click Data Pump Import Wizard

![I91](images/i91.png)

9.	On the import wizard, fill in the following details,
Job Name: import_soe
Data or DDL: Data and DDL
Type of import: Schemas
Choose Input files -
Credentials or Directories: Select CREDENTIAL: ABD_CRED
File Names and URI: (https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/gse00014613/ADB_DATA/exp_soe.dmp)


![I92](images/i92.png)

Click Next

The above file names and URI needs to be built by you. 
Login to the object storage on cloud console. Move in to Demo compartment. Select ADB_DATA bucket created earlier.


![I93](images/i93.png)

Inside the ADB_DATA bucket, click on the menu option beside the object exp_soe.dmp. Click on Details.

![I94](images/i94.png)

The details will pop out a window with the details of the object. Copy the URL Path(URI) and save it. It will be as below:
(https://objectstorage.us-ashburn-1.oraclecloud.com/n/gse00014613/b/ADB_DATA/o/exp_soe.dmp)
Construct the swift URL link as below:
https://swiftobjectstorage.us-ashburn-1.oraclecloud.com/v1/<<identity domain>>/<<bucket>>/<<object_name>>
Replace the identity domain, bucket, object_name from the URL copied above.
Use the newly constructed Swift URL as File Names and URI.
10.	Select the SOE schema


![I95](images/i95.png)

Click Next

11.	Do not add anything in remapping tab. Click Next


![I96](images/i96.png)

12.	Do not change anything on the options tab. Click Next

![I97](images/i97.png)

13.	Keep the schedule option intact. Click Next

![I98](images/i98.png)

14.	On the summary page, click Finish

![I99](images/i99.png)

15.	Click on the Import Jobs session, Data pump import can be monitored

![I100](images/i100.png)

16.	Once the status changes to “NOT RUNNING”, connect to atp1_soe and execute

```shell
select count(*) from orders;
```

![I101](images/i101.png)

## Connecting to Swing bench

Swingbench is a free load generator (and benchmarks) designed to stress test an Oracle database.

1.	Launch the swingbench client 


![I102](images/i102.png)

2.	Select SOE_Server_Side_V2 as the Configuration File and click OK

![I103](images/i103.png)

3.	Fill in the following details to connect soe user in ATP instance

Username: soe
Password: Welcome12345
Connect String: atp1_high
Click on Connect to Oracle cloud Service
Credential File: Browse to the wallet file generated for ADW instance

Note: We would first connect to “atp1_high” consumer group for highest resource utilization.


![I104](images/i104.png)

4.	On successful connection, a message will pop out. Click OK

![I105](images/i105.png)

5.	In the upper right section, we have a mix of transactional transactions and tactical queries such as, adding of customers, updating customer information, adding new order, sales representative query etc. You can switch the queries ON/OFF and change the load ratios.

![I106](images/i106.png)

6.	Change the number of users to 4 and click on Run sign to bombard the instance with transactional queries. This workload has loads of DML operations carried on the database such inserts, updates, deletes.

![I107](images/i107.png)

7.	The transaction will start to ramp up. The below screenshot is sample output at a certain point in time.

![I108](images/i108.png)

The chart shows the information about transactions per minute, transactions per second, response time and the DML operations being executed for 4 users. The current average time shows as ~13 milliseconds. 

Now we will look at the benchmarking chart with 8 users. Increase the count of users to 8.


![I109](images/i109.png)

Below is a screenshot of chart taken at a certain point in time.

![I110](images/i110.png)

You can see that with the addition of more users, 1 OCPU () is insufficient. Average response time has gone up and the number of transactions per minutes have reduced.

To handle this workload, let us add more CPU (and associated memory) to the ATP instance.

ATP allows the users to scale up compute and storage individually without any downtime. 

8.	Connect to the ATP1 instance. Click on Scale Up/Down


![I111](images/i111.png)

9.	Increase the CPU count from 1 to 3 OCPUs. Click Update

![I112](images/i112.png)

You also have the option to auto scale where the resources will be auto allocated up to three times the base count to meet the workload. As part of this workshop, we wont enable the auto scaling option.
10.	Scaling is in progress


![I113](images/i113.png)

Once the scaling is complete, we will now review the Swingbench benchmark with 3 OCPUs and 8 users.
The below screenshot has been taken a certain point in time.


![I114](images/i114.png)

We could see that the response time have also come down drastically. The number of transactions is mounting again. 

Note: Please scale down the CPU to 1 again to save resources.

## Comparing the consumer group

High, Medium and Low are the three different consumer groups associated with an Autonomous Database instance.

The basic characteristics of the consumer groups are as below:

HIGH –
•	Highest resources, lowest concurrency
•	Queries run in parallel
MEDIUM –
•	Less resources, higher concurrency
•	Queries run in parallel 
LOW –
•	Least resources, highest concurrency
•	Queries run serially


Let us compare the difference in performance between the three consumer groups using Swingbench.

1.	Please use the xml file and the sh file (provided in pre-requisites) to start the swingbench for high, medium and low simultaneously.

2.	Create a repository SB_Configs under /home/oracle/ as below:

```shell
[oracle@swingbench-client ~]$ pwd
/home/oracle
[oracle@swingbench-client ~]$ mkdir SB_Configs

```

3.	Place both the files under this repository
4.	Open the ATP1_SSH_minibench.sh file and make the following changes


```shell
export SB_HOME=<<Location of Swingbench home>>
export SB_CONF=<<Location of the xml file or SB_Configs directory>>

```

5.	Open the ATP1.xml file and change the password of soe user in the file and the location of wallet file.

```shell
<UserName>soe</UserName>
<Password>Welcome12345</Password>
<ConnectString>ATP1_high</ConnectString>
<DriverType>Oracle jdbc Driver</DriverType>
<CloudCredentailsFile>/home/oracle/wallet_ATP1.zip</CloudCredentailsFile>

```

Save the changes.

6.	Execute the ATP1_SSH_minibench.sh script to start Swingbench for all the three consumer groups

```shell
./ATP1_SSH_minibench.sh
```

7.	Arrange the 3 windows so they can easily be compared. Below is the sample screenshot taken at a point in time.

![I115](images/i115.png)

## Monitoring your ATP instance

You can use the ATP service console to monitor the performance of your ATP instance. Service console provides dashboards to monitor the real-time and historical CPU and storage utilization, and database activity like the number of running or queued statements. It also provides Real-Time SQL Monitoring to look at current and past long running SQL statements in your instance and allows you to cancel long running queries or set thresholds for ATP to automatically cancel them for you.
1.	Connect to the ATP1 instance 
2.	Click on Service Console


![I116](images/i116.png)

3.	This page shows you your provisioned storage capacity and actual storage usage as of now. It also shows you the CPU utilization, number of SQL statements, Number of OCPs allocated and average SQL response time for the past 8 days by default.

![I117](images/i117.png)

To view more detailed information on database activity click the Activity tab on the top right corner of the page. The Activity page shows you real-time information on database wait events, CPU utilization, number of running and queued statements in each database service for the past hour.

![I118](images/i118.png)

In this example, you see that current CPU utilization is around 100%, there are around 20 statements running and around 18 statements waiting in the queue. These charts give you information about whether you want to scale up/down your system or not. For example, if you see that a lot of statements are waiting in the queue you might want to scale up your instance so that more users can run queries concurrently.

You can click the Time Period button to see historical activity if you want to see data earlier than the past hour.

![I119](images/i119.png)

This page allows you to select a time period using the calendar. By default, ATP stores performance data for the past 8 days.

Click the Monitor SQL tab to look at the SQL statements in your instance. This page shows you a list of long running statements that are running or were completed.  You can see if the statement is running, completed, or queued, the start and end time, duration, etc…


![I120](images/i120.png)

To download an active real-time SQL Monitor report for a statement, select that statement and click the Download Report button. This will save a local SQL Monitor report to your client machine.

To see the detailed execution plan for a statement, select that statement and click the Show Details button. This shows you more detailed information on the statement, like the full SQL text, database activity, IO activity, etc…

![I121](images/i121.png)


































## Microservices and Oracle Database

### Introduction to Microservices

Microservices have arguably become one of the most important architectural styles in software engineering. They can enable hyper-scaling, polyglot and fault-tolerant distributed software systems.

If you are not familiar with microservices be sure to check out [Martin Fowler's overview of microservices](https://martinfowler.com/articles/microservices.html). In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. 

![Oracle DB with Microservices](images/monolith-vs-microservices.png)

While independently deployable and scalable microservices can offer significant advantages compared to big monoliths, they may also introduce major challenges (consistancy, managibility, complexity to handle failure, etc).

### How does data management fit in?

Microservices typically prefer letting each service manage its own database, either different instances of the same database technology, or entirely different database systems - an approach called Polyglot Persistence. You can use polyglot persistence in a monolith, but it appears more frequently with microservices.

Such decentralized data management can have considerable downsides and risks:

- Different microservices might require different types of data structures (relational/SQL, non-relational/NoSQL, graph-based, document-based etc.)
- This can lead to a dispursed database landscape with many different technologies (e.g. MySQL, MongoDB, Neo4j etc.)
- The resulting overhead in maintainance, patching and managibility can be huge
- It becomes harder to secure the system as a whole, with many different database technologies involved
- Scalability may be difficult in situations where [eventual consistancy](https://martinfowler.com/articles/microservice-trade-offs.html#consistency) is not acceptable
- Additional considerations like high availabity, back-up strategies have not been made

The process of managing potentially hundreds, or thousands, of individual database instances within Docker containers, can become impractical and costly.

### Using a data persitance layer with microservices

In order to solve these issues we can introduce a data persistance layer. For every microservice that requires a persistant database, the data management layer will provide a database for the microservice.

This means that each microservice gets alligned with its own containerized database.

![Oracle DB with Microservices](images/oracle-db-microservices.png)

A data management layer to support a microservice-based application layer can offer the following advantages:

- Managebility is simplified
- It is much easier to secure the system by securing the data management layer
- Patching is simplified. All database containers can be kept at a similar patch level and patches can be applied in batches
- Back-up strategies and high availability can be handled at the persistance layer

### Oracle Autonomous Database as a data management layer for microservices

These advantages are amplified when using a managed database cloud service. 

Oracle Autonomous Database Cloud Service is an ideal data management platform to support a microservice-based architecture in the cloud for these reasons:

- A database can be provisioned manually or per infrastructure automation (API, Terraform, CLI, etc) in minutes
- The database is designed to secure itself by default. It is serverless and offers no OS or root access for users.
- No patching overhead, database patches are applied automatically.
- The autonomous database instance can scale elastically up/down from 1-128 CPU cores, without any downtime.
- Autoscaling can optionally be enabled.
- Back-ups are automatically created and managed
- Databases can be cloned (and later deleted) very easiliy for testing purposes
- Managed infrastructe in three data centres (availability domains) per region
- Support for lots of data structures: Oracle DB supports relational data, JSON, XML, spatial, graph, RDF,  text, binary, object stores, HDFS, Kafka and NoSQL stores

![Oracle DB with Microservices](images/oracle-db-as-data-platform.png)

- If there is a need to run analytical queries Oracle Autonomous Database can also run queries across different database containers.

# Lab guide

## Access lab resources

We have compiled all assets into a Docker container, so there is no need to download any lab resources. If you want to review the lab resources anyway you can clone the Git repository or view the resources on Github.

Viewing or downloading the lab resources **is optional**.

[View source code](https://github.com/alpsteam/autonomous-labs/tree/master/lab-2/lab-2-resources){: .btn .fs-5 .mb-4 .mb-md-0 }

```shell
git clone https://github.com:alpsteam/autonomous-labs.git
cd autonomous-labs/lab-2/lab-2-resources/
```

## Setup of Autonomous Database

Login to your Oracle Cloud Account and head to `Autonomous Transaction Processing` from the hamburger menu in the top left.

### Create Database in OCI Console

Create an ATP instance, for our lab make sure to **name your database `atp`** exactly! Click the video thumbnail below for detailed instructions.

<a href="https://www.youtube.com/watch?feature=player_embedded&v=a38S_NY8WNk
" target="_blank"><img src="https://img.youtube.com/vi/a38S_NY8WNk/0.jpg" 
 border="10" /></a>

### Create Schema and add Test Data

Open Service Console for Autonomous Database in OCI Console, go to "Development" and then open "SQL Developer Web", login with the admin user you setup just before.

Paste the SQL script [load_sql_table.sql](https://github.com/alpsteam/autonomous-labs/blob/master/lab-2/lab-2-resources/src/main/resources/load_sql_table.sql) into the SQL Developer Web console. Paste the content of [product-catalog.json](https://github.com/alpsteam/autonomous-labs/blob/master/lab-2/lab-2-resources/src/main/resources/product-catalog.json) when prompted.

<a href="https://www.youtube.com/watch?feature=player_embedded&v=SnukS-89csE" target="_blank"><img src="https://img.youtube.com/vi/SnukS-89csE/0.jpg" 
 border="10" /></a>


## Step by Step Guide

For our lab we need tools like Java, Maven, Oracle Cloud Infrastructure CLI (OCI CLI) and more. We have created a preconfigured Docker container for this lab, so the tools do not need to be installed.

### Run Docker Image

Since we will also build a Docker container for our lab, we need to run Docker inside Docker. This requires some specific startup flags. Don't use these flags in a production environment or outside of a safe lab environment.

Mac/Linux:

```shell
docker run -ti --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock maxjahn/priceservice-standalone:1.1
```

Windows:

```shell
docker run -ti --rm --privileged -v //var/run/docker.sock:/var/run/docker.sock maxjahn/priceservice-standalone:1.1
```

While the Docker container is downloading you can already continue with [https://alpsteam.github.io/autonomous-labs/lab-2/lab-2.html#oci-cli-setup](OCI CLI Setup) and come back later.

### Get the code 

After the Docker container has been started, run a `git clone` inside of the Docker container to get the lab resources and change directory.

```
git clone https://github.com/alpsteam/autonomous-labs.git
cd autonomous-labs/lab-2/lab-2-resources/
```

### OCI CLI setup

We are going to use the OCI CLI to interact with Oracle Cloud. The CLI is already installed within the Docker container, but in order to link the CLI with your account the `oci_cli_setup.sh` script needs to be run. Every resource in Oracle Cloud has an `OCID` and we need to find the `user OCID` as well as the `tenancy OCID` to continue.

Copy and save your `user OCID` by navigating to your profile.

![Find user OCID](images/find-user-ocid.png)

Copy and save your `tencany OCID` by navigating to your tenancy overview page.

![Find tenancy OCID](images/find-tenancy-ocid.png)

Then run
```shell
chmod u+x src/main/resources/oci_cli_setup.sh
./src/main/resources/oci_cli_setup.sh
```
and hit `Enter` to choose the standard location for the OCI CLI config. Afterwards enter all the necessary OCIDs. You can choose `eu-frankfurt-1` as region. Then, hit `Enter` a couple of time to generate a new keypair in the standard location without password. Add the public key you get as output from the script as API key in OCI console.

Copy the public key.

![Copy public key](images/copy-public-key.png)

Navigate to your user profile, in the bottom left you will find `API Keys`, hit `Add Public Key` and paste your key.

![Add public API key](images/add-public-api-key.png)

That's it, you have now configured the OCI CLI to work with your account.

### Get Autonomous Database Wallet via OCI CLI

Next, we will use the OCI CLI to download the Autonomous DB wallet (which contains all credentials and connection strings to connect to the database). Therefor, we need the `Autonomous Database OCID`.

![Find ATP OCID](images/find-atp-ocid.png)

Execute the `get_wallet.sh` script and enter the `Autonomous Database OCID` and the database password that you previously chose.

```shell
chmod u+x src/main/resources/get_wallet.sh
./src/main/resources/get_wallet.sh
```

### Build Service

Next, we will build the Java app. Add the local resources:

```shell
mvn install:install-file -Dfile=src/main/libs/ojdbc10.jar -DgroupId=com.oracle.jdbc -DartifactId=ojdbc10 -Dversion=19.3.0 -Dpackaging=jar && \
mvn install:install-file -Dfile=src/main/libs/ucp.jar -DgroupId=com.oracle.jdbc -DartifactId=ucp -Dversion=19.3.0 -Dpackaging=jar && \
mvn install:install-file -Dfile=src/main/libs/osdt_core.jar -DgroupId=com.oracle.jdbc -DartifactId=osdt_core -Dversion=19.3.0 -Dpackaging=jar && \
mvn install:install-file -Dfile=src/main/libs/osdt_cert.jar -DgroupId=com.oracle.jdbc -DartifactId=osdt_cert -Dversion=19.3.0 -Dpackaging=jar && \
mvn install:install-file -Dfile=src/main/libs/oraclepki.jar -DgroupId=com.oracle.jdbc -DartifactId=oraclepki -Dversion=19.3.0 -Dpackaging=jar 
```
and build the app (some tests will be performed too).
```
mvn package
```

### Test Service locally


```
java -jar target/priceservice.jar &

curl -X GET http://localhost:8080/price

curl -X GET http://localhost:8080/price/1001
```

### Prepare deployment with Docker & Kubernetes


```shell
cd target && sudo docker build -t priceservice:1.0 .
```

Done! You have now built a small Helidon microservice which is connected to an Autonomous Database instance.

## Deploy to Kubernetes

This lab assumes that you have a Kubernetes cluster up and running. You can easily create a managed K8s cluster with [OKE in Oracle Cloud](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengoverview.htm).

```
kubectl create namespace lab
kubectl create secret generic db-user-pass --from-file=./wallet.zip --namespace=lab
kubectl apply -f kuberentes.yml --namespace=lab
```

Once the application is deployed you can create a proxy to access the API. Check the name of the deployed service with `kubectl get services` and then forward the ports.

```
kubectl port-forward priceservice-b9bb6d6d5-2dfsn 8080:8080 --namespace=lab
```
The API will be available at `http://localhost:8080/price`.

## Next steps

This lab can easily be extended by deploying everything with a CI/CD pipeline. We've already set up the corresponding `wercker.yml` file.


