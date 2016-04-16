# vmq_elixir_plugin

> An example elixir plugin for VerneMQ

This is a simple example elixir plugin for VerneMQ. It is assumed
[VerneMQ](https://verne.mq/) is properly installed and that
`vmq-admin` is in your path.

Further, it is assumed a version of Elixir is correctly installed and
available.

## Enabling Elixir in VerneMQ

The first step is to get Elixir loaded into the Erlang VM running
VerneMQ. We can do this easily as a VerneMQ plugin is really a
standard
[Erlang/OTP application](http://erlang.org/doc/apps/kernel/application.html)
and Elixir is just another standard Erlang/OTP application.

To load Elixir into the VerneMQ Erlang VM pass the root folder of your
Elixir installation and the name of the plugin (which in this case is
`elixir` since that is the name of the underlying Erlang/OTP
application)

```shell
$ vmq-admin plugin enable --name=elixir --path=/home/opt/elixir/
Done
```

Note: Under the hood `vmq-admin plugin enable` looks for Erlang/OPT
applications in the `lib/*/ebin` or `deps/*/ebin` sub-folders of the
path you pass to `vmq-admin plugin enable`.

Let's check that the `elixir` plugin whas correctly loaded by invoking
`vmq-admin plugin show`. If everything is OK it should look like below
with an entry for the `elixir` application:

```shell
$ vmq-admin plugin show
+-----------------+-----------+-----------------+--------------------------------------------+
|     Plugin      |   Type    |     Hook(s)     |                   M:F/A                    |
+-----------------+-----------+-----------------+--------------------------------------------+
|   vmq_systree   |application|                 |                                            |
|   vmq_passwd    |application|auth_on_register |       vmq_passwd:auth_on_register/5        |
|     vmq_acl     |application| auth_on_publish |         vmq_acl:auth_on_publish/6          |
|                 |           |auth_on_subscribe|        vmq_acl:auth_on_subscribe/3         |
|     elixir      |application|                 |                                            |
+-----------------+-----------+-----------------+--------------------------------------------+
```

## Installing the demo plugin

Finally let's try and get the demo plugin up and running. The steps
are as follows:

```shell
$ git clone https://github.com/larshesel/vmq_elixir_plugin
$ cd vmq_elixir_plugin
$ mix deps.get
$ mix compile
$ vmq-admin plugin enable --name vmq_elixir_plugin --path `pwd`/_build/dev/
Done
```

If the plugin was loaded correctly `vmq-admin plugin show` should show
the plugin like this:

```shell
$ vmq-admin plugin show
+-----------------+-----------+-----------------+--------------------------------------------+
|     Plugin      |   Type    |     Hook(s)     |                   M:F/A                    |
+-----------------+-----------+-----------------+--------------------------------------------+
|   vmq_systree   |application|                 |                                            |
|   vmq_passwd    |application|auth_on_register |       vmq_passwd:auth_on_register/5        |
|     vmq_acl     |application| auth_on_publish |         vmq_acl:auth_on_publish/6          |
|                 |           |auth_on_subscribe|        vmq_acl:auth_on_subscribe/3         |
|     elixir      |application|                 |                                            |
|vmq_elixir_plugin|application|auth_on_subscribe|'Elixir.VmqElixirPlugin':auth_on_subscribe/3|
|                 |           |auth_on_register |'Elixir.VmqElixirPlugin':auth_on_register/5 |
|                 |           | auth_on_publish | 'Elixir.VmqElixirPlugin':auth_on_publish/6 |
+-----------------+-----------+-----------------+--------------------------------------------+
```
