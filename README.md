# [Natron](https://natron.fr/) powered by iExec

![](https://natron.fr/wp-content/uploads/2013/12/Natron2-edit2.jpg)

## What is Natron?

Natron is a Cross-platform open-source compositing software.

> Compositing is the combining of visual elements from separate sources into single images, often to create the illusion that all those elements are parts of the same scene. (Wikipedia)

While some compositing techniques go back as far a Georges Méliès in the late 19th century, digital compositing is still in use an offer a number of advantages over other CGI technologies. As a matter of fact, even when large scenes are build using other rendered methods, such as ray-tracing, the integration of real footage (such as green screens) rely on compositing.

[![Natron Trailer](https://img.youtube.com/vi/V2MvbfuITT8/0.jpg)](https://www.youtube.com/watch?v=V2MvbfuITT8)

## How does Natron work ?

Natron provides two keep features:

* A GUI to describe compositing projects;
* A Rendering engine.

As of version 2.3.4 (the latest Natron version when writing this), the rendered can either be called directly from the GUI of using a CLI. The CLI works using descriptions of jobs which are exported by the GUI part of Natron. This means that it is already possible to delegate the rendering to another server you have access to, providing you installed Natron on it, and are familiar with ssh commands.

[Natron documentation](http://natron.readthedocs.io/en/master/), where more info is available.

## Why does Natron need iExec?

Rendering is a compute-intensive problem and can, therefore, require large computing resources. Rather than owning expensive (and non-mobile) workstations, graphic designers working on compositing project could use ultramobile hardware to configure and compositing workflow and rely on Cloud resources to perform the hard work.

iExec offers the perfect platform for this use case. By providing a Natron backend based on the iExec platform, users and workers would have a decentralized marketplace where rendering would be triggered by microtransactions.

Combining [Blender](https://www.blender.org/) and [Natron](https://natron.fr/) in a rendering workflow offers much more creative opportunity than using Blender alone. When Golem focuses on Blender, having both Blender and Natron as Dapps in iExec would make it the go-to platform for complex creative workflows.

An example of create workflow using Blender + Natron:

[![Natron Trailer](https://img.youtube.com/vi/Zwbo4jxY0Hs/0.jpg)](https://www.youtube.com/watch?v=Zwbo4jxY0Hs)

## How would it work?

The development of the Natron Daap for iExec would come in 3 steps:

### Version 1: Sandboxing

The first step would be to have the Natron rendering engine doing batch work on the iExec platform. Users would just have to save their Natron project and submit it. The rendering engine would then render the results.

#### Requirements for version 1 (Natron)
On the Natron side, no particular development is required for version 1.

#### Requirements for version 1 (iExec)
In order to deploy Natron on the iExec platform, the Natron rendering engine would have to be built in an easily deployable container. Docker (or equivalent) support is therefore required before deploying version 1.

We will also have to discuss a solution for the temporary storage of the projects being rendered. Those could be erased after the execution of the task.

### Version 2: Integration

Once version 1 is up and running, the next step will be to integrate the iExec powered rendering directly from inside the Natron GUI. As of version 2.3.4, the Natron GUI contains a `Render` tab with options such as `Render All Writers` and `Render Selected Writers`.

#### Requirements for version 2 (Natron)
The objective of version 2 would be to update Natron to provide an option to directly deploy on the iExec platform. This module should integrate/link to a crypto-wallet, and provide the relevant options (working pool selection, etc...).

#### Requirements for version 2 (iExec)
On the iExec side, no particular development is required for version 2. Still, all the development of iExec's v2 will have to be considered in the design of the Natron module discussed above.

### Version 3: Distribution

Natron project often contains many frames. Those are rendered independently to produce a video file. While all the frames from a project would be rendered by a single worker in version 1 & 2, version 3 would focus on the distribution of frame among many workers.

This parallelisation of the computation would make iExec a potential rendering platform for large projects such as commercials, medium and full-length films and much more!

#### Requirements for version 3 (Natron)
Version 3 is a long-term project. The requirement on the Natron side is still unclear and will depend on the exact features to be implemented. A possible vision would be to have part of the rendering engine scheduler rewritten to take iExec as a target. If version 2 is successful the Natron team could at some point be interested in developing specific features, particularly if these features are financed by the cost of running the application on the iExec platform.

#### Requirements for version 3 (iExec)
Version 3 is a long-term project. While it would be possible to perform many microtransactions to require the execution of all the frames independently, it would be nice to have iExec to the distribution automatically.

For example rather than submitting many complementary rendering using

* `NatronRenderer myProject.ntp output_####.png 0-9`
* `NatronRenderer myProject.ntp output_####.png 10-19`
* `NatronRenderer myProject.ntp output_####.png 20-29`
* `...`

it would be nice to be able to script all those in a single transaction and have the iExec schedulers do the distribution.

![](https://github.com/Amxx/Natron-poweredby-iExec/blob/Natron/ressources/block_structure.png)

## Roadmap

* Version 1: Q1 2018 (as soon as iExec provides docker support)
* Version 2: Q3 2018 (after iExec's v2)
* Version 3: No timeframe yet, will depend on iExec's future ability to manage
bags of tasks and on Natron's involvement.

### To the moon with Natron powered by iExec!
[![Natron spaceship demo](https://i.imgur.com/vAHYG9p.png)](https://www.youtube.com/watch?v=17OtwjOGsgI)

## The business model

Natron is an open source application. As such I believe that the application should be free in version 1 and 2. By raising awareness about this project we could see big players take interest in this and require specific features in version 3 and higher.

The extra work required during the development of version 3 and higher, which adds a real value over the current version of Natron, would justify charging for the use of version 3 (which would be made available alongside the free version 2).

## Who am I ? (Disclaimer)

My name is Hadrien Croubois. I am a PhD student at ENS de Lyon and a part-time member of the iExec team. I am not part of the Natron team. My interest in Natron predates my involvement with iExec. Work on this proposition for the Daap challenge was done during my free time. So will be all the development of this application.

## Contact

For more info about me, and for contact information please refer to my website [https://hadriencroubois.com](hadriencroubois.com).
