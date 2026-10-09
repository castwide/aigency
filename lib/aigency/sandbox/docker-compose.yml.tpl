services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    networks: [sandbox]
    volumes:
      - ./data/sandbox:/sandbox
      - ./data/sandbox_ssh:/sandbox/.ssh
    working_dir: /sandbox
    command: ["sleep", "infinity"]

  egress:
    image: ubuntu/squid
    networks: [sandbox, outside]
    volumes:
      - ./squid.conf:/etc/squid/squid.conf:ro

networks:
   sandbox:
     internal: true
     driver: bridge
     driver_opts:
       com.docker.network.bridge.gateway_mode_ipv4: isolated
       com.docker.network.bridge.gateway_mode_ipv6: isolated
   outside:
     driver: bridge
