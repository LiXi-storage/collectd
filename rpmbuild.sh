#! /bin/sh -ex

# script to build rpm for RHEL

TOPDIR=$(pwd)
PACKAGE_VERSION=$(./version-gen.sh)
DISTRO_SHORT=el$(sed -rn 's/[^0-9]*([0-9]).*/\1/p' /etc/redhat-release)

rm -rf {BUILD,RPMS,SOURCES,SRPMS}
mkdir {BUILD,RPMS,SOURCES,SRPMS}
./build.sh && ./configure && make dist
mv collectd-*.tar.bz2 SOURCES
rpmbuild -ba --with write_tsdb --with nfs --without java \
  --without amqp --without gmond --without nut --without pinba \
  --without ping --without varnish --without dpdkstat \
  --without turbostat --without redis --without write_redis \
  --without gps --without lvm --without modbus --without mysql \
  --without ime \
  --define "_topdir $TOPDIR " \
  --define="rev $PACKAGE_VERSION" \
  --define="dist .$DISTRO_SHORT" \
  contrib/redhat/collectd.spec
