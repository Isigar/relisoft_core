local dbg = rdebug()

---@param player number
---@param job string
---@param grade number
function setPlayerJob(player, job, grade)
    local xPlayer = getPlayerFromId(player)
    if xPlayer ~= nil then
        xPlayer.setJob(job,grade)
    end
end

exports('setPlayerJob',setPlayerJob)

function isJobExists(job,cb)
    dbg.info(string.format('Checking job %s if exists.', job))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchScalar('SELECT COUNT(name) FROM jobs WHERE name = @name', {
            ['@name'] = job
        })
        if data > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end

exports('isJobExists',isJobExists)

function createJob(name,label,whitelisted)
    isJobExists(name,function(is)
        if is then
            dbg.info(string.format('Job %s already created, skipping creation',name))
        else
            MySQL.Async.execute('INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES (@name, @label, @whitelisted)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@whitelisted'] = whitelisted
            },function(changes)
                if changes then
                    dbg.info(string.format('Job %s successfully created!',name))
                else
                    dbg.info(string.format('Error occured! Job %s cannot be created!',name))
                end
            end)
        end
    end)
end

exports('createJob',createJob)

function isJobGradeExists(name,job_name,cb)
    dbg.info(string.format('Checking job grade %s for job %s if exists.', name,job_name))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT id,job_name,grade,name,label,salary FROM job_grades WHERE name=@name AND job_name=@job', {
            ['@name'] = name,
            ['@job'] = job_name
        })
        if data[1] ~= nil then
            cb(data[1])
        else
            cb(false)
        end
    end)
end

exports('isJobGradeExists',isJobGradeExists)

function createJobGrade(job_name,grade,name,label,salary)
    isJobGradeExists(name,job_name,function(is)
        if is ~= false then
            if is.label ~= label or is.salary ~= salary or is.grade ~= grade then
                MySQL.Async.execute('UPDATE `job_grades` SET salary=@salary, label=@label, grade=@grade, salary=@salary WHERE id=@id',{
                    ['@id'] = is.id,
                    ['@label'] = label,
                    ['@grade'] = grade,
                    ['@salary'] = salary,
                },function(changes)
                    if changes then
                        dbg.info(string.format('Job grade %s successfully updated!',name))
                    else
                        dbg.info(string.format('Error occured! Job grade %s cannot be updated!',name))
                    end
                end)
                dbg.info(string.format('Updating job grade %s - changes found!',name))
            else
                dbg.info(string.format('Job grade %s already created, skipping creation',name))
            end
        else
            MySQL.Async.execute('INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin, @skin)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@job_name'] = job_name,
                ['@grade'] = grade,
                ['@salary'] = salary,
                ['@skin'] = json.encode({})
            },function(changes)
                if changes then
                    dbg.info(string.format('Job grade %s successfully created!',name))
                else
                    dbg.info(string.format('Error occured! Job grade %s cannot be created!',name))
                end
            end)
        end
    end)
end

exports('createJobGrade',createJobGrade)
