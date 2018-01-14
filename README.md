# Scrapto
# Idea Proposal
Scrapto is developing technology to provide industry-leading services for data extraction. 
It aims to takes full advantage of the decentralized cloud by using:
* iExec computing marketplace to perform data extraction tasks
* blockchain tech to enable per-request billing via microtransactions
## Why now
Three main components are vital in the design of our solution:
##### Micropayment model
The latest advances in cryptocurrency facilitates micropayments. Per-request billing is enabled by iExec RLC.
##### Computing marketplace
Without iExec computing marketplace we would have to implement a network of client/worker nodes ourselves specialized in scraping tasks. But most of the difficult work is already done by iExec:
* Creating software for the worker nodes
* Scheduling
* Proof of contribution
* and a lot of other things
##### Web scraping advances
Up until recently, it was difficult to fully simulate a user session during scraping. Launch of Chrome headless changed that. It's like a normal Chrome browser that can be controlled programmatically. This enables us:
* bypass web-scraping detection mechanisms more easily 
* provide users with advanced scraping scenarios
## Our solution
### Data Extraction Tech
There are several important components in web scraping. In a nutshell:
* Having multiple ips. Requests coming from the same IPs are easily detected and then blocked.
* Using screenscrapers (headless browsers).  Harder to detect, as they run scripts, render HTML, and can behave like a real human browsing a site.

**Professional web scraping services**: use large networks of proxies and ever changing IP addresses to get around limits and blocks.
We are looking into iExec architecture to see if we can use individual worker nodes IPs to make data extraction requests. Or if it’s allowed. 
This would mean we do not need to invest in proxy pools and the traffic might seem more organic. 

**Headless parsing** The ultimate goal of a web scraper session is to be indistinguishable from a normal user session. A headless browser is a browser that can be used without a graphical interface. It can be controlled programmatically to automate tasks, such as doing tests or taking screenshots of webpages. We are planning to use Chrome headless to run our data extraction tasks on web pages.
### Components
#### Visual data extraction tool
A powerful visual tool to create data extraction flows. Available as a Chrome extension, extraction flows results can be seen live then exported and used as input in a chrome headless instance in a Iexec worker. Same data extraction code run in the extension is run in the headless browser as well. 
#### Scrapto Dashboard
The Dashboard is the frontend dAPP of our application. In the Dashboard users can:
* create new scraper projects
* input data extraction flows
* devise scraper schedules
#### iExec Worker App
Worker running data extraction flows configured in the visual helper tool. Same code powering extraction results preview in the extension is used here. 
Depending on the configured job the worker can run the flow in:
* jsdom: A JavaScript implementation of the WHATWG DOM and HTML standards, for use with node.js
* Chrome Headless run code in a Chrome browser without GUI.

# Roadmap
## Current work
* We already have a working prototype of the visual data extraction tool:
    * Runs as an extension in Chrome
    * Runs the same data extraction flow in jsdom (Node.js) as in Chrome
* We did not start from scratch. We are modifying a fork of an open source extension.
## Version 0.1 [Done]
* Bootstrap iExec project
* Create a binary from the Node.js app using nexe
* Simple Dapp smart contract
## Version 0.2 (3 months)
* Make job scheduling work (1 month)
    * Invoke Ethereum iExec task from back-end
* Research and implement jobs results persistence (1 month)
* Add new features to visual extraction tool (1 month)
    * Enable passing options to JSDOM to toggle script execution inside pages based on job details
    * Add new headless provider as an alternative to jsdom: Google Chrome headless
    * Research how to package app with new provider
## Version 0.3 (1 month)
* Develop Scrapto Dahsboard initial version

## Version 1.0 (2 months)
* Add notification streams when content changes. A change in a specific selector value will trigger this.
* Useful for :
    * ecommerce price alignment and monitoring.
    * competitor SEO monitoring
## Version 2.0 (1 month)
* add a plugin like architecture and let third-party plugins run on extracted content
* various layers of functionality can be added to the project
    * content diffing
    * sentiment analysis
# Component diagram
![component diagram](https://raw.githubusercontent.com/skunkworkscryptolab/iexec-dapp-samples/scrapto/img/scrapto-component.png "Component Diagram")
# Sequential diagram
![sequential diagram](https://raw.githubusercontent.com/skunkworkscryptolab/iexec-dapp-samples/scrapto/img/scrapto-sequence.png "Sequential Diagram")

# Resources
* Our visual tool and headless worker repo can be found here: https://github.com/skunkworkscryptolab/scrapto-client-worker.

# Copyright
Our visual tool extension is a fork of the amazing work done by: https://github.com/furstenheim/web-scraper-chrome-extension/