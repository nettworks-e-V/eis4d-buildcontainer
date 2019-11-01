#!/usr/bin/env bash

if [[ -z "$REPO_DIR" ]] ; then
    REPO_DIR=/var/www/html/repo
fi


mkdir -p    ${REPO_DIR}/amd64/pool/main
mkdir -p    ${REPO_DIR}/amd64/dists/stable/main/binary-amd64

# Create release file
cat > ${REPO_DIR}/amd64/release.conf <<EOF
APT::FTPArchive::Release::Origin "Eisfair Team";
APT::FTPArchive::Release::Codename "stable";
APT::FTPArchive::Release::Components "main";
APT::FTPArchive::Release::Label "Local APT Repository";
APT::FTPArchive::Release::Architectures "amd64";
APT::FTPArchive::Release::Description "Custom Debian packages for EIS4D cui gui";
EOF

# Source files assumed on ${REPO_DIR}/source
cd ${REPO_DIR}/source

cp -u *.deb ${REPO_DIR}/amd64/pool/main
cd ${REPO_DIR}/amd64
rm -f ${REPO_DIR}/PublicKey.gpg
gpg --armor --output ${REPO_DIR}/PublicKey.gpg --export team@eisfair.org
rm -f   dists/stable/main/binary-amd64/Packages.gz
apt-ftparchive --arch amd64 packages pool/main > dists/stable/main/binary-amd64/Packages
gzip -k dists/stable/main/binary-amd64/Packages
rm -f   dists/stable/main/Contents-amd64.gz
apt-ftparchive contents pool/main > dists/stable/main/Contents-amd64
gzip -k dists/stable/main/Contents-amd64
apt-ftparchive release dists/stable/main/binary-amd64 > dists/stable/main/binary-amd64/Release
apt-ftparchive release -c release.conf dists/stable > dists/stable/Release
gpg -a --yes --output dists/stable/Release.gpg --local-user "Eisfair Team" --detach-sign dists/stable/Release
gpg -a --yes --clearsign --output dists/stable/InRelease --local-user "Eisfair Team" --detach-sign dists/stable/Release
