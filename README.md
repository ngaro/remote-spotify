# remote-spotify

This container allows you to run spotify on a server and control it from external clients.

It makes spotify-connect unnecessary, without making it impossible. It can solve the following problems:

* You don't want to install a full spotify on clients just to play music on another device. Be warned: You will need to install xpra on those clients. This is a really light package available on pretty much all distributions.
* You want to stop and start spotify without having physical access to the server.
* You are afraid spotify-connect will become a feature only available for premium users.

## Remote Usage
Suppose you want to run spotify on a server called 'spot' listening on tcp/12345 for clients that want to control it:

* Run the container :

```
docker run -d --device /dev/snd:/dev/snd -p 12345:10000 \
--name remo-spot garo/remote-spotify
```

* Wait a couple of seconds for everything to start...

* You can now use xpra on a client to connect to it with: `xpra attach tcp:spot:12345`

Spotify will be visible on the client, but all audio will played on the server.
* If you detach the xpra connection from the client spotify will continue to play.
* Closing spotify will also stop the container. With `docker start remo-spot` it will start again. This can also be done remotely with `ssh spot docker start remo-spot`

The environment variable `XPRA_PORT` is `10000` by default but can be changed to make xpra listen to another port.

## Regular (local) usage

You can also use this to run spotify locally in a container:

```
docker run -d --net host -e DISPLAY=$DISPLAY --device /dev/snd \
-v $HOME/.Xauthority:/root/.Xauthority --rm remote-spotify spotify
```

## Development
Want to improve this (bugfixes, extra features, ...) ?

Fork this repository on GitHub instead of cloning it,
I and other users might be interested in your changes !
