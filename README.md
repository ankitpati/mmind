# Margin Minder Backend
Margin Minder is an application for the [Ministry of Statistics and Programme
Implementation, Government of India](http://www.mospi.gov.in "MOSPI, GoI"),
made by students of [Symbiosis Institute of Technology](https://sitpune.edu.in
"SIT Pune").

This repository contains the backend of the application.

## Environment Variables
To avoid disclosing production database passwords in the source repository, the
application expects some environment variables and configuration files to be in
place before deployment.

### `/etc/sysconfig/httpd` and `~/.bash_profile`
Exported for `httpd` and current user, respectively.

```
MMIND_HOSTNAME
MMIND_DATABASE
MMIND_USERNAME
MMIND_PASSWORD
```

### `~/.my.cnf` (for `mysql` client)
```
[client]
host=localhost
user=root
password=PASSWORD
```
