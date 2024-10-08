# Runpod image for textgeneration-webui v1.13-2

An experimental runpod image for [text-generation-webui](https://github.com/oobabooga/text-generation-webui), inspired from **TheBlokeAI** [dockerLLM](ttps://github.com/TheBlokeAI/dockerLLM) container image.

#### To build the image:

    docker buildx build -t text-generation-webui-oneclick-runpod:v1.13-2 .

#### To run it locally:

    docker run -it --rm --gpus all \
    -p 5000:5000 -p 7860:7860 \
    -v /path/to/your/models:/workspace/models \
    -e EXPOSE_API=y
    -e AUTH_USER=itmemario
    -e AUTH_PWD=password
    -e TRUST_REMOTE_CODE=n
    text-generation-webui-oneclick-runpod:v1.13-2

#### Environment Variables

| Name              | Description                                              |
| ----------------- | -------------------------------------------------------- |
| EXPOSE_API        | Expose the API to the world                              |
| AUTH_USER         | Authentication username (default: admin)                 |
| AUTH_PWD          | Authentication password, manadatory if EXPOSE_API is set |
| TRUST_REMOTE_CODE | Enable remote code execution from a model                |

Note: Boolean variables accept Y, y and 1 as truthy values.

_Disclamer: This is not an official image: no support is provided. All rights belong to their respective authors._
