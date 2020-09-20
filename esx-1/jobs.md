---
description: 'Jobs creation, grades using esx_society'
---

# Jobs

### Overview

Job system in ESX \(esx\_society\) is working with job and job grades, job can be whitelisted or not if you are using jobmenu you will 100% use it, every job grade has its own salary and name, please dont forget that name of job and display name is two different thinks, you cannot use diacriticts or special characters in name, but in display name you can.

{% hint style="info" %}
rcore framework is creating every job into database so you dont have to import any sql files, if you change code rcore will update grades or create new records
{% endhint %}

### Job functions

* isJobExists\(jobName, callback\)
* createJob\(name, displayName, whitelisted\)
* isJobGradeExists\(name, jobName, callback\)
* createJobGrade\(jobName, grade, name, displayName, salary\)

### Create job

{% code title="your\_server.lua" %}
```lua
rcore = exports.rcore

--Create job if not exists, its async method so we dont want to any response, 
--and last parameter says its whitelisted job
rcore:createJob('bazar','Car bazar',true)
```
{% endcode %}

### Create job grade

```lua
-- First is job name that we create above
-- Second is grade number, look for esx_society documentation for more info
-- Third is name of grade that you can use at your scripts
-- Four params is grade label that will show player that has this job grade
-- Last is salary
rcore:createJobGrade('bazar',0,'sellerjunior','Newbie seler',1000)
rcore:createJobGrade('bazar',1,'seller','Seller',1400)
rcore:createJobGrade('bazar',2,'sellersenior','Good seller',1700)
rcore:createJobGrade('bazar',3,'boss','Boss',2000)
```



