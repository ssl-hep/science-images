# Combined ROOT science image

This image includes both CERN ROOT libraries and uproot/awkward in a unified base ServiceX science image.

## Updating package versions

* Updating to a new CERN ROOT version requires an update to the ROOTVER argument of the Dockerfile.
* Updating to a new uproot version requires an update to the UPROOTVER argument of the Dockerfile.
* Note that these above two are overridden in the GitHub CI/CD, which is the primary control point.
* Updating other packages requires changes to the pixi.toml dependencies/pypi-dependencies sections.

## Building the image for tests

You can build a local copy of the image by running `build_combined_root.sh`. However please do not push this to Docker Hub, as we need to maintain versioning. Make a PR and we'll deploy via the GitHub CI/CD.
