# Personal Art Generator

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

Web-interface:

Allows the user to upload the two images and to download the result image

Wrapper smart contract:

call the iexec offline app with the proper parameters

Offline App:

Computes the result image using the algorithm introduced above

## Sequential diagram of the solution

Step 1: The user uploads two images on the web-interface

Step 2: The wrapper smart contracs starts the computation of the offline app to create the result image.

Step 3: When the image has been created, the link of the resulting image is sent to the wrapper smart contract

Step 4: The user can then download this image from the web interface


## Bonus: a DApp smart contract with truffle tests

The following code on github includes Solidity code and truffle tests for a simple game that can be played on the Ethereum blockchain. There are two teams, Red and Blue. Players can add money to the stack of Red or Blue and regardless of which team gets money from the player, the player can bet which team wins. A team wins if it has either more than 50% or less than 25% of the total ETH sent to the team.

https://github.com/ahoelzl/smartContract

Team

The MAOH Team

We are an international Munich-based team of four people. Two of us are working as software engineers in the area of data science/machine learning and the other two are a PhD student and a postdoc in the field of formal verification and interactive theorem proving. In our opinion, our team represents the right mixture of academia and industry.

[1] https://arxiv.org/abs/1508.06576


