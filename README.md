## vmq_elixir_plugin

> An example elixir plugin for VerneMQ

This is a simple example elixir plugin for VerneMQ. It depends on the
[vmq_elixir](https://github.com/larshesel/vmq_elixir) plugin to be compiled and
loaded. It also assumes [VerneMQ](https://verne.mq/) to be properly installed
and also that `vmq-admin` is in your path.

```shell
$ git clone https://github.com/larshesel/vmq_elixir_plugin
$ cd vmq_elixir_plugin
$ mix deps.get
$ mix compile
$ vmq-admin plugin enable --name  vmq_elixir_plugin --path `pwd`/_build/dev/lib/vmq_elixir_plugin
```

And checking the plugin is loaded should show something like:

```shell
$ ./vmq-admin plugin show
+-----------------+-----------+-----------------+--------------------------------------------+
|     Plugin      |   Type    |     Hook(s)     |                   M:F/A                    |
+-----------------+-----------+-----------------+--------------------------------------------+
|   vmq_systree   |application|                 |                                            |
|   vmq_passwd    |application|auth_on_register |       vmq_passwd:auth_on_register/5        |
|     vmq_acl     |application| auth_on_publish |         vmq_acl:auth_on_publish/6          |
|                 |           |auth_on_subscribe|        vmq_acl:auth_on_subscribe/3         |
|vmq_elixir_plugin|application|auth_on_subscribe|'Elixir.VmqElixirPlugin':auth_on_subscribe/3|
|                 |           |auth_on_register |'Elixir.VmqElixirPlugin':auth_on_register/5 |
|   vmq_elixir    |application|                 |                                            |
+-----------------+-----------+-----------------+--------------------------------------------+
```
