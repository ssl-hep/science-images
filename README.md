# ServiceX Science Images

The ServiceX Science Images are built by this package.

## How it works

There are two ways to build things:

* Locally: Use the `build_xxx.sh` files that can be found in the various sub-directories
* Github CI: This is the official way to build these images. Workflow files can be found in the usual spot, `.github/workflows`

NOTE: If you are updating the tags you need to do it in several places - in the `build_xxx.sh` files and in the YAML CI files (they should track each other). Further, in both places, note there are two places for each tag that need to be updated!
