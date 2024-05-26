# Workshop Flutter - What do i like

## About the project

The goal is to do the api for a mobile application in express js

## Build with
* [![flutter][flutter-img]](https://flutter.dev/)
* [![docker][docker-img]](https://www.docker.com/)
* [![node][node-js-img]](https://nodejs.org/en)

## Prerequisites
**version**
* flutter: 3.16.9
* docker: 24.0.7
* node js: 20.11.0

This project is make in dart using flutter -> https://docs.flutter.dev/get-started/install/windows/mobile?tab=download <br>
We setup the database postGreSQL with docker -> https://docs.docker.com/get-docker/<br>
The api is make with express js using node js -> https://nodejs.org/en/download

## Installation && Usage
* Clone the repository<br>
``` sh
git clone https://github.com/tomkawohl/workshop_flutter_api.git
```


## Application

* Run from what_do_i_like
``` sh
flutter run -d chrome --web-renderer auto
```

### API

* You need a key api for TMDB =>
Create an account and get your api key from the website: https://www.themoviedb.org/?language=fr<br>
then add it in API/.env

* Run the container docker (from API) && run the database <br>
```sh
docker-compose up -d
```

You can now develop your API.<br>

Follow instructions on [subject](SUBJECT.md)

## Used
- [TMDB](https://www.themoviedb.org/?language=fr)

## Authors
|[<img src="https://github.com/tomkawohl.png?size=85" width=85><br><sub>Tom Kawohl</sub>](https://github.com/tomkawohl)
| :---: |

[docker-img]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[flutter-img]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[node-js-img]: https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white