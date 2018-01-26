
##Abstract
Both Deep Learning and the Blockchain technology are new and interesting fields.
By creating an easy and fun to use application we want to make it easy for people to get first experience with these technologies.
The idea is simple: The user uploads a photo he took and an artwork he likes. The Distributed App turns the photo into an artwork with the style of the uploaded image.

TODO: Catchy example image

##Idea proposal
Deep Learning and Blockchain technology currently face an unprecedented hype with an increasing number 
of people who are interested in getting deeper into these technologies.
Especially for non-technical people it is still difficult to get a feeling of potential applications and 
the underlying mechanics.

To bridge this gap, we provide users with a product that is easy-to-use and fun.
More specifically, we present a Neural Art Generator which generates custom made artwork for the user.
The usage is simple: Provide the Art Generator with a favorite artwork and an arbitrary photo you took.
The Art Generator will turn your photo into an artwork with the style of the art image you provided.

Running on distributed devices, the system scales well with a growing number of users.
Also, users do not need to enter credit card details in order to pay for the service:
Everything is based on the iexec platform, so RLC token is all they need.

The technology is based on a Paper by Gatys et al. 2015, A neural algorithm of artistic style:
https://arxiv.org/abs/1508.06576 
The technique has an important advantage for the iexec platform:
We can limit the uncertainty to a minimum: The only random component is in the initialization of the output image. Instead of generating a new noise image for every run, we reuse one noise image.
The process is deterministic, so the result of two runs on two devices must lead to identical outputs for the same inputs and parameters.

##Roadmap


##Component diagram


##Sequential diagram of the solution


