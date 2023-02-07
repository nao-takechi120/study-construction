#! /bin/bash

yarn build;
tar cvzf dist.tar.gz dist;
scp dist.tar.gz takechi_test:~/;
ssh takechi_test ./deploy.sh
