If any update is done in the Dockerfile, run this command 

$ docker build .

To launch the container :

docker run -it --rm -p=0.0.0.0:9222:9222 --name=chrome-headless -v /tmp/chromedata/:/data ubuntu:14.04