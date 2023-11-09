# Install Docker on Termux (phone)

## Setup steps:

Install git on Termux & clone this repo: 

```bash
pkg add git expect gdb glob # to automate fill inputs

git clone https://github.com/heo001997/docker-on-phone.git && cd docker-on-phone 
```

Set executable permission for files & run the setup script:

```bash
find . -type f -name "*.sh" -exec chmod +x {} +

./docker-on-phone/setup.sh
```

### Manual Actions:

1. Login as root (no password)
2. Other Option choose default, except "Erase the above disk(s) and continue?" => YES
