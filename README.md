# Personal Art Generator

We propose a one-click solution for creating personalized artwork.
Privacy, transparence, and performance is ensured by the use of
blockchain, and the iExec platform. The workhorse of our solution
is a novel deep learning algorithm.

![Example Image](https://petapixel.com/assets/uploads/2015/08/neuralartwork.jpg "Example Image")


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
The images are not stored on a central server and thus cannot be compromised.

So, here is how it works: Simply provide the Art Generator with your favorite artwork and an arbitrary photo.
The two images are transported securely in an end-to-end fashion to the iExec nodes.
Only there, they are decrypted and processed before the resulting image is returned - again in an encrypted way.

While our foremost motivation for using the iExec platform is privacy, we also get scalability on top.
That is, running as a distributed service, the system scales well with an increasing number of jobs.

Now, let's give a very coarse overview of the art rendering:
We use a pretrained ImageNet network for feature extraction in both images.
By comparing feature maps, we can define two loss functions: one compares the style of two images, the other the content of two images.
First, we initialize the future artwork image with white noise.
Now, we can use gradient descent to iteratively change the pixels of the artwork, so that they get more and more similiar to the images with each step.
After several iterations, we get an image with the style of the art image and the content of the photo.

For more information, please refer to the paper "A neural algorithm of artistic style" 
by Gatys et al. 2015 [1].

## Roadmap

- First Cut: Implementation without IExec using Keras
- Testing Phase: Find a parameter set that works well for a set of examples
- Deployment Phase: Create Wrapper Smart Contract and deploy the DApp on the iExec framework

## Component diagram

### Web-interface:

Allows the user to upload the two images and to download the result image

### Wrapper smart contract:

Calls the iexec offline app with the proper parameters

### Offline App:

Computes the result image using the algorithm introduced above.
This program will be written in Keras and implement the model described in "A neural algorithm of artistic style" by Gatys et al. 2015 [1].

## Sequential diagram of the solution

- Step 1: The user uploads two images using the web-interface
- Step 2: The wrapper smart contracs starts the computation of the offline app to create the result image.
- Step 3: When the image has been created, the link of the resulting image is sent to the wrapper smart contract
- Step 4: The user can then download this image from the web interface 


## Bonus: a DApp smart contract with truffle tests

The following code on github includes Solidity code and truffle tests for a simple game that can be played on the Ethereum blockchain. There are two teams, Red and Blue. Players can add money to the stack of Red or Blue and regardless of which team gets money from the player, the player can bet which team wins. A team wins if it has either more than 50% or less than 25% of the total ETH sent to the team.

https://github.com/ahoelzl/smartContract

## The MAOH Team

We are an international Munich-based team of four people. Two of us are working as software engineers in the area of data science/machine learning and the other two are a PhD student and a postdoc in the field of formal verification and interactive theorem proving. In our opinion, our team represents the right mixture of academia and industry.

[1] https://arxiv.org/abs/1508.06576


