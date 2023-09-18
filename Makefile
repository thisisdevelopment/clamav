build:
	emacs --batch -l org --eval "(org-babel-tangle-file \"tid-clamav.org\")"
	mkdir -p build && dpkg-deb --build src build/clamav-scan.deb

install:
	cp src/usr/local/sbin/clamav-scan /usr/local/sbin/clamav-scan
	cp src/etc/clamav/clamav.conf /etc/clamav/clamav.conf
	cp src/etc/systemd/system/clamav-scan.service /etc/systemd/system/clamav-scan.service
	cp src/etc/systemd/system/clamav-scan.timer /etc/systemd/system/clamav-scan.timer

	systemctl daemon-reload

run:
	systemctl start clamav-scan.service

stop:
	systemctl stop clamav-scan.service

status:
	systemctl status clamav-scan.service

clean:
	rm -rf src
	rm -rf build