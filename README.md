<p align="center">
    <h1 align="center">~ kemal fastdl ~</h1>
    <strong>
         <p align="center">
              A recode of my <a href="https://github.com/13ace37/express-fastdl">expressjs based Source FastDL</a> hosted with <a href="https://kemalcr.com/">kemalcr</a>.
         </p>
    </strong>
</p>

---

<p align="center">This project is in an extremely early state. I won't provide support of any kind, neither do I take responsibility for data loss, etc. in a case a software fault. <strike>This script blocks any request outside a halflife game! So if you're running any web-based place to provide maps, you should stick with the normal fastdl system.</strike></p>

<br><p align="center"><b>If you don't know how to use this, you shouldn't use it!</b></p>
---
### Running

- download the [latest release](https://github.com/13ace37/kemal-fastdl/releases/latest)
    - the `-optimized` version is more light in overall weight and runs smoother but does the same
- from here you got two ways to run the script
    - run the script in some screen session using e.g [tmux](https://github.com/tmux/tmux)
    - or run the script using [pm2](#pm2)
- running the script is simple as `./kemal-fastdl` 
- example: `./kemal-fastdl -p 37019 -d /srv/csgo/fastdl/srv1`

- from here you can either give the users the direct url `http://ip:port/` or use some sort of proxy.
- now finally set the `sv_downloadurl` variable in your game config to `sv_downloadurl "http://ip:port/"` or `sv_downloadurl "http|s://example.com/fastdl/"`.


### pm2

- [pm2](https://pm2.keymetrics.io/) is a daemon process manager
- after you installed pm2 globally you can run the following commands
- `pm2 start --name "fastdl srv1" ./kemal-fastdl -- -p 37019 -d /srv/csgo/fastdl/srv1` for single core usage.
- `pm2 start --name "fastdl srv1" ./kemal-fastdl -i [threads|max] -- -p 37019 -d /srv/csgo/fastdl/srv1` for multi core usage. (max uses all cores)

Disclaimer: I've tested this comparing a normal apache2 webserver with both the single core script and the multicore one with the following result:

| Host  | Requests per second (mean) | Time per request (mean in ms) | File info |
| ------------- | ------------- | ------------- | ------------- |
| Apache/2.4.38 8T | 697.51  | 11.469  | 128x per 8x10MB   |
| kemal-fastdl/0.0.2 1T | 10.77  | 742.668  | 128x per 8x10MB  |
| kemal-fastdl/0.0.2 8T  | 10.73  | 745.322  | 128x per 8x10MB  |

Tested using apache-benchmark `ab -n 128 -c 8`

But why do you want to use this script over apache?
Practically there is no valid reason to pick a slower script over the faster one BUT sadly we live in a weird time and need to focus on privacy. It might be easier for some people to create a save apache or nginx config for their fastdl server but most of the people don't. So this script is mainly created for privacy reasons hiding the actual webserver or making it possible to run the server on the same as the actual game server without installing a dedicated webserver.
