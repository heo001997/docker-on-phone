# Install Docker on Termux (phone)

## Setup steps:

Install git on Termux & clone this repo: 

```bash
pkg add git # if you don't have git yet

git clone git@github.com:heo001997/docker-on-phone.git
```

Set executable permission for files & run the setup script:

```bash
find docker-on-phone -type f -name "*.sh" -exec chmod +x {} +

./docker-on-phone/setup.sh
```

### Manual Actions:

1. Login as root (no password)
2. Other Option choose default, except "Erase the above disk(s) and continue?" => YES
