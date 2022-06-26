#!/bin/bash

# This function checks if a program is installed
check_installed() {
    if [ -z "$(command -v $1)" ]; then
        echo "Error: $1 is not installed."
        exit 1
    fi
}

# Checking if all the dependencies are installed
check_installed "docker"
check_installed "docker-compose"

# Check if the user has sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: You must run this script as root."
    exit 1
fi

if [ -z "$1" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -h, --help       Prints this help message"
    echo "  -p, --portainer  Setup Portainer"
    echo "  -n, --nginx      Setup Nginx Proxy Manager"
    echo "  -w, --web        Open the web interfaces after setup"
    echo "  -u, --update     Update all the containers"
    echo "  -r, --remove     Remove all the containers"
    exit 0
fi

echo "Using $(pwd)/docker/ for docker compose files."
for arg in "$@"; do
    case $arg in


        -p|--portainer)
            portainer=true
            echo "Setting up Portainer..."
            mkdir -p docker/portainer
            cat > docker/portainer/docker-compose.yml << EOF
version: '3.3'
services:
    portainer-ce:
        ports:
            - '8000:8000'
            - '9443:9443'
        container_name: portainer
        restart: always
        volumes:
            - '/var/run/docker.sock:/var/run/docker.sock'
            - './portainer_data:/data'
        image: 'portainer/portainer-ce:latest'
EOF
            echo "Running Portainer..."
            docker-compose -f docker/portainer/docker-compose.yml up -d
            ;;


        -n|--nginx)
            nginx=true
            echo "Setting up Nginx Proxy Manager..."
            mkdir -p docker/nginx-proxy-manager
            cat > docker/nginx-proxy-manager/docker-compose.yml << EOF
version: "3"
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '443:443'
      - '81:81'

    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF
            echo "Running Nginx Proxy Manager..."
            docker-compose -f docker/nginx-proxy-manager/docker-compose.yml up -d
            ;;


        -w|--web)
            web=true
            echo "Opening web interfaces..."
            check_installed "xdg-open"
            if [ "$portainer" = true ]; then
                echo "=================================================="
                echo "Portainer: https://localhost:9443/"
                echo "=================================================="
                echo "Press Any Key to open the web interface"
                read -n 1 -s
                # Running xdg-open without root privileges
                sudo -u "$(logname)" xdg-open "https://localhost:9443/" &> /dev/null
            fi
            if [ "$nginx" = true ]; then
                echo "=================================================="
                echo "Nginx Proxy Manager: http://localhost:81/"
                echo "Default email is:    admin@example.com"
                echo "Default password is: changeme"
                echo "=================================================="
                echo "Press Any Key to open the web interface"
                read -n 1 -s
                sudo -u "$(logname)" xdg-open "http://localhost:81/" &> /dev/null
            fi
            if [ "$portainer" = false ] && [ "$nginx" = false ]; then
                echo "Please run the script with -p or -n to setup Portainer or Nginx Proxy Manager (or both)"
            fi
            ;;


        -u|--update)
            for dir in docker/*; do
                if [ -d "$dir" ]; then
                    echo "Updating $dir..."
                    docker-compose -f "$dir/docker-compose.yml" up -d
                fi
            done
            echo "Updated all containers."
            ;;


        -r|--remove)
            echo "Are you sure you want to remove all the containers? (y/N)"
            read -r answer
            if [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]; then
                for dir in docker/*; do
                    if [ -d "$dir" ]; then
                        echo "Removing $dir..."
                        docker-compose -f "$dir/docker-compose.yml" down
                        rm -rf "$dir"
                    fi
                done
                echo "Removed all containers."
            fi
            ;;


        *)
            echo "Error: Unknown option '$arg'"
            exit 1
            ;;
    esac
done

if [ "$web" = false ]; then
    if [ "$portainer" = true ]; then
        echo "=================================================="
        echo "Portainer: https://localhost:9443/"
    fi
    if [ "$nginx" = true ]; then
        echo "=================================================="
        echo "Nginx Proxy Manager: http://localhost:81/"
        echo "Default email is:    admin@example.com"
        echo "Default password is: changeme"
    fi
    echo "=================================================="
fi