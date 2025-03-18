### Docker build command:

```
GIT_KEY='<git_key>' docker buildx build --platform linux/amd64,linux/arm64 --secret id=GIT_KEY,env=GIT_KEY --build-arg TOPCPTOOLKIT_TAG="<tag (2.17.0 by default)>" --build-arg ANALYSIS_BASE_VERSION="<analysis base version (25.2.45 by default)>" 
servicex_topcp_transformer:develop .
```