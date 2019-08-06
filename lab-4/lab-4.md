---
layout: default
title: Lab 4 Using Oracle in Database Machine Learning
---

# 🚀 Lab 4: Using Oracle in Database Machine Learning

## Table of contents

1. [Prerequisites](#prerequisites)
2. [Introduction to your lab](#introduction-to-your-lab)
3. [Lab guide](#lab-guide)
   1. [Importing data into Oracle Cloud Infrastructure Object Storage](#import-oci)
   2. [Setting up Autonomous Data Warehouse](#setup-adw)
   3. [Importing data into Autonomous Data Warehouse](#import-adw)
   4. [Setup Oracle Machine Learning](#setup-oml)
4. [Introduction into k-means algorithm](#Introduction-k-means)

# 1. Prerequisites

- An Oracle Cloud Account
- Right permissions
- Access to Oracle Cloud Console
- About 4-8h to walk through the Lab
- Interest in Machine Learning concepts

# 2. Introduction to your lab

The goal of this lab is to show the user how to setup a data science project using managed services provided
in the Oracle Cloud. We will use [Oracle Autonomous Data Warehouse (ADW)](https://cloud.oracle.com/en_US/datawarehouse) to store our data and run the machine learning
algorithms, as well as doing all the data wrangling. ADW is self-driving, self-securing, self-repairing and self-scaling
database that is run as managed service in the Oracle Cloud. With [Oracle Machine Learning](https://www.oracle.com/technetwork/database/options/oml/overview/index.html) it also offers a serverless
environment to provision and run Zeppelin Notebooks and use them with to 30+ parallel, scalable in-database implementations
of machine learning algorithms.
To setup the environment we will use [SQL Developer Web](https://docs.oracle.com/en/database/oracle/sql-developer-web/18.1/sdweb/sdw-about.html#GUID-AF7601F9-7713-4ECC-8EC9-FB0296002C69), which is a web based version of SQL Developer and acts a a web based user interface
to manage the database. Data will be imported via [Oracle Cloud Object Storage](https://docs.cloud.oracle.com/iaas/Content/Object/Concepts/objectstorageoverview.htm).
 

![Architecture Overview](/lab-4/Images/architecture_cut.jpg)

# 3. Lab guide

## <a name="import-oci"></a>Importing data into Oracle Cloud Infrastructure Object Storage

Oracle Cloud Object Storage will be used as staging area to hold our data before we import it into ADW.
Oracle Cloud Object Storage is a highly scalable service which can be used to store structured and unstructered data.
First Login in into the Oracle Cloud Infrastructure web interface and select Object Storage from the left menu.

![Architecture Overview](/lab-4/Images/step-1-1.png)

To create a new bucket, which is kind of a folder to hold files, press the "Create Bucket" button. In the following
window enter a bucket name e.g. "adw-lab4", leave all other values at the default and press "Create Bucket".

![Architecture Overview](/lab-4/Images/step-1-2.png)

Once the bucket is created select it from the Buckets Overview Window.

![Architecture Overview](/lab-4/Images/step-1-3.png)

First make sure that you downloaded the CSV file with the data. You can find it in the git repository in the data folder or under [Download CSV File](https://alpsteam.github.io/autonomous-labs/lab-x/Data/OAC_Transactions_trim.csv)
In the following screen press "Upload Object" under Objects, select your file, press "Upload Objects" and then "Close" to upload your file into the newly created bucket.

![Architecture Overview](/lab-4/Images/step-1-4.png)

The final view of the bucket should show the uploaded file similar to this image.

![Architecture Overview](/lab-4/Images/step-1-5.png)

Now note done the URL to access the file in Oracle Cloud Object storage for me this is 'https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/orasealps/b/autonomous-lab/o/OAC_TRANSACTIONS_trim.csv'.

[![Get Object Storage URL](http://img.youtube.com/vi/bFw6PrdgOv8/0.jpg)](http://www.youtube.com/watch?v=bFw6PrdgOv8 "Object Storage URL")

Finally we need to create an Auth-Token and note down our username as we need both to access the uploaded file later from ADW.
Your username will be something like ´oracleidentitycloudservice/email@domain.com´ and your token will be a random string.

[![Create Auth Token](http://img.youtube.com/vi/aU1gAZ7oeUA/0.jpg)](http://www.youtube.com/watch?v=aU1gAZ7oeUA "OCI Create Auth Token")

At the end of this step make sure you noted down the following three values. We will need them later on.

| What        | Example           |
| ------------- |:-------------------------------------------:|
| OCI Username  | oracleidentitycloudservice/email@domain.com |
| Auth Token    | gq[Jd4>tppwK}U>kBepg                        |
| File URL      | https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/orasealps/b/autonomous-lab/o/OAC_TRANSACTIONS_trim.csv     |

## <a name="setup-adw"></a>Setting up Autonomous Data Warehouse

Login into the OCI console and follow the steps in the following video to provision an ADW instance.
[![Provision ADW](http://img.youtube.com/vi/eQJT-5by4Lg/0.jpg)](http://www.youtube.com/watch?v=eQJT-5by4Lg "OCI Provision ADW")




## <a name="import-adw"></a>Importing data into Autonomous Data Warehouse

Now that ADW has been setup and the data has been uploaded to Oracle Cloud Object Storage, the data can be
imported into ADW. To import data we will be using SQL Developer Web. SQL Developer Web can be accessed from the
ADW service console in OCI. For now use the ADW admin account name and credentials you created during the ADW setup to login
to SQL Developer Web.

[![Access SQL Developer Web](http://img.youtube.com/vi/AWDZsFiADOY/0.jpg)](http://www.youtube.com/watch?v=AWDZsFiADOY "Access SQL Developer Web")

Now open a new worksheet and run the following code to create a new user, with the required permissions.
We will use this user to upload the data and access Oracle Machine Learning.

```sql

CREATE USER analyst IDENTIFIED BY "Pw4lab42019!";
 
GRANT CONNECT, resource TO analyst;
 
ALTER USER analyst QUOTA UNLIMITED ON DATA; -- this part is important
GRANT UNLIMITED TABLESPACE TO analyst;
GRANT ALL on DBMS_CLOUD to analyst;
GRANT ALL on DIRECTORY DATA_PUMP_DIR to analyst;
 
BEGIN -- this part is so I can login as HR via SQL Developer Web
    ords_admin.enable_schema (
        p_enabled               => TRUE,
        p_schema                => 'ANALYST',
        p_url_mapping_type      => 'BASE_PATH',
        p_url_mapping_pattern   => 'lab-alias', -- this flag says, use 'lab-alias' in the URIs for HR
        p_auto_rest_auth        => TRUE   -- this flag says, don't expose my REST APIs
    );
    COMMIT;
END;

```

Now copy the URL you see in the browser tab for me this is 'https://js7elhijapblzqx-autonlab.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/_sdw/?nav=worksheet' .
Replace the 'admin' part of the URL with the value of 'p_url_mapping_pattern' from the former SQL statement. For me I replace 'admin' with 'lab-alias'.
The URL becomes:

https://js7elhijapblzqx-autonlab.adb.eu-frankfurt-1.oraclecloudapps.com/ords/admin/_sdw/?nav=worksheet =>
https://js7elhijapblzqx-autonlab.adb.eu-frankfurt-1.oraclecloudapps.com/ords/lab-alias/_sdw/?nav=worksheet

Use the new URL to access SQL Developer Web as analyst user, using "analyst" as username and the password you set via the SQL statement
for me this is 'Pw4lab42019'.

Now we can create a table which we will later populate with the data from the CSV file. Make sure you are logged in as
'analyst' user in SQL developer web and run the following SQL statement. NOTE: if you change the table here you will
to have change it as well in the following SQL and the Zeppelin notebooks you will import later on.

```sql

CREATE TABLE OAC_TRANSACTIONS
   (TransactionID number(10) NOT NULL,
	CustomerID number(10) NOT NULL,
	CustomerName VARCHAR(50),
	AgeGroup VARCHAR(10),
	Region VARCHAR(50),
	Gender VARCHAR(20),
	MaritalStatus VARCHAR(20),
	Education VARCHAR(50),
	Profession VARCHAR(50),
	ProductFamilyID number(10),
	ProductFamilyName VARCHAR(50),
	ProductGroupID number(10),
	ProductGroupName VARCHAR(50),
	CalendarDate VARCHAR(20),
	Units number(10),
	UnitaryPrice FLOAT(10),
	GrossProfit FLOAT(10)
   );
```

Next we need to setup the credentials for ADW to access Oracle Cloud Object Storage.
This will be the username (´oracleidentitycloudservice/email@domain.com´) and auth token (random string) we gathered earlier.
Run the following SQL command.

```sql
SET DEFINE OFF
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'analystobjstorage',
    username => 'oracleidentitycloudservice/michael.lessiak@oracle.com',
    password => 'HxL1<2qf2eRS+fwW}j8W'
  );
END;
```

No we can import the data by running the following SQL.

```sql
BEGIN
 DBMS_CLOUD.COPY_DATA(
    table_name =>'OAC_TRANSACTIONS',
    credential_name =>'analystobjstorage',
    file_uri_list =>'https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/orasealps/b/autonomous-lab/o/OAC_TRANSACTIONS_trim.csv',
    format => json_object('delimiter' value ',')
 );
END;
```

Congrats! Now we imported all the data to ADW and it is ready to be explored using Oracle machine learning.

## <a name="setup-oml">Setup Oracle Machine Learning

As first step we need to enable the 'analyst' user which we setup earlier in ADW for access to Oracle Machine Learning.
See the steps in the following video.

[![Setup OML](http://img.youtube.com/vi/TDJ7DYs2k3s/0.jpg)](http://www.youtube.com/watch?v=TDJ7DYs2k3s "Setup OML")

Next login to your Oracle Machine Learning instance and import the notebooks you find in the lab-4 notebooks folder.

[![Login OML and import notebook](http://img.youtube.com/vi/hd0ofuv6R6M/0.jpg)](http://www.youtube.com/watch?v=hd0ofuv6R6M "Login OML and import notebook")

It might be necessary to change the interpreter binding of the notebooks, see this video on how to do it.

[![OML interpreter binding](http://img.youtube.com/vi/ngHFGv9EsBA/0.jpg)](http://www.youtube.com/watch?v=ngHFGv9EsBA "OML interpreter binding")

Now you are ready to run the notebooks in oracle machine learning. In the notebooks you will find explanation of all the steps before you execute them.

# <a name="Introduction-k-means"> 4. Introduction into k-means algorithm

The machine learning example in this lab is built around the k-means algorithm. There is an [Oracle blog post](https://blogs.oracle.com/bigdata/k-means-clustering-machine-learning) explaining this algorithm available
and there is also a very good introduction on [datascience.com](https://www.datascience.com/blog/k-means-clustering).