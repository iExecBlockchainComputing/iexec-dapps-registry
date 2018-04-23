module.exports = {
  name: 'Gnuplot',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=wcurrie/gnuplot',
  },
  work: {
    cmdline: '-e "set terminal png size 400,300; set output \'iexec/result.png\'; plot [-4:4] exp(-x**2 / 10)"',
  }
};
