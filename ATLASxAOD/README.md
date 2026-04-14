# ATLAS xAOD Science Images

This directory contains the build inputs for the ATLAS xAOD transformer science images.

## Current release

The release 25 image tracks the latest published `25.2.x` `analysisbase` tag from `gitlab-registry.cern.ch/atlas/athena/analysisbase`.

## How to update release 25

1. Query the registry for the newest `25.2.x` tag.
1. Update `ATLASxAOD/Dockerfile` so `ANALYSISBASE_TAG` matches that tag.
1. Update `ATLASxAOD/build_r25.sh` to use the same tag in both the image tag and the build arg.
1. Update `.github/workflows/atlas.yaml` so the R25 build uses the same tag in both the build arg and the pushed image tag.
1. Rebuild or let CI rebuild the image, then verify the pushed tag matches the base image version.

## Notes

- The Dockerfile references the CERN registry directly, so the tag update should always be based on the registry contents, not on the local default in the file.
- Keep the build script and workflow in sync. They are intentionally redundant so local builds and CI produce the same release tag.
- Full AnalysisBase release information is available behind CERN ATLAS authentication here: https://twiki.cern.ch/twiki/bin/viewauth/AtlasProtected/AnalysisRelease
