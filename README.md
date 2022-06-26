# Lorfo's Easy Home Server
![GitHub](https://img.shields.io/github/license/lorenzo3421/lorfos-easy-home-server)

Want to quickstart your own home server? You're in the right place!

**Lorfo's Easy Home Server** uses docker-compose and automatically sets up
Portainer (Container Management) and Nginx Proxy Manager (For Reverse Proxy)

## Features

- Installs Portainer and Nginx Proxy Manager automatically
- Can open your browser automatically for account setup in both Portainer and Nginx Proxy Manager
- Can Update (and start) all containers in it's "docker" folder
- Can Remove all containers in it's "docker" folder

## Requirements

You need Linux to run this script,
I'd personally suggest a Linux server and not your main computer

You can setup an [Ubuntu Server](https://ubuntu.com/download/server) easily

If you're using a terminal, don't use the -w (or --web) option,
because that requires a Desktop Environment or Window Manager to work.

## Usage

Clone the repository and give execution permission to `lehs.sh`:

```
git clone https://github.com/lorenzo3421/lorfos-easy-home-server
cd lorfos-easy-home-server
chmod +x lehs.sh
```

At this point you can use **Lorfo's Easy Home Server** as you prefer.

## Examples

View the Help:

```
sudo ./lehs.sh -h
```

Install Portainer and Nginx Proxy Manager, then open the Web Interfaces (recommended to quickstart):

```
sudo ./lehs.sh -p -n -w
```

Only Install Portainer and open it's Web Interface:

```
sudo ./lehs.sh -p -w
```

Install Portainer and Nginx Proxy Manager:

```
sudo ./lehs.sh -p -n
```

If you want to add a new Container, just add a folder inside `./docker/` and inside of that folder, add it's `docker-compose.yml`,
after doing so, you can update all containers using:
```
sudo ./lehs.sh -u
```

## What next?

Well, you could have your own [Cloud Storage](https://hub.docker.com/r/linuxserver/nextcloud)!

Or maybe [Hastebin](https://github.com/angristan/docker-hastebin)!

You can now setup any Docker container that uses a `docker-compose.yml`

Remember that afterwards you can update all of your containers using:

```
sudo ./lehs.sh -u
```

## Contributing

Contributions are always welcome!

Please adhere to this project's
[Code of Conduct](https://github.com/lorenzo3421/lorfos-easy-home-server/blob/main/.github/CODE_OF_CONDUCT.md).


## License

[MIT](https://choosealicense.com/licenses/mit/)
