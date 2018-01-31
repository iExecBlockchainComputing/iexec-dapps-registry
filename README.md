# Personal Art Generator
## Abstract

We propose a one-click solution for creating personalized artwork.
Privacy, transparence, and performance is ensured by the use of
blockchain, and the IExec platform. The workhorse of our solution
is a novel deep learning algorithm.

TODO: Catchy example image

## Idea proposal

Most of us have seen similiar images in the internet before and wished to have their favorite picture rendered in the style of a Monet. 
Problem is, if you are not experienced with developing Neural Networks, it is infeasible to create such an engine on your own.

Of course, one can also use a proprietary service to get an image artified. 
However, the available solutions come with significant privacy issues: 
First, in order to pay, the user has to provide payment credentials of any form (e.g. credit card details).
Even worse, after uploading the personal image, the user looses any control of how it is processed, stored, or distributed thereafter.
Worst of all, imagine an attacker possesses both: images and payment credentials. 
This is clearly a situation you want to avoid.

By using crypto currencies, we can obviously solve the first problem.
On top of that, IExec DApps now enable us to solve the second problem:
The images are not stored on a central server and thus cannot be compromised

Deep Learning and Blockchain technology currently face an unprecedented hype with an increasing number 
of people who are interested in getting deeper into these technologies.
Especially for Non-technicals it is still difficult to get a feeling of potential applications and 
the underlying mechanics.

To bridge this gap, we provide users with a product that is easy-to-use and fun.
More specifically, we present a Neural Art Generator which generates custom made artwork for the user.
The usage is simple: Provide the Art Generator with a favorite artwork and an arbitrary photo you took.
The Art Generator will turn your photo into an artwork with the style of the art image you provided.

We plan to deploy the backend of this Art Generator as an IExec DApp. 
Running as a distributed service, the system scales well with a growing number of jobs.
Also, cryptocurrencies  users do not need to enter credit card details in order to pay for the service:
Everything is based on the iexec platform, so RLC token is all they need.

The technology is best explained in the paper "A neural algorithm of artistic style" 
by Gatys et al. 2015 [1].


In contrast to other 
The technique has an important advantage for the iexec platform:
We can limit the uncertainty to a minimum: The only random component is in the initialization of the output image. Instead of generating a new noise image for every run, we reuse one noise image.
The process is deterministic, so the result of two runs on two devices must lead to identical outputs for the same inputs and parameters.

## Roadmap

1cut:   Implementation without IExec

Implementation with IExcec



## Component diagram


## Sequential diagram of the solution


[1] https://arxiv.org/abs/1508.06576


