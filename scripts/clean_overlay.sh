echo "here"

# initialize the configuration
# cp "$1" .config
# mkdir -p src
# echo >> .config
# if ! grep -q "^CT_PREFIX_DIR=" .config; then
#     echo 'CT_PREFIX_DIR="${HERO_INSTALL}"' >> .config
# fi
# if ! grep -q "^CT_LOCAL_TARBALLS_DIR=" .config; then
#     echo "CT_LOCAL_TARBALLS_DIR=\"$(pwd)/src"\" >> .config
# fi
# if [ -n "$CI" ]; then
#     echo "CT_LOG_PROGRESS_BAR=n" >> .config
# fi