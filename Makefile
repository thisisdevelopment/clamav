tangle:
	emacs --batch -l org --eval "(setq org-confirm-babel-evaluate nil)" --eval "(org-babel-tangle-file \"tid-clamav.org\")"

build-deb: tangle
	mkdir -p build && dpkg-deb --build src build/clamav-scan.deb

build: build-deb build-docs

build-docs:
	emacs --batch -l org --eval "(find-file \"tid-clamav.org\")" \
              --eval "(setq org-confirm-babel-evaluate nil)" \
              --eval "(org-md-export-to-markdown)"

install: 
	cp src/usr/local/sbin/clamav-scan /usr/local/sbin/clamav-scan
	cp src/etc/clamav/clamd.conf /etc/clamav/clamd.conf
	cp src/etc/clamav/scan.conf /etc/clamav/scan.conf
	cp src/etc/systemd/system/clamav-scan.service /etc/systemd/system/clamav-scan.service
	cp src/etc/systemd/system/clamav-scan.timer /etc/systemd/system/clamav-scan.timer

	systemctl daemon-reload
	systemctl restart clamav-daemon.service

run:
	systemctl start clamav-scan.service

stop:
	systemctl stop clamav-scan.service

status:
	systemctl status clamav-scan.service

clean:
	rm -rf src
	rm -rf build
