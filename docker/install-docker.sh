if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    echo "Mac OSX Detected, please install docker toolbox https://docs.docker.com/mac/step_one/"      
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Linux Detected"
    if [ "$(id -u)" != "0" ]; then
		echo "Sorry, you are not root. Please run as sudo or change to root"
		exit 1
	else
		apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
		echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
		echo y | apt-get update
		echo y | apt-get install linux-image-extra-$(uname -r)
		echo y | apt-get purge lxc-docker
		echo y | apt-cache policy docker-engine
		echo y | apt-get update
		echo y | apt-get install docker-engine
		service docker start
		curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
		chmod +x /usr/local/bin/docker-compose
	fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    echo "Windows detected please install docker toolbox, https://docs.docker.com/windows/"
fi
exit
