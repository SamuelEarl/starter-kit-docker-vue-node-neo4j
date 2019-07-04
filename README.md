# Dockerized Vue.js, Node.js, and Neo4j starter kit
This starter kit will allow you to create a Vue.js, Node.js, and Neo4j project from scratch all inside of Docker containers. All the Docker and Docker Compose configurations are ready to go. You just need to follow the instructions below to setup your project.

# How to use this Dockerized Vue-Node-Neo4j starter kit
In order to create a new project from scratch make sure that you have the following installed:

## Docker & Docker Compose
Read the [Get Started with Docker](https://docs.docker.com/get-started/) tutorial to get an understanding of Docker and to install the necessary packages on your operating system.

If your operating system is a...
* **Mac**:
  * Install "[Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/)". This comes with Docker Compose pre-installed.
* **Windows 10**:
  * Install "[Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/)". This comes with Docker Compose pre-installed.
* **Older Mac and Windows Systems**:
  * Install "[Docker Toolbox](https://docs.docker.com/toolbox/overview/)". This comes with Docker Compose pre-installed.
* **Linux**:
  * Install "Docker Community Edition (CE)". Go to this link: [About Docker CE](https://docs.docker.com/install/). Look for the "Linux" link in the left navigation panel. Find your Linux distro and follow the installation instructions for Docker CE.
  * Install [Docker Compose](https://docs.docker.com/compose/overview/).


## Git
Go to the [Git documentation website](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and follow the instructions for installing Git on your operating system. If Git's documentation isn't doing it for you, then try [Bitbucket's Git installation instructions](https://www.atlassian.com/git/tutorials/install-git/) or try searching for a video tutorial that will walk you through how to install Git on your operating system.


# Setup your project
1. Run `make dev` to run the Docker containers.
    * NOTE: If you get the following error: `ERROR: Pool overlaps with other one on this address space`, then refer to the heading below titled "Troubleshooting: `ERROR: Pool overlaps with other one on this address space`".
2. Access the container that has the Node app inside. There are two ways to do that:
    1. Open a new terminal and run `docker container ls` to see the name of your app container. Then run `docker container exec -it <container_name> bash`. That will open an interactive terminal for that container in the terminal window.
    2. If you are using VS Code, you can also click on the Docker tab in the left column, expand the "Containers" menu, right-click the container whose terminal you want to access (Hint: You need to access the app container; not the database container) and then select "Attach Shell" in the context menu. That will open an interactive terminal for that container in the VS Code terminal window.
3. Create the Vue app with `vue create .`
    * NOTE: The dot after `vue create` is important. It tells Vue to create the project in the current project directory instead of in a new child directory.
4. Now you can install packages (i.e., dependencies), create folders and files, reorganize folders and files, change configurations, and start coding.


## Note about accessing your app container
The default command for your app container (in Dockerfile.dev) is `npm run dev`. That command will run the "dev" script that is configured in your `package.json` file. If you do not configure the "dev" script or if you do not have a `server.js` file configured, then your app container will get created and run for a moment and then it will exit. So you won't be able to access your app container's terminal to install packages and configure your project. However, if you have configured your "dev" script to run `node server.js` and if your `server.js` file is configured to run a Node server, then your app container will get created and it will stay running because it has a process to run (i.e., there is a Node server to run). At that point you can access your app container's terminal and install packages and configure your project.

## You will probably run into permissions issues
You will probably run into permissions issues when installing things through Docker. For example, you won't be able to make changes to folders or files. If this is the case, then you will need to change permissions to the folders and files in your project. See the next heading for details.


# Change permissions to folders and files in your project
When you create a new project inside a Docker container, the files and folders are created with root privileges. So we need to change those permissions to be able to work with the files.

1. When you first access your app container, you will be in the `/usr/src/app` directory. You need to navigate one directory up to the `/usr/src/` directory by running `cd ..`
2. Change the permissions of the app directory recursively (i.e., change the permissions for all the folders and files inside the app directory): `chmod -R 0777 app`
3. Now change the permissions of just the app directory (not any of the folders or files inside it) back to its original permissions level: `chmod 0775 app`
4. The `node_modules` directory will still have root privileges, which means that you won't be able to install any new packages. So delete the `node_modules` directory. Don't worry, you can delete your `node_modules` directory anytime as long as your `package.json` file exists. The `package.json` file records all of the packages that are used in your project and you can restore your `node_modules` directory by running `npm install` in your root directory where your `package.json` file is located. Go ahead and run `npm install` now.

That's it. Now you should be able to work with all your folders and files.


# How to properly install NPM packages when developing with Docker
Whenever you need to install NPM packages, you should do it inside your Docker container. This will ensure that the packages that are being installed are the correct versions that the OS in your Docker container needs in order to run properly.

Access the container that has the Node app inside. (See the instructions under "Setup your project" on how to do that.) Make sure that you are in your project root (where your `package.json` file is located) before you install any packages.

After you have installed the packages in your Docker container, you may have to stop and restart your Docker container so that the packages will be recognized by your app. For example, `Ctrl` + `C` (to stop the container) followed by `make dev` (to restart the container).


# Troubleshooting: `ERROR: Pool overlaps with other one on this address space`
After running `make dev`, if you get the following error: `ERROR: Pool overlaps with other one on this address space`, then it means that you have an existing Docker network on your computer that is conflicting with the Docker network that you are currently trying to create. To remove those networks, run `docker network prune` and enter `y` to remove the networks.

At this point, if `make dev` still does not work, then it might be because you still have existing containers that are still using the network. So you need to remove the containers first, then you can run `docker network prune`. There are two ways to do this:
  1. In a terminal, you can remove more than one container at a time by specifying all of the container IDs that you want to remove. For example: `docker container rm a2156a29aa67 6a8a824a99b7`
  2. If you are using VS Code, then you can click on the Docker tab in the left column, expand the "Containers" menu, right-click the container that you need to delete, and select "Remove Container" from the context menu.

Once the networks are removed, the `make dev` command should work.

Source: https://github.com/maxking/docker-mailman/issues/85#issuecomment-349429246



# The Makefile and `make` commands
The Makefile is configured with a list of commands to start and stop your Docker containers using Docker Compose. Docker Compose commands can get a bit long and complicated, but configuring `make` commands can make them easier to work with. The Makefile is heavily commented with explanations for each command, so you can read those comments to get familiar with the commands.

The commands under the DEVELOPMENT heading all work, but the commands under the other headings might still need some tweaking to make sure they work properly. I will update this repo to make sure that all of the commands work properly in the future.

Whenever you need to execute a `make` command, navigate to the project root folder (where the `Makefile` is located) and run the `make` command. For example, to start my project in development mode (which has live reloading configured inside of Docker containers), I would navigate to my project root and run `make dev`. You can read the comments in the Makefile for more details about that command.

# Neo4j Database

## How to access Neo4j Browser
Once the Neo4j container is running, you can access Neo4j Browser:

* URL: `http://172.28.1.2:7474/browser/`
* USER: `neo4j`
* PASSWORD: `bitnami`

NOTES:
* The IP address in the URL (`172.28.1.2`) is the one that is configured in the `docker-compose.dev.yml` file.
* The password is the default password provided by the Bitnami Neo4j image.


## Where are the Neo4j data stored on the host machine?
As an example, the `docker-compose.dev.yml` file is configured to mount the `neo4j_data_dev` volume in `neo4j_data_dev`. What does that mean? Where is `neo4j_data_dev` located?

Volumes are stored in a part of the host filesystem which is managed by Docker (`/var/lib/docker/volumes` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.

To learn more, see [How docker volumes work](http://code4projects.altervista.org/how-docker-volumes-works/?doing_wp_cron=1546897783.1694519519805908203125).
