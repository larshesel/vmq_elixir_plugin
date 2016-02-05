## vmq_elixir_plugin

> An example elixir plugin for VerneMQ

This is a simple example elixir plugin for VerneMQ. It depends on the
[vmq_elixir](https://github.com/larshesel/vmq_elixir) plugin which load Elixir
into the [VerneMQ](https://verne.mq/) Erlang VM. In the following we'll show how
to setup both `vmq_elixir` and the `vmq_elixir_plugin` sample Elixir plugin.

The Elixir version used is 1.1.1 and we assume Erlang 17.x and
[rebar3](http://www.rebar3.org/) are available and [VerneMQ](https://verne.mq/)
to be properly installed and that `vmq-admin` is in your path.

Here's how to do it. First setting up vmq_elixir

```shell
$ git clone https://github.com/larshesel/vmq_elixir
$ cd vmq_elixir
$ rebar3 compile
$ vmq-admin plugin enable --name vmq_elixir --path `pwd`/_build/default/lib/vmq_elixir

```

Check the `vmq_elixir` plugin is loaded. `vmq-admin plugin show`
should return something like:

```shell
$ vmq-admin plugin show
+-----------+-----------+-----------------+-----------------------------+
|  Plugin   |   Type    |     Hook(s)     |            M:F/A            |
+-----------+-----------+-----------------+-----------------------------+
|vmq_systree|application|                 |                             |
|vmq_passwd |application|auth_on_register |vmq_passwd:auth_on_register/5|
|  vmq_acl  |application| auth_on_publish |  vmq_acl:auth_on_publish/6  |
|           |           |auth_on_subscribe| vmq_acl:auth_on_subscribe/3 |
|vmq_elixir |application|                 |                             |
+-----------+-----------+-----------------+-----------------------------+
```

Leave the `vmq_elixir` directory and do the same for
[vmq_elixir_plugin](https://github.com/larshesel/vmq_elixir_plugin):

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
