version: 2.1

orbs:
  snyk: snyk/snyk@x.y.z

jobs:
  build:
    environment:
      IMAGE_NAME: myrepo/myapp
    docker:
        - image: circleci/buildpack-deps:stretch
    steps:
      - checkout
      - setup_remote_docker
      - run:
          name: Build Docker image
          command: docker build -t $IMAGE_NAME:latest .
      - snyk/scan:
          token-variable: SNYK_TOKEN
          docker-image-name: $IMAGE_NAME:latest
          target-file: "Dockerfile"
