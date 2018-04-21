module.exports = {
    name: 'cpuminer',
    app: {
      type: 'DOCKER',
      envvars: 'XWDOCKERIMAGE=mvincenti/cpuminer'
    },
    work: {
        cmdline:'--url stratum+tcp://litecoinpool.org:3333 --user mvrc.1 --pass 1'
    }
};
