# Jenkins CI CD pipeline for flask application
---

Objective: Set up a Jenkins pipeline that automates the testing and deployment of a simple Python web application. Github Link: https://github.com/SamDonald-A/Jenkins_CI-CD_Flaskapp 

# Step 1: Setup You GitHub repo for CI/CD
# Go to Provided Git Link for Forking it or copy to your new repo

<img width="976" height="505" alt="image" src="https://github.com/user-attachments/assets/65129e63-37a1-47fb-bffb-372ab9d12f89" />

# Then Create Jenkinsfile and setup your workflow 

<img width="976" height="472" alt="image" src="https://github.com/user-attachments/assets/0222cb84-7bd5-4787-ae09-f05c9035ec1e" />

Source Code: https://github.com/SamDonald-A/Jenkins_CI-CD_Flaskapp/blob/main/Jenkinsfile 

# Create Dockerfile for testing container and pushing to the DockerHub

<img width="975" height="501" alt="image" src="https://github.com/user-attachments/assets/63fc3975-e8f8-4d2b-a00c-03753057d6d8" />

Source Code: https://github.com/SamDonald-A/Jenkins_CI-CD_Flaskapp/blob/main/Dockerfile 

# Next: Create DockerHub Repository
# And mention the repo name in the Jenkinsfile

# Click create repo 

<img width="976" height="471" alt="image" src="https://github.com/user-attachments/assets/805730ff-19cc-435c-87f0-77bc8515df56" />


# Click create and copy the repo path name

<img width="976" height="484" alt="image" src="https://github.com/user-attachments/assets/51488198-72ec-4ac8-a6f8-78fcd3e84ab1" />

# Step  2: Lets setup docker hub for uploading the Image from the pipeline

# Go to Account settings

<img width="974" height="522" alt="image" src="https://github.com/user-attachments/assets/491083ac-4883-4f79-991a-152056765474" />


# Next Go to Personal access token in the left menu

<img width="973" height="381" alt="image" src="https://github.com/user-attachments/assets/3f0c241d-87b4-4714-8e9a-6501d94dd9b0" />

# Give a name -> and keep it as public repo and click Generate

<img width="976" height="483" alt="image" src="https://github.com/user-attachments/assets/a472265a-bb7a-405f-ad84-bb64cb7ad5a6" />

# Click Generate to create new token – Here we can see the token -> Copy and save it

<img width="976" height="496" alt="image" src="https://github.com/user-attachments/assets/86ed9bb0-6a36-4d7e-835a-50d5f0ad00d6" />

# Step 3: Jenkins Set-up

# Login to Jenkins and go to settings and click credentials

<img width="976" height="500" alt="image" src="https://github.com/user-attachments/assets/02779eb1-a922-403f-903b-7d0cdc3663b8" />

<img width="976" height="483" alt="image" src="https://github.com/user-attachments/assets/67ddc1b1-98bc-4cd6-8e4d-e1a7b447d2e6" />

# Click Global -> Click Create Credentials

<img width="976" height="492" alt="image" src="https://github.com/user-attachments/assets/80c7649b-b369-438e-bf18-312bbe66a2c8" />

<img width="976" height="490" alt="image" src="https://github.com/user-attachments/assets/78f5c2ae-d5e3-450b-a684-829dec0a86bd" />

# Past your Docker hub credentials here in Username and Password -> Click Create

<img width="976" height="494" alt="image" src="https://github.com/user-attachments/assets/ee8849b2-2d29-42f2-a5a6-5a0dfc59e49d" />

Also add mongo URI

<img width="976" height="492" alt="image" src="https://github.com/user-attachments/assets/7731bdef-d546-4f8f-925e-c7681c371158" />

# Secret key for python app

<img width="976" height="492" alt="image" src="https://github.com/user-attachments/assets/b8ec701c-7bc9-4583-98bb-0e907318f022" />

# Now Go to Dashboard and Click New Item

<img width="974" height="434" alt="image" src="https://github.com/user-attachments/assets/cf7c1130-14b4-425a-935d-5a37b29aad24" />

# Give Item name and choose pipeline and click ok

<img width="976" height="498" alt="image" src="https://github.com/user-attachments/assets/9c8b7c04-92c0-472a-9fac-aba5a45950de" />

# Now select how your Trigger should work - I am selecting Poll SCM tirgger that will check Git for every minute if there any changes then it will be run and excecute
<img width="1916" height="968" alt="image" src="https://github.com/user-attachments/assets/ca86262b-1e35-495c-bc68-85d632dd96c5" />


# Then Under pipeline select SCM

<img width="976" height="496" alt="image" src="https://github.com/user-attachments/assets/5d3c0339-fc19-4a68-954a-bd1597471a7e" />

# Select Git under SCM

<img width="976" height="368" alt="image" src="https://github.com/user-attachments/assets/4decb0c0-85f8-4ff2-b1fe-aa7fb045651a" />

# And then add your repo link, then add credentials if your repo is private, if its public no need of adding credentials

<img width="976" height="475" alt="image" src="https://github.com/user-attachments/assets/45d86253-8c00-4af2-af2b-63f256dce3f8" />

# Click save with other option

<img width="976" height="463" alt="image" src="https://github.com/user-attachments/assets/978cee37-9521-4127-aaf3-d57ac7d0c871" />


