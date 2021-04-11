# Baby Monitoring System

## MindMap
![ScreenShot](Screenshot%202021-04-11%20at%201.52.55%20PM.png)

## AWS Usage 

- AWS S3
- AWS SageMaker
- AWS Notebook 
- AWS Docker 
- AWS Lamba 
- AWS Postgress Hosted DB

## Presentation & Demo 

- [Show Me Presentation Doc](https://docs.google.com/presentation/d/1ePtYMMcNh0xxAyPvUzy8mmKlIHEXTba2BoR8BYLSb-A/edit?usp=sharing)
- [Demo Video] (https://github.com/FormulateAI/baby-monitoring-system/blob/main/demo-short-video.mp4)

## Work In Progess + Bugs 

#### Bugs: 
- IntesectionOverArea or Just checking rectangle coordinates is giving a lot false alarms. We need to fix this by applying a confidence scope filter 
- UNSAFE mode call experience is making the app hang for sometime 

#### Work In Progress Items:
- Storing the registered user information in AWS Postgres 
- Utilizing the AWS Lambda and AWS Media Services to share the real time video as next use case
- Dockerization (AWS Docker) 
- Registration Details are in memory, we need to persist this in DB
- Ensembling of ResNet & PoseNet 


