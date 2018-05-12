# remote-spotify

This container allows you to run spotify on a server and control it from external clients.
It's meant for users with a free account, for premium users there are better ways to do this.

## Usage
Suppose you want to run spotify on a server called 'spot' that listens on tcp/12345 for clients that want to control it:

* Run the container :
`docker run -d --device /dev/snd:/dev/snd -p 12345:10000 --rm --name remo-spot remote-spotify`

* Wait a couple of seconds for everything to start...

* You can now use xpra (available in the standard repositories of all large distributions) on a client to connect to it:
`xpra attach tcp:spot:12345`

You will now see the standard client, but all audio will played on the server.
* If you detach the xpra connection from the client spotify will continue to play.
* If you close spotify the container will be stopped (and removed if you included "--rm" when launching the container).

## Development
Want to improve this (bugfixes, extra features, ...) ?
Fork this repository instead of cloning.
Me and other users might be interested in your changes !
