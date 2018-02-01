## Estimation of Pi via a Monte Carlo method

This workflow exposes how to compute an estimation of Pi usign a Monte-Carlo estimation of Pi. The computation task is a Scala task using a self contained code. The workflow computes 100 independant executions of this task using randomly generated seeds for the random number generator. It produces 100 independant realisation of the Monte-Caro estimation. Then the workflow gathers them in a vector and computes an average on the values of the vector. Finally the result is displayed on the standard output.

[Original source](https://github.com/openmole/openmole-market/tree/7-dev/pi)

## Deployment

`iexec deploy`
`iexec submit`
`iexec result txID --save` # will return an approximate value of Pi in stdout.txt`