# Now Pipeline is ready for Build

<img width="976" height="496" alt="image" src="https://github.com/user-attachments/assets/18e752fc-531b-4572-9128-ac7ac598a524" />

# Click Build Now to run the pipeline

<img width="976" height="501" alt="image" src="https://github.com/user-attachments/assets/33bb8f81-9b0f-4d8f-8188-a1cf21c848e7" />

# First build is running

<img width="974" height="488" alt="image" src="https://github.com/user-attachments/assets/ea45c8ea-5564-4bad-8134-9a4599556122" />

# Pipeline failed

<img width="976" height="387" alt="image" src="https://github.com/user-attachments/assets/d93d8749-5b57-48c9-84ba-3b00e4db1457" />

# Notification received on mail about the failed

<img width="974" height="69" alt="image" src="https://github.com/user-attachments/assets/27bb4335-9102-4589-893d-2c990309c18c" />

<img width="976" height="347" alt="image" src="https://github.com/user-attachments/assets/568c006d-5c90-43ed-802a-524e9f5a0f59" />

# After Debugging the Jenkinsfile in Git the pipeline 

<img width="976" height="498" alt="image" src="https://github.com/user-attachments/assets/28bddd7f-a043-4d1b-a4a5-45696a5c0dc9" />

<img width="976" height="501" alt="image" src="https://github.com/user-attachments/assets/fccb90ac-5d71-45e9-a945-b41245179994" />

# Let’s check the Docker Hub for the new updated Image in the repository

<img width="976" height="496" alt="image" src="https://github.com/user-attachments/assets/fb8a5c13-3c8e-49b7-acd4-6b3a040f2a3d" />

# Mail Also received on successful CI

<img width="973" height="104" alt="image" src="https://github.com/user-attachments/assets/0ef8ad87-fc90-4fc0-8ab4-1e6da13293a2" />

<img width="976" height="350" alt="image" src="https://github.com/user-attachments/assets/4fedc0d3-4b3c-4daa-a14f-ba9a56c129f1" />

# Step 4: Pull the image and Deploy in the docker

<img width="974" height="507" alt="image" src="https://github.com/user-attachments/assets/dbb309d6-92c3-40e6-ba00-a815a9657c1a" />

# Image is Pulled

<img width="973" height="59" alt="image" src="https://github.com/user-attachments/assets/c2108ba0-d6b0-4a7f-9e3e-ac2b490aa007" />

# Created Container and Running on port 5000

<img width="974" height="158" alt="image" src="https://github.com/user-attachments/assets/07dde474-276d-4a92-91eb-1131efc105f0" />

# Output

<img width="976" height="522" alt="image" src="https://github.com/user-attachments/assets/ebca03b6-237f-476a-b88a-b84faadb9ce3" />

<img width="976" height="526" alt="image" src="https://github.com/user-attachments/assets/9e779202-65d8-41e7-8469-6d64ce0d0764" />

<img width="976" height="526" alt="image" src="https://github.com/user-attachments/assets/fc5700b4-27b4-4d6a-a961-7c9767fd792a" />

---



---

# Student Registration System

A simple **Flask** web application to manage student records with **MongoDB** as the backend database. Users can **add, view, update, and delete** student details.

---

## Features

* List all students on the home page
* Add a new student
* Update existing student details
* Delete a student with confirmation
* Simple and responsive UI using Bootstrap

---

## Tech Stack

* **Backend:** Python, Flask
* **Database:** MongoDB (via Flask-PyMongo)
* **Frontend:** HTML, Jinja2 templates, Bootstrap 5
* **Environment Variables:** Managed via `.env` file

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd <repo-folder>
```

### 2. Create and activate a virtual environment

```bash
python -m venv venv
# Activate venv
# Windows:
venv\Scripts\activate
# Linux / Mac:
source venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

**`requirements.txt` example:**

```
Flask
Flask-PyMongo
python-dotenv
bson
```

### 4. Configure environment variables

Create a `.env` file in the project root:

```
MONGO_URI=<your-mongodb-connection-string>
SECRET_KEY=<your-secret-key>
```

### 5. Run the application

```bash
python app.py
```

Open your browser at: [http://localhost:8000](http://localhost:8000)

---

## Project Structure

```
project/
│
├── templates/
│   ├── base.html
│   ├── index.html
│   ├── add_student.html
│   ├── update_student.html
│
├── app.py
├── requirements.txt
└── .env
```

---

## Screenshots

**Home Page**
Lists all students with Edit/Delete buttons.
- <img width="1902" height="607" alt="image" src="https://github.com/user-attachments/assets/a58a6a6d-4978-4769-8074-232e4d31e69d" />


**Add Student**
Form to add a new student.
- <img width="1897" height="801" alt="image" src="https://github.com/user-attachments/assets/d65d25c3-ebb5-410a-adb1-e130ad7c5878" />


**Update Student**
Form pre-filled with student details.
- <img width="1905" height="897" alt="image" src="https://github.com/user-attachments/assets/04febf01-879f-431f-ab07-abcfb993acf1" />



---

## Notes

* Make sure MongoDB is running and accessible via the URI in `.env`
* Delete action includes a confirmation page to prevent accidental deletion
* Uses `ObjectId` from `bson` to work with MongoDB document IDs

---

## License

MIT License

---



