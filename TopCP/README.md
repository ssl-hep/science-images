### Docker build command:

```
GIT_KEY='<git_key>' docker buildx build --platform linux/amd64,linux/arm64 --secret id=GIT_KEY,env=GIT_KEY --build-arg TOPCPTOOLKIT_BLS_TAG="<tag (v2.17.0_v0.1 by default)>" --build-arg ANALYSIS_BASE_VERSION="<analysis base version (25.2.45 by default)>" 
servicex_topcp_transformer:develop .
```

### Run TopCPToolkit docker container locally

- Pull docker image with a proper tag
    - `$ docker pull sslhep/servicex_topcp_transformer:25.2.45_v2.17.0_v0.1`
- Start docker container with a mount to access an input file
    - `$ docker run -it -v /local/path:/data sslhep/servicex_topcp_transformer:25.2.45_v2.17.0_v0.1 bash`
- Run TopCPToolkit in the container
    - Prepare `input.txt` in `run` directory - path to the mounted input file
    - Prepare `reco.yaml` in `../source/TopCPToolkit/share/configs/customConfig/`
    - Run `runTop_el.py -i input.txt -o out -t customConfig`