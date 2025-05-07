---
title: 使用Umami来记录您的网站访问数据
slug: 2024052401
date: 2024-05-24
image: updata20240524015206.png
categories:
    - 我得
tags:
    - umami
    - 教程
    - 下载
    - 安装
---
# 使用Umami来记录您的网站访问数据

## 前言

在我们建站时，总需要一些工具来分析自己的网站有多少用户浏览，以及这些用户来源。

目前，也有一些提供此类服务的平台，例如[百度](https://tongji.baidu.com/web5/welcome/login)，[谷歌](https://analytics.google.com/analytics/web/provision/#/provision)等公司。

而本篇文章将向您推荐目前本网站所使用的自建统计服务[umami](https://github.com/umami-software/umami)

## 开始

### 关于UMAMI

[官方网站](https://umami.is/) | [官方文档](https://umami.is/docs/about) | [Github](https://github.com/umami-software/umami)

![](updatascreencapture-s-yzhserver-cn-websites-d8581293-35ee-4261-ade6-57635763d972-2024-05-24-01_58_24.png)

### 本地部署

#### 使用源代码安装

##### 环境要求

Node.js ≥ 18.17
MySQL ≥ 8.0 或 PostgreSQL ≥ 12.14

##### 开始安装

###### 安装yarn

```
npm install -g yarn
```

###### 获取源代码并安装

```
git clone https://github.com/umami-software/umami.git
cd umami
yarn install
```
当你安装完后，你需要在umami的目录下新建一个`.env`文件来记录链接数据库的信息

###### .env文件需要填写的内容：

```
DATABASE_URL={connection url}
```

若您是MySQL数据库，则填写：

```
DATABASE_URL=mysql://username:mypassword@localhost:3306/mydb
```

若您是PostgreSQL数据库，则填写：

```
DATABASE_URL=postgresql://username:mypassword@localhost:5432/mydb
```

其中，username为数据库用户名，mypassword为数据库密码，localhost为服务器地址，本地部署无需修改，3306/5432为数据库端口，mydb为数据库名。

###### 开始构建

一切无误后，输入
```
yarn build
```

开始构建umami

![](updata20240524014523.png)

构建完成后输入 yarn start 即可启动程序。

默认端口为 3000 ，默认用户名为admin，默认密码为umami。

###### 使用pm2开机自启

官方推荐使用pm2来管理此程序
```
yarn global add pm2
cd umami
pm2 start yarn --name umami -- start
pm2 startup
pm2 save
```
完成后即可开机自启

#### 使用Docker安装

##### 开始安装

###### postgresql

```
docker pull docker.umami.is/umami-software/umami:postgresql-latest
```
###### MySQL
```
docker pull docker.umami.is/umami-software/umami:mysql-latest
```

### 其他

[环境变量](https://umami.is/docs/environment-variables)

