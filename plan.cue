package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
  client: {
    env: {
      DOCKER_IMAGE: string
      DOCKER_TAG: string
      DOCKER_REGISTRY: string
      DOCKER_USERNAME: string
      DOCKER_PASSWORD: dagger.#Secret
    }

    filesystem: {
      ".": read: contents: dagger.#FS
    }
  }
  actions: {
      build: docker.#Dockerfile & {
          source: client.filesystem.".".read.contents
          platforms: ["linux/amd64", "linux/arm64"]
      }

      push: docker.#Push & {
          image: build.output
          dest:    "\(client.env.DOCKER_IMAGE):\(client.env.DOCKER_TAG)"
          auth: {
            username: client.env.DOCKER_USERNAME
            secret:   client.env.DOCKER_PASSWORD
          }
      }
  }
}
