# iTunes Store Transporter: GUI - Docker Image

Docker image for [iTunes Store Transporter: GUI](https://transportergui.com).

## Usage

[iTunes Store Transporter](http://www.apple.com/itunes/sellcontent) must be installed on the host machine and mounted in the container.

You should setup a local directory to store the Transporter GUI's database and `iTMSTransporter`'s logs. Otherwise your
data will be lost when the container is stopped/restarted/deleted.

The following command stores the Transporter GUI's database and `iTMSTransporter` log files under the `storage` directory,
and mounts `iTMSTransporter`'s root directory `/path/to/itms`:

    docker run -v storage:/var/lib/itms -v /path/to/itms:/opt/itms -p 3000:3000 screenstaring/itunes-store-transporter-gui:standalone

You'll also want to mount the directory containing the assets to be upload to the iTunes Store:

    docker run -v /my/assets:/assets -v storage:/var/lib/itms -v /path/to/itms:/opt/itms -p 3000:3000 screenstaring/itunes-store-transporter-gui:standalone

You can mount your assets in the container using any path you'd like.

After running any of the above you can access the Transporter GUI at http://localhost:3000

### Configuration

Configuration can be done via environment variables. For example:

    docker run -e ITMS_FILE_BROWSER_ROOT_DIRECTORY=/assets -v /my/assets:/assets -v storage:/var/lib/itms -p 3000:3000 screenstaring/itunes-store-transporter-gui:standalone

Will only allow files to be selected from the `/assets` directory.

For a complete list of environment variables see the [Transporter GUI documentation](https://github.com/sshaw/itunes_store_transporter_web#website).

---

Made by [ScreenStaring](http://screenstaring.com)
