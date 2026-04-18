# 👋 Hi, I'm Vikas Kumar

<p align="center">

<img src="https://readme-typing-svg.herokuapp.com/?lines=DevOps+Engineer;Terraform+AWS+Kubernetes+Ansible;Linux+Automation+Enthusiast&center=true&width=600&height=50">

</p>

---

## 🚀 About Me

- 🌱 Hands on experience on DevOps Tools
- ☁ AWS | Terraform | Kubernetes | Ansible | Docker | Sonarqube
- 🐧 Linux Administrator
- ⚡ Automation using Python
- 👀 Promethesu | Grafana | ELK 

---

## 🛠 Tech Stack

<p align="center">

<img src="https://skillicons.dev/icons?i=aws,linux,bash,git,github,githubactions,jenkins,terraform,ansible,docker,kubernetes,prometheus,grafana,elasticsearch,logstash,kibana,python,vscode"/>
<img src="images/kibana.png" />
<img src="images/logstash.png" />
<img src="images/sonarQuality.png" />

![SonarQube](https://shields.io)
<img src="https://skillicons.dev/icons?i=aws,terraform,docker,kubernetes,linux,git,github,ansible,sonarqube,shell-script,prometheus,graffana,ELK,python,vscode"/>

</p>

---

## 📊 GitHub Stats

<p align="center">

<img src="https://github-readme-stats.vercel.app/api?username=vikaskumars1997&show_icons=true&theme=tokyonight"/>

<img src="https://github-readme-streak-stats.herokuapp.com/?user=vikaskumars1997&theme=tokyonight"/>

</p>

---

## 👀 Visitor Count

<p align="center">

<img src="https://komarev.com/ghpvc/?username=vikaskumars1997&color=blue"/>

</p>

---

# 🚀 DevOps Project — Web application deployment

---

## 📌 Project Description

This project creates:

- trigger to github workflow after push code
- create a infrastructure (worker)
- make configuration on worker
- create sonarqube server
- scan source code
- create docker image
- deploy web application using docker image

---

## 🏗 Architecture

![architecture](architecture.png)

---

## 📂 Folder Structure

```
project/
 |------.github
 |          |------workflows
 |                    |-------dockerAuto.yml
 |
 |-------app
 |        |------terraform_code
 |        |            |----------module
 |        |            |----------main.tf
 |        |            |----------provides.tf
 |        |            |----------state.tfvars
 |        |            |----------variables.tf
 |        |            |----------create.sh
 |        |------ansible_code
 |        |            |----------roles
 |        |            |----------playbook.yml
 |        |------backend
 |        |------frontend
 |        |------scripts
 |        |          |-----githubRunner
 |        |          |         |---------runnerJoin.sh   
 |        |          |-----sonarqube
 |        |          |         |---------sonarqubeInstall.sh 
 |        |          |-----sonar_scanner
 |        |          |         |---------backendScan.sh
 |        |          |         |---------frontendScan.sh
 |        |          |         |---------project_token.sh
 |        |------docker
 |        |         |-----backend
 |        |         |        |---------Dockerfile  
 |        |         |-----frontend
 |        |         |        |---------Dockerfile
 |        |         |-----db
 |        |         |      |-----------Dockerfile

```

---
## 👍 Project Result

[![.github/workflows/dockerAuto.yml](https://github.com/appDeploymentFlow/DemoMainAppFlowFirs/actions/workflows/dockerAuto.yml/badge.svg)](https://github.com/appDeploymentFlow/DemoMainAppFlowFirs/actions/workflows/dockerAuto.yml)
<img src="images/jobsStatus.png" />
<img src="images/instances.png" />
<img src="images/runner.png" />
<img src="images/containers.png" />
<img src="images/sonarqube.png" />
<img src="images/sonarQuality.png" />
<img src="images/webAppView.png" />

---
## 🤝 Connect With Me

LinkedIn:
https://linkedin.com/in/vikas-kumar-s

---

## 👨‍💻 Author

Vikas Kumar
