self: with self; ''
  case $1 in
    start)
      ${self.docker}/bin/docker run --detach \
        --volume=/var/run/docker.sock:/var/run/docker.sock \
        --env=DRONE_RPC_PROTO=$DRONE_RPC_PROTO \
        --env=DRONE_RPC_HOST=$DRONE_RPC_HOST \
        --env=DRONE_RPC_SECRET=$(${self.libsecret}/bin/secret-tool lookup drone rpc-secret) \
        --env=DRONE_RUNNER_CAPACITY=4 \
        --env=DRONE_RUNNER_NAME=$(${self.inetutils}/bin/hostname) \
        --publish=30010:30010 \
        --restart=always \
        --name=drone-runner \
        drone/drone-runner-docker:1
      ;;

    stop)
      ${self.docker}/bin/docker stop drone-runner
      ${self.docker}/bin/docker rm drone-runner
      ;;

    logs)
      ${self.docker}/bin/docker logs drone-runner
      ;;

    *)
      echo "Usage: drone-docker-runner <start|stop|logs>"
      exit 1;
      ;;
  esac

''
