[bcc-docker](https://hub.docker.com/r/zlim/bcc/) is provided for user to try out [bcc](https://github.com/iovisor/bcc).

From your host shell:
```bash
docker run -it --rm \
  --privileged \
  -v /lib/modules:/lib/modules:ro \
  -v /usr/src:/usr/src:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --workdir /usr/share/bcc/tools \
  zlim/bcc
```

Now, from the container shell, you can try the various pre-installed bcc tools.

For examples, please refer to the [bcc tutorial](https://github.com/iovisor/bcc/tree/master/docs/tutorial.md#1-general-performance).
