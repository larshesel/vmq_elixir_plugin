defmodule VmqElixirPlugin do
  @moduledoc """
  This file demonstrates the hooks you typically want to use
  if your plugin deals with Authentication or Authorization.

  All it does is:
   - authenticate every user and write the log
   - authorize every PUBLISH and SUBSCRIBE and write it to the log

  You don't need to implement all of these hooks, just the one
  needed for your use case.

  IMPORTANT:
   these hook functions run in the session context
  """

  @doc """
  Hook callback function handling authentication when registering.
  """
  def auth_on_register({_ipaddr, _port} = peer, {_mountpoint, _clientid} = subscriberid, username, password, cleansession) do
    :error_logger.msg "#{inspect {:auth_on_register, peer, subscriberid, username, password, cleansession}}"
    # do whatever you like with the params, all that matters
    # is the return value of this function
    #
    # 1. return :ok -> CONNECT is authenticated
    # 2. return :next -> leave it to other plugins to decide
    # 3. return {:ok, [{modifierkey, newval}...]} -> CONNECT is
    # authenticated, but we might want to set some options used
    # throughout the client session:
    #      - {:mountpoint, newmountpoint::string}
    #      - {:clean_session, newcleansession::boolean}
    # 4. return {:error, :invalid_credentials} -> CONNACK_CREDENTIALS is sent
    # 5. return {:error, whatever} -> CONNACK_AUTH is sent

    # we return :ok
    :ok
  end

  @doc """
  Hook callback function handling publishing authentication.
  """
  def auth_on_publish(username, {_mountpoint, _clientid} = subscriber_id, qos, topic, payload, isretain) do
    :error_logger.info_msg "#{inspect {:auth_on_publish, username, subscriber_id, qos, topic, payload, isretain}}"
    # do whatever you like with the params, all that matters
    # is the return value of this function
    #
    # 1. return :ok -> PUBLISH is authorized
    # 2. return :next -> leave it to other plugins to decide
    # 3. return {:ok, newpayload::binary} -> PUBLISH is authorized, but we changed the payload
    # 4. return {:ok, [{modifierkey, newval}...]} -> PUBLISH is authorized, but we might have changed different Publish Options:
    #     - {topic, newtopic::string}
    #     - {payload, newpayload::binary}
    #     - {qos, newqos::0..2}
    #     - {retain, newretainflag::boolean}
    # 5. return {error, whatever} -> auth chain is stopped, and message is silently dropped (unless it is a Last Will message)
    #
    # we return :ok
    :ok
  end

  @doc """
  Hook callback function handling subscribtion authentication.
  """
  def auth_on_subscribe(username, clientid, [{_topic, _qos}|_] = topics) do
    :error_logger.info_msg "#{inspect {:auth_on_subscribe, username, clientid, topics}}"
    # do whatever you like with the params, all that matters
    # is the return value of this function
    #
    # 1. return :ok -> SUBSCRIBE is authorized
    # 2. return :next -> leave it to other plugins to decide
    # 3. return {:error, whatever} -> auth chain is stopped, and no
    # SUBACK is sent

    # we return :ok
    :ok
  end
end
