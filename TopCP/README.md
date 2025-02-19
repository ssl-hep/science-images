Use this command to build:

GIT_KEY='<git_key>' docker buildx build --secret id=GIT_KEY,env=GIT_KEY --build-arg TOPCPTOOLKIT_TAG="<tag (2.16.1 by default)>" --build-arg ANALYSIS_BASE_VERSION="<analysis base version (25.2.38 by default)>" .
