# ROOT science image
This image is the base for the ServiceX transformations that use the CERN ROOT libraries to interpret data.

## Updating package versions
No python packages are installed here. Updating to a new ROOT version requires an update to ROOTVER argument of the Dockerfile.

## Building the image for tests
You can build a local copy of the image by running `build_root.sh`. However please do not push this to Docker Hub, as we need to maintain versioning. Make a PR and we'll deploy via the GitHub CI/CD.
