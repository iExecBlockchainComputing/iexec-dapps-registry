# Jupyter add-on

# Concept

Jupyter is an ide that is used a lot in the python programming community. Being used in a browser, developers can write add-ons/extensions to expand the functionnality of this ide. Python language is used by data scientists to do tasks that require a lot of computing power in order to get the results in a limited amount of time. Unfortunately, a lot of those persons can't afford a machine allowing those computations. What we aim to do is develop an extension for jupyter allowing to deport these heavy computations to iExec. This would allow the users to do the usual little work locally and let iExec do the heavy part of the job and return the result in a smaller amount of time than it would have took if it was run locally.

# Process

The process would be really simple. The user would work as usual on jupyter. When he will have a task that he would like deport to iExec, he would just have to select the cell and then click on a button that would then send the task. The goal will be to make the process the more transparent possible so it won't change the way he uses jupyter. The only changement will be that he will pay some RLC and he will get the result of the computation way faster.  
# Roadmap

+ V1 : End of February
In the first version, it will be possible to send any computing task to iExec but all the code will have to be in the cell, so any variable that is declared outside of the cell will be unknown.

+ V2 : March - April
In the second version, we will try to let the user have only the heavy computing part in the deported cell. There are multiple ways to do it effectively and we're currently trying to find the best one to make it the more transparent possible for the user.