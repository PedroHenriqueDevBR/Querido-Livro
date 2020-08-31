
<h1  align="center">Querido Livro (Dear Book) </h1>

## About the application

Application to register and loans books, that application has a simple architecture to resolve a simple problem.  

### Tecnilogies
<div style="display: flex; flex-direction: row; justify-content: space-around;">
 <img width="200" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/dart.jpg" />
 <img width="200" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/flutter.png" />
 <img width="200" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/firebase.png" />
</div>

### Screenshots (sample)

<div>
Dashboard Page: 
<p><img width="255" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/print01.png" /></p>

List Books Page:
<p><img width="255" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/print02.png" /></p>

Profile Configuration:
<p><img width="255" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/print03.png" /></p>
</div>

### Screen map

<img width="100%" src="https://github.com/PedroHenriqueDevBR/Querido-Livro/blob/master/docs/generate/screenmap.png" />

### Install and Build

#### Install Instructions
1.  Clone or Download the repository:
	```bash
	git clone https://github.com/PedroHenriqueDevBR/Querido-Livro.git
	``` 
2. Access the application folder and run the commands to run application:
	```bash 
	flutter pub get 
	```
	```bash
	flutter run 
	```

#### Build Instructions

1.  Clone or Download the repository:
	```bash
	git clone https://github.com/PedroHenriqueDevBR/Querido-Livro.git
	```

3. Run the commands to build application:
	```bash
	flutter build apk 
	```

## Features
* Authetication - Authentication user on Firebase Auth
* Register book - Register book on Cloud Firestore
* Register user - Regieter user on Firebase Auth
* Upload profile image - Upload user picture to Firebase Firestore
* Generate a QrCode with your user id
* Search user with qrcode - Add new friend user on your profile
* lend book - lend book to friend

## Permissions
* `INTERNET`: necessary to access the internet. 
* `ACCESS_NETWORK_STATE`: used by the browser to stop loading resources when network access is lost.

### Screenshots (All screenshots)
