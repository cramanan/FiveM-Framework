# FiveM Framework

## Overview

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Recommended resources](#recommended-resources)

### Requirements

-   [A Vanilla FXServer](https://docs.fivem.net/docs/server-manual/setting-up-a-server-vanilla/)
-   [A Steam API key](https://steamcommunity.com/dev)
-   [Ox Lib](https://overextended.dev/ox_lib)
-   [OxMySQL](https://overextended.dev/oxmysql)
-   [MySQL](https://www.mysql.com/) or [MariaDB](https://mariadb.org/)

### Installation

1. Create a folder in your `resources` folder named `[Framework]` (Do not forget the brackets as this is a group of resources).
   Your file structure should look like this:

    ```console
    FXServer
    ├── server
    │   └── ...
    └── server-data
        ├── [Framework]
        └── ...
    ```

2. Clone this repository into the folder or install as a zip and extract into the folder:
    ```sh
    cd server-data/resources
    git clone https://github.com/cramanan/FiveM-Framework [Framework]
    ```
    Now your file structure should look like this:
    ```console
    FXServer
    ├── server
    │   └── ...
    └── server-data
        ├── [Framework]
        │   ├── [cars]
        │   └── ...
        └── ...
    ```
3. Edit your `server.cfg` file and add these lines:

```
ensure baseevents
ensure ox_lib
ensure oxmysql
ensure [Framework]

set steam_webApiKey "YOUR_STEAM_API_KEY"

# Should already be set if you have correctly installed OxMySQL
set mysql_connection_string "mysql://user:password@host:3306/database-name"
```

4. Migrate the table from [`init.sql`](/core/init.sql)

5. Start your server

### Recommended resources

-   `[misc]`:

    -   [vSyncR](https://github.com/KalinkaGit/vSyncR): to synchronize time and weather.

-   `[maps]`:

    -   [bob74_ipl](https://github.com/Bob74/bob74_ipl): to fix holes in the map, up to latest DLCs.
