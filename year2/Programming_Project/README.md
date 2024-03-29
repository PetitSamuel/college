
# CS2013_3013
Group 23 Software Engineering Group Project at Trinity College Dublin - Second Semester of 2018-2019

This application was developed by 2nd and 3rd year Computer Science Students. It was an assignment for a module ("Software Engineering Group Project") in which we worked with a client 3rd party. To view the original statement of work click [HERE](https://docs.google.com/document/d/1txUZh5TiaYA9gDweK8FRTzW14c7a2z1N9qyPCBCNVYI/edit).
I personally was mostly involved on the frontend of this project.
![BD logo][logo]

## Table of Contents

  * [Overview - Purpose of the System](#overview---purpose-of-the-system)
  * [Getting Started](@getting-started)
  * [Project Structure](#project-structure)
  * [Overview of implementation, tools, frameworks and languages, design decisions](#overview-of-implementation--tools--frameworks-and-languages--design-decisions)
  * [Features](#features)
  * [Design Decisions](#design-decisions)
  * [Flutter installation instructions](#flutter-installation-instructions)

## Overview - Purpose of the System

This iOS and Android application was tailored for a specific use case. The app will replace the current process of manual request resolving over the phone by an employee. It is used to submit a invoice request as an email which should then be approvable by administrators via e-mail or in the app itself.

## Getting Started

For installation of the backend server components please view the backend [README](https://github.com/MartaL0b0/CS2013_3013/tree/dev/backend).

**Install/Update Android Studio:**

Begin by installing Android Studio on your computer ([Android Studio Install](https://developer.android.com/studio/install)). This is required for developing, testing and deploying android applications. 

**Install Flutter and Dart plugins:**

Since the application was built using the Flutter framework you will need to install Flutter and Dart plugins for your editor. Here are links on how to set them up. View the frontend README for more detailed instructions regarding Flutter => [**HERE**](https://github.com/MartaL0b0/CS2013_3013/tree/dev/brief_threat/README.md).

* [Flutter install: Linux](https://flutter.dev/docs/get-started/install/linux)
* [Flutter install: Windows](https://flutter.dev/docs/get-started/install/windows)
* [Flutter install: Mac OS](https://flutter.dev/docs/get-started/install/macos)
* [Flutter: Setting up your Editor](https://flutter.dev/docs/get-started/editor)

**Get dependencies:**

Clone the repo and open the application folder in your Android Studio. Accept the prompt to install/get dependencies.

**Run in Virtual device:** 

Create a virtual device in Android studio to test you application [Managing Android Virtual Devices](https://developer.android.com/studio/run/managing-avds).

[**Deploy your application**](https://developer.android.com/studio/publish/app-signing)


**For more details on Flutter instructions visit the frontend [README](https://github.com/MartaL0b0/CS2013_3013/tree/dev/brief_threat/README.md).**


## Project Structure

The app is divided into 2 parts. The actual application written in Flutter and then the server-side to handle authentication, logging, resolving, emails etc. The folders are labelled in the repo.

## Overview of implementation, tools, frameworks and languages, design decisions

**application Framework: Flutter** [Link](https://flutter.dev/) 
Our application is being built using the Google's Flutter framework. This allowed us to deploy to iOS and as well as Android from one codebase. Flutter applications are built using the Dart language. Dart is an object oriented language supporting both loose and strong typing. Dart/Flutter comes with many useful libraries allowing for easy integration of authentication (JSON Web Tokens) and fingerprint reader login.

**Web Interface + REST API: Python Flask** [Link](http://flask.pocoo.org/) 

We used the Flask Python framework to handle the backend along with some libraries such as **passlib.hash, sqlalchemy, marshmallow, celery**. 

**Authentication: JSON Web Tokens** [Link](https://jwt.io/) 

For authentication we opted to use JWT as they allow for stateless authentication and the team was unfamiliar with then which also posed as an additional learning opportunity.

**Containerisation: Docker Compose** [Link](https://docs.docker.com/compose/)

The application runs in several containers to add modularity. We used docker compose instead of other tools like Kubernetes due to its ease of use and quick setup.

## Features

This form submission app has many features:

* Login/Logout (Stateless authentication using JSON Web Tokens)
* Fingerprint authentication
* Password recovery and reset
* Account Signup
* Secure credential + password storage
* Resolve by EMAIL
* Resolve in app
* List view of submissions

## Design Decisions

**Authentication:**
For the authentication we decided to use JSON Web Tokens (JWT from here on out) as a means of session and login/logout management. There were several reasons for this decision. Mainly we were building a mobile application and not a web-app so we knew our users would not be navigating between pages using links. This provides an ideal use case for JWT. Secondly our application required an API regardless of our authentication strategy and JWT are fairly seamless to integrate alongside our existing API, cookies would have made it difficult for our non-browser based application to consume them.

**Form Resolution Journey:**
This application's goal was to replace an inefficient process of resolving invoice requests. It was usually done over the phone by a member of staff. We decided the simplest and quickest way to resolve forms would be to do so via emails. When requests are submitted via the application an email is sent so the request can be resolved directly in the inbox. This is what those emails look like.

![Resolve Email](https://i.imgur.com/Wh0HQAb.png)

Administrators can also approve requests through the app. This is what that looks like:

![Resolve in app](https://i.imgur.com/CF80LeA.png)

[logo]:https://i.imgur.com/2vsvMmT.png