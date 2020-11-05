# ft_server

## how to use

```
docker build -t ft_server .
docker run -d -p 80:80 -p 443:443 ft_server
```

## option
### autoindex
default is on. if you want to turn off, use the following command.
```
docker run -d -p 80:80 -p 443:443 -e AUTOINDEX=off ft_server
```
