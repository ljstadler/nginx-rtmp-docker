# nginx-rtmp-docker

## Docker image for NGINX compiled with [nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module)

## Usage

-   ```bash
    docker run -d --name nginx-rtmp -p 1935:1935 ghcr.io/ljstadler/nginx-rtmp-docker
    ```
-   Broadcasting URL: `rtmp://{HOST}:{PORT}/stream`
-   Viewing URL: `rtmp://{HOST}:{PORT}/stream/{KEY}`

### Modifying nginx.conf

-   Create an `nginx.conf` file
-   Mount `/usr/local/nginx/conf/nginx.conf`:
    ```bash
    docker run -d --name nginx-rtmp -p 1935:1935 -v ./nginx.conf:/usr/local/nginx/conf/nginx.conf ghcr.io/ljstadler/nginx-rtmp-docker
    ```
