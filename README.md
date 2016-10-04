# CAAPI_files

These are vagrant systems with docker provider, basic usage like check
out Vagrantfile and Dockerfile then:

```shell
vagrant reload
```

That will run docker image and simplify with vagrant syntax.

```shell
vagrant ssh
```

Get access to the running docker instance via ssh as user vagrant.

## Host volume mapping


| host      | container |
|-----------|:---------:|
| /ml/local | /ml/local |


## Azure storage file volume mount


| azure                  | container   |
|------------------------|:-----------:|
| Azure File Storage url | /ml/storage |



