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
-   Example nginx.conf with authentication:
    ```nginx
    events {}
    http {
        server {
            location / {
                if ($arg_auth = "{AUTH}") {
                    return 200;
                }
                return 401;
            }
        }
    }
    rtmp {
        server {
            notify_method get;
            on_connect http://127.0.0.1/;
            application stream {
                live on;
                record off;
            }
        }
    }
    ```
-   Mount `/usr/local/nginx/conf/nginx.conf`:
    ```bash
    docker run -d --name nginx-rtmp -p 1935:1935 -v ./nginx.conf:/usr/local/nginx/conf/nginx.conf ghcr.io/ljstadler/nginx-rtmp-docker
    ```
-   Broadcasting URL: `rtmp://{HOST}:{PORT}/stream?auth={AUTH}`
-   Viewing URL: `rtmp://{HOST}:{PORT}/stream?auth={AUTH}/{KEY}`
