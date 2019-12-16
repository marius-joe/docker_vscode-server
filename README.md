# docker_vscode-server
## Run VS Code on a remote server, accessible through the browser

In this blueprint a docker container with a VS Code server is run in the Google Cloud Shell.\
VS Code itself is accessible through this Shells Preview Mode.\
You can use Git to access your files and also store your edits in the persistent 5 GB home directory of the Google Cloud Shell.

Use the Shells "Boost Mode" if you need a little more performance.

## HowTo:

1. git clone https://github.com/marius-joe/docker_vscode-server.git "optional local path where to store"\
   if you choose a path other than the Cloud Shells home directory, adjust the working directory in the following steps

2. Create persistent folders for VS Code settings and extensions\
   mkdir -p ~/vscode-server/{projects,.local,.cache}
   -> this folders are mounted in the docker-compose.yml

3. Start docker container in the background\
   cd ~/docker_vscode-server && docker-compose up -d

4. Open the Cloud Shell's preview window in the right hand corner with port 8080  
  
  
#### => Happy Coding on any device you like :)  
  
  
Your vscode-server can be stopped with:\
cd ~/docker_vscode-server && docker-compose stop  
  
  
## Vs Code Server start time:

Google Cloud Shell offers 5 GB of free persistent storage for your HOME directory, but the build docker images are by default not persistent.\
To not have to wait until the docker VS Code container has been build each time when you want to use it,
transfer the once build image to the Google Cloud Container Registry.\
Prices are really low like: 0,026 \$ per GB and month\
https://cloud.google.com/storage/pricing?hl=de#storage-pricing  
Traffic between Google Cloud Services seems to be free, so using the preview mode should not produce addional costs at all.

## Steps:

1. Create a new Google Cloud project (e.g. "general") or use an existing

2. Start the Cloud Shell in this project

3. Adjust the tag of your docker image to connect the image correctly to the Google Cloud Container Registry\
   -> your project ID has to be put in the docker-compose file - the project ID can be found in the console (appended to your current user)

cd ~/docker_vscode-server && sed --in-place 's|eu.gcr.io/general/vscode-server|eu.gcr.io/YOUR_PROJECT_ID/vscode-server|g' docker-compose.yml

The image tag has to be build in this format: [HOSTNAME]/[PROJECT-ID]/[IMAGE] -> e.g. "eu.gcr.io/general-123/vscode-server"

If you are first confused about the container_name vs image name in the docker-compose.yml:\
"container_name" names the container that is finally spun up from the image.\
"image" names and tags the image created, from which the container is built -> this name/tag needs to be referenced when pushing/pulling docker images  
  
  
4. 
   Push the build docker image to Google Cloud Registry\
   docker push eu.gcr.io/YOUR_PROJECT_ID/vscode-server  
     
     
After this every time you start the vscode-server with\
cd ~/docker_vscode-server && docker-compose up -d\
the GC Container Registry is searched for the image, before a new build would be triggered.  
  
  
### Extra:

For best performance the image host can be also adjusted to your region\
https://cloud.google.com/container-registry/docs/pushing-and-pulling?hl=de  
gcr.io (USA at the moment, but can change)\
 us.gcr.io\
 eu.gcr.io\
 asia.gcr.io  
   
   
## About Google CLoud Shell:

https://cloud.google.com/shell/docs/how-cloud-shell-works
Using Cloud Shell you can manage Compute Engine virtual machines, connect to Google Cloud services, checkout and compile code from Github, etc…, to mention but a few. All of this without having to install any software or SDKs locally, also, Cloud Shell provides a Web Preview feature. You can run Web applications on your Cloud Shell on ports 8080 to 8084 then preview them on your browser through a secure proxy that is only accessible to your account.

The Cloud Shell container image is updated weekly to ensure prepackaged tools are kept up to date.\
This means Cloud Shell always comes with the latest versions of Cloud SDK, Docker, and all its other utilities.

### Note:

If you do not access Cloud Shell regularly, the 5GB \$HOME directory persistent storage may be recycled.\
You will receive an email notification before this occurs.\
Starting a Cloud Shell session will prevent its removal.
