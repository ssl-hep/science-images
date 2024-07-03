# Uproot science image
This image is the base for the ServiceX transformations that use uproot to interpret data.

## Updating package versions
The _high-level_ package version requirements are set in `requirements.txt`. However, to ensure reproducibility of builds, these requirements are translated to a `requirements.lock` file which is also stored in the repository. The lock file sets the versions of all dependencies. To update the lock file, run `lock.sh` after updating the `requirements.txt` file.

**Remember: just updating `requirements.txt` is not enough to change the packages in the build!**

## Building the image for tests
You can build a local copy of the image by running `build_uproot5.sh`. However please do not push this to Docker Hub, as we need to maintain versioning. Make a PR and we'll deploy via the GitHub CI/CD.
