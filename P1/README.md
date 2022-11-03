# Part 1

[Big ups to mr Ahmad Nadeem!](https://www.youtube.com/watch?v=D4nk5VSUelg)

Step 1:
Install the requirements using `install_gns3.sh`.

Step 2:
* Create a new project in GNS3.
* Add the Docker container with the docker image of frrouting.
* Change the settings to enable BGPD, OSPFD and IS-IS.
* Stop the container and save the container as a docker image (docker commit [CONTAINER_NAME] [IMAGE_NAME]).
    * We do this, so the changes in the container are persistent next time we re-launch the container.
    
    * I also pushed this image to [Dockerhub](https://hub.docker.com/repository/docker/peerdebakker/badass-gns3), so my teammates can git pull and not get Docker errors for non-existant images.
* Add the newly created docker image as a container in our GNS3 project and name it router-[INTRA_NAME].
* Add the alpine image as a container in our GNS3 project and name it host-[INTRA_NAME].
