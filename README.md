
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
## Usage

Clone the repository:

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
## Contributing

Contributions are always welcome!

Please adhere to this project's
[Code of Conduct](https://github.com/lorenzo3421/lorfos-easy-home-server/blob/main/.github/CODE_OF_CONDUCT.md).


## License

[MIT](https://choosealicense.com/licenses/mit/)

