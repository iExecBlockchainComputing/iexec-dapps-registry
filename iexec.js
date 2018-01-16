module.exports = {
  name: 'Docker',
  data: {
    type: 'BINARY',
    cpu: 'AMD64',
    os: 'LINUX',
  },
  app: {
    type: 'DOCKER',
    launchscriptshuri: 'xw://devxw.iex.ec/f798a440-97f9-4660-8178-02955eec5c73',
    unloadscriptshuri: 'xw://devxw.iex.ec/b535b4fd-fb7d-4e72-9c2b-345c6eb1b55f',
  },
  work: {
    cmdline: 'hello-world',
  }
};
