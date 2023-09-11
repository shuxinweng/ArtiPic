# ArtiPic

AI-generated pictures

## Description

ArtiPic is an iOS app built using SwiftUI that enables users to generate AI-generated photos and save them in a database. These images will be made publicly available if users upload them to the database using the 'Upload' button. There will also be images already stored in the database for users to access.

Every user is required to register and log into their account in order to access the photos and utilize AI features, which become accessible after purchasing a VIP subscription. Users can also add photos to their collection by clicking on the 'Collect' symbol/icon available in the single photo view, and these collected photos will be saved in the 'Collection' section within the toolbar menu. Users can undo the collection by unchecking the 'Collect' symbol/icon.

Made by: Shuxin Weng and Zongming Ke

## Features

- **Authentication**: Users must register an account if they haven't already to log in to the app. This feature is implemented using the FirebaseAuth package, a built-in authentication function provided by Firebase.
- **Photo View**: This view displays all the photos stored in the database. VIP users can upload additional photos after generating AI images using the AI view features. These photos are shared with other users across the app, as they access the same database. Consequently, all users will have access to the same set of photos.
- **AI View**: This view utilizes OpenAIKit to invoke OpenAI's API for generating AI photos. Users must initially purchase VIP access through Apple Pay, which accepts both Visa and MasterCard payments. The VIP subscription is priced at $9.99. 
- **Collection View**: This view showcases the collected photos and is applicable only to individual users. This means that each user will have their own collection, and it is not shared with other users.
- **Profile View**: This view enables users to edit their profile picture, username, and user bio by utilizing the 'Edit Profile' button. Users can also log out of their current account and log into other accounts if needed.

## Built With

- SwiftUI
- OpenAIKit
- Firebase
- KingFisher
- PassKit

## Getting Started

Open the project on xcode after cloning the repo onto your own machine and run the program in the simulator.

## Demo

<img src="https://github.com/shuxinweng/ArtiPic/assets/87344908/8541dd75-3888-475c-8b09-196f9909e40a" alt="demo1" width="" height="400">
<img src="https://github.com/shuxinweng/ArtiPic/assets/87344908/6f3dcc8e-3629-406e-bccc-34bec2dbfe0f" alt="demo1" width="" height="400">


