
# About this package

This package adds a few scripts and notifications around the clamdav service.  It is meant to reduce the amount of work to get clamd running periodically and not taking up all available resources during scans.

The configuration file defines a few paths that will be skipped during scans because they both a) contain a lot of files and b) don't have a big chance of catching infected files.

The sourcecode is largely based on [this gist](https://gist.github.com/johnfedoruk/19820540dc096380784c8cf0b7ef333b#system-scan-notifications) by John A. Fedoruk, with some small modifications. 


# Installation

Download the latest release from the [releases page](https://github.com/thisisdevelopment/clamav/releases/latest), or download directly using the following command.

    wget https://github.com/thisisdevelopment/clamav/releases/latest/download/clamav-scan.deb

To install this package we first need to install the dependencies, followed by the package itself.  As we'll only be scanning files in the background we do not need the `clamav` package, but only the daemon and database-tool.  `clamav-daemon` depends on `clamdscan` which is used to send files to `clamav-daemon`.  This package – `clamav-scan` – partially replaces `clamdscan` which provides a default `clamd.conf` config file.

    sudo apt install clamav-daemon clamav-freshclam
    sudo dpkg -i clamav-scan.deb

To de-install `clamav-scan` and its dependencies, run the following command:

    sudo apt remove clamav-scan clamav-daemon clamav-freshclam --purge


# Testing

You can verify that this package works by downloading a *TEST* virus and leaving it somewhere in your homefolder.  Its purpose is to verify a virusscanner works as expected, so its not an actual virus.  You can read more about this file, and download it from [the EICAR.org website](https://www.eicar.org/download-anti-malware-testfile/).

