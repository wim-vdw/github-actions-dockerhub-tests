# github-actions-dockerhub-tests

Alpine-based toolbox image for Kubernetes Jobs/CronJobs and ad-hoc debugging.

Published to Docker Hub as `wimvandenwyngaert/test` on every `v*` tag.

## Included tools

`curl`, `jq`, `rsync`, `openssh-client`, `tzdata`

## Security

The image runs as a non-root system user:

|              |                                                |
|--------------|------------------------------------------------|
| user / group | `toolbox`                                      |
| UID / GID    | `10001` / `10001`                              |
| home         | `/home/toolbox` (contains `.ssh`, mode `0700`) |

The UID is set numerically in `USER` so Kubernetes can enforce `runAsNonRoot`
without resolving a username.

### Recommended pod securityContext

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 10001
  runAsGroup: 10001
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    drop: ["ALL"]
```

This satisfies the Pod Security Standards `restricted` profile.

### Writable home with readOnlyRootFilesystem

`ssh` and `rsync` need to write `~/.ssh/known_hosts`. With
`readOnlyRootFilesystem: true`, mount a writable volume over the home directory:

```yaml
volumeMounts:
- name: home
  mountPath: /home/toolbox
volumes:
- name: home
  emptyDir: {}
```

Mount SSH keys from a `Secret` with `defaultMode: 0400` into `/home/toolbox/.ssh`.

## Local usage

```sh
docker build -t toolbox:local .
docker run --rm -it toolbox:local
```
