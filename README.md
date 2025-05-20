# nginx-rtmp-docker

## Docker image for NGINX compiled with [nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module)

## Usage

-   ```
    docker run -d -e AUTH="{AUTH}" --name nginx-rtmp -p 1935:1935 ghcr.io/ljstadler/nginx-rtmp-docker
    ```
-   Setting the AUTH variable is optional
-   In your broadcasting application of choice, set the server URL to:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}
    ```
-   Setting a Stream Key is required
-   In your viewing application of choice, use this URL:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}/{KEY}
    ```
