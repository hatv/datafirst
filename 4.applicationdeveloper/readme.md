[<img src="https://github.com/hatv/dataworks/raw/master/media/IBMBizCo.jpg">](http://www.ibm.com/fr/businessconnect/)
#Hands on Lab - Application Developer.
[<img src="./media/ApplicationDeveloperRole.png">](https://github.com/hatv/dataworks/tree/master/4.applicationdeveloper)

As an Application Developer, you need multiple application and data services that facilitate a modern architecture and delivery practices around mobile, microservices, DevOps and continuous delivery. Perform hands-on exercises to quickly build and deploy a live dashboard with Node.js connected to a document data service, IBM Cloudant based on CouchDB.


##Lab Components: IBM Bluemix Cloud Offering Used

1.  **Source Data Repository**: **Cloudant NoSQL DB**

2.  **Software Development Tools**: **DevOps Services and Git**

3.  **Runtime Environment**: **SDK for Node.js**

 <img src="./media/image1.png" width="487" height="175" />

Watch Full Lab Video (Optional): https://youtu.be/jhFo47juTFI
 > [<img src="./media/ApplicationDeveloperVideo.png" width="382">](https://youtu.be/jhFo47juTFI "Application Developer Video")


#Step 1. Get on Bluemix...

> NOTE: If you already have a Bluemix account, you can skip to the next section.

1.  Go to [www.bluemix.net](https://www.bluemix.net)

2.  If you have followed the first lab about the Business Analyst, you should land on the following page where you can choose to signup

 > <img src="./media/image2b.png" width="400" />

	Else, just click the signup button on the top right on the standard Bluemix homepage

 > <img src="./media/image2.png" width="400" />

3.  On the next page fill in the corresponding fields and click “Create Account”. If you already registered to Watson Analytics before, your IBMid should be recognized and the registration form should be shortened.

 > <img src="./media/image3.png" width="400" />

4.  You will see a page asking you to check your email for next steps. Check your email that you used to sign up for Bluemix

 > <img src="./media/image4.png" width="400" />

5.  Click on the “confirm your account” link

 > <img src="./media/image5.png" width="400" />

6.	You can then login to Bluemix from [www.bluemix.net](https://www.bluemix.net)

7.	If you don't automatically get to it, follow this link to go to the first configuration steps: https://console.ng.bluemix.net/login?state=/home/onboard/

8.	You will be asked to create an organization. At this moment, you can chose between multiple Bluemix public regions. Choose the "US South" region in Dallas to access all the new services (required to configure Data Science Experience)

 > <img src="./media/image5b.png" width="400" />

9.	And then, to create a space

 > <img src="./media/image5c.png" width="400" />

10. When it's done, you can go ahead by clicking "I'm ready"

 > <img src="./media/image5d.png" width="400" />

#Step 2. Download Application Code & Data Files

1.  Download Lab-NodejsDashboard.zip archive from the github.com location below and save to your laptop: [nodejsDashboard.zip](https://github.com/hatv/dataworks/raw/master/4.applicationdeveloper/application/nodejsDashboard.zip)

2.	Download the JSON data to upload to Cloudant and the cURL script from the github.com location below and save them to your laptop: [data.zip](https://github.com/hatv/dataworks/raw/master/4.applicationdeveloper/data/data.zip)

Step 3. Create Data Source - Cloudant NoSQL DB Service
============================================================

1.  From the Bluemix dashboard catalog menu search for “Cloudant”

2.  Click on the Cloudant NoSQL DB Icon <img src="./media/image6.png" width="31" height="27" /> under the Data & Analytics section.

3.  Choose the default pre-filled values in the fields (optionally rename the “Service name:” to AD-Dashboard-Cloudant), select the “Lite Pricing Plan” and click “Create” at the bottom of the page.

4.  In the top, right corner of the page click **Launch**

5.  The Cloudant page will open in a new tab. Select the new tab.

6.  Select the **Databases** tab on the left-hand navigation bar.

7.  In the top navigation bar select “**Create Database**”

8.  Create a new database named “**greatoutdoors**” (*Note: database names are case sensitive*). Click **Create** to finalize the creation.

9.  In the following steps we will create a view to compute calculation against the data set.

10.	Click the + symbol on **Design Documents**.

11.	Select New View

12.	Fill both fields "_design" and "Index name" with viewByTimestamp

13.	Click in the Map function text box and select all the text

14.	Replace the text with the following text:
function(doc) {
    var date = new Date(doc.ts);
    emit(date.getTime(), doc);
}

 > This allows a direct access to the data based on a date or a date range, which will be very useful for the application.

15.	Click Create Document and Build Index

16. You now have to load the data to the Cloudant database. Those JSON files could have been loaded in Cloudant by a streaming application from Wi-Fi hotspot devices deployed in the shop. First, you have to get the Cloudant API URL in the Cloudant service credentials.

17. Go back to your Bluemix homepage, under "Data & Analytics", service "Cloudant NoSQL DB" and then "Service Credentials". Your URL should look like: 
 > https://4fde2747-1360-479e-b278-3742634efaee-bluemix:aedb9a613f633229177d7765ecbb95e1467e754317724057f5710963f303e69a@4fde2747-1360-479e-b278-3742634efaee-bluemix.cloudant.com

18. Unzip the data.zip file that you got from step 2 and edit the load_data.sh script with your Cloudant URL. This script calls the Cloudant REST API to bulk load JSON files into a database.

19. Invoke the script with **bash load_data.sh**. You need cURL to be installed on your machine. If you are using Windows, you can download a portable console emulator such as http://cmder.net/

 > <img src="./media/image0.png">

20.	You are now ready to move to the next service – SDK for Node.js Runtime. Return to the Bluemix tab and click on the **Catalog** button in the top navigation bar.

Step 4. Create Application - SDK for Node.js Runtime Service
==================================================================

1.  From the Bluemix catalog menu search for “**foundry**”.

2.  Click on the **Cloud Foundry Applications** icon <img src="./media/image7.png" width="41" height="33" />

3.  Click on the **SDK for Node.js** icon <img src="./media/image8.png" width="37" height="37" />

4.  Create a name for the service and the host. *Note: The host name needs to be unique. If you receive an error message it is likely that the host name you created is already in use.*

5.  Choose the default pricing plan and click “**Create**” at the bottom of the page.

 > *Note: Allow your new SDK for Node.js runtime service to stage. This could take 30-40 seconds.*

6.  Click on the “**Connections**” tab in the top navigation bar when staging is complete.

    a.  Click on the blue “**Connect Existing**” button on the top, right side of the page.

    b.  Click on the **NoSQL Cloudant DB** service you created in section 3 and click **Connect**

    c.  You will be prompted to restage your application. Click **Restage**.

    d.  *Note: Allow 30-40 seconds for your application to restage.*

    e.  Binding services allows the Node.js service to authenticate to Cloudant without hard coding credentials in the JavaScript code. It uses environment variables on the server-side to share the credentials between services.

7.  In the top navigation bar click the “**Overview**” tab.

    a.  In the Continuous Delivery panel select “**Add Git Repo and Pipeline**”. You may have to log back to your Bluemix account.

    b.  If you already have a jazz.net account bind with that account. Otherwise, enter an alias (account name) to allow Bluemix to create a DevOps account for you.

    c.  Accept the DevOps Services terms by ticking the box.

    d.  Click **Create**

    e.  Once your Git account has been created you will be notified. Click **Continue**

    f.  Once the Git repo has been create you will be prompted:

 > *Populate the repo with the starter app package and enable the Build & Deploy pipeline?*

	g.  **Tick the box** and click **Continue**

	h.  Once the Git repo is created you will be notified. Click **Close**

	i.  In the Continuous Deliver panel select **Configure**

	j.  You should see two stages which have been created for you. One for Build and the other for Deploy.

8.  DevOps Service for Bluemix

    a.  Click on the settings “star” icon for the **Build Stage** and select **Configure Stage**.

    b.  Select **Input** tab

    c.  At the bottom of the screen change “**State Trigger**” from “Run jobs whenever a change is pushed to Git” to “Run jobs only when this stage is run manually”.

    d.  Click “**Save**”

9.  Return to your Git repo

    a.  Select “**Edit Code**” on the top navigation bar

    b.  In the left-hand pane click on the top entry with the twisty icon. We are going to import code and it is important that we import it to the root of the folder.

    c.  In the Application Menu select File -&gt; Import -&gt; File or Zip Archive

    d.  Browse to the zip file you downloaded in the "Before You Begin" section.

    e.  You will be prompted if it should unzip the .zip file. Click **OK**.

    f.  The import will fail and then ask *“Would you like to retry the import with force overwriting?*”. If you are not prompted the import may have failed.

    g.  Click **Yes**.

    h.  You will need to edit **Manifest.yml** to change the location where the application is hosted. Change both occurrences of **greatoutdoors-johan** to the name of your mybluemix.net host route. The host is usually the same name as your project unless there was a conflict. If you created the application on another public region than "US South" (Dallas), you also have to change the domain from **mybluemix.net** (**eu-gb.mybluemix.net** in UK for instance). Note: The file will save automatically.

10.  In the left-hand navigation bar click the **Git** icon <img src="./media/image9.png" width="29" height="32" /> just below “**edit code**”

    a.  Allow the page to completely refresh all the code changes. You should see 12 files selected in the right-hand pane.

    b.  Enter a comment into the comment window and click **Commit**.

    c.  In the **Outgoing** source tab on the left side of the page click **Push**. This will deliver (push) the commits to the server.

11.  DevOps Service for Bluemix

    a.  Select **Build and Deploy** on the top navigation bar

    b.  Click the play button on the **Build stage** to build the newly delivered code. If the build is successful the Deploy stage should start automatically and deploy your code to the server.

    c.  Once the Deploy stage has completed and passed, right click on the application URL and **open in a new browser tab** by right clicking on the URL.

12.  Node.js runtime Service

    a.  Browse to your mybluemix.net URL where your web application is hosted. You should see a live graph with bars representing the people in the 5 zones of each of this company stores.

    b.  The application should update from the Cloudant database and get the values for current timestamp.

<img src="./media/image10.png" width="625" />

***End of Lab***
