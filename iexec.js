module.exports = {
    name: 'ethminer',
    data: {
        type: 'BINARY',
        cpu: 'AMD64',
        os: 'LINUX',
    },
    work: {
        cmdline:'-G -P eth.pool.minergate.com:45791 -u <your@email>'
    }
};
