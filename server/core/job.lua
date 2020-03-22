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
    rdebug(string.format('Checking job %s if exists.', job))
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
            rdebug(string.format('Job %s already created, skipping creation',name))
        else
            MySQL.Async.execute('INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES (@name, @label, @whitelisted)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@whitelisted'] = whitelisted
            },function(changes)
                if changes then
                    rdebug(string.format('Job %s successfully created!'))
                else
                    rdebug(string.format('Error occured! Job %s cannot be created!'))
                end
            end)
        end
    end)
end

exports('createJob',createJob)

function isJobGradeExists(name,job_name,cb)
    rdebug(string.format('Checking job grade %s for job %s if exists.', name,job_name))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT id,job_name,grade,name,label,salary FROM job_grades WHERE name = @name AND job_name=@job', {
            ['@name'] = name,
            ['@job'] = job_name
        })
        if data ~= nil then
            cb(data)
        else
            cb(false)
        end
    end)
end

exports('isJobGradeExists',isJobGradeExists)

function createJobGrade(job_name,grade,name,label,salary)
    isJobGradeExists(name,job_name,function(is)
        if is then
            if is.label ~= label or is.salary ~= salary or is.grade ~= grade then
                MySQL.Async.execute('UPDATE `job_grades` SET salary=@salary, label=@label, grade=@grade WHERE id=@id',{
                    ['@id'] = is.id,
                    ['@label'] = label,
                    ['@grade'] = grade,
                },function(changes)
                    if changes then
                        rdebug(string.format('Job %s successfully updated!'))
                    else
                        rdebug(string.format('Error occured! Job %s cannot be updated!'))
                    end
                end)
                rdebug(string.format('Updating job %s - changes found!',name))
            else
                rdebug(string.format('Job %s already created, skipping creation',name))
            end
        else
            MySQL.Async.execute('INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin, @skin)',{
                ['@name'] = name,
                ['@label'] = label,
                ['@job_name'] = job_name,
                ['@grade'] = grade,
                ['@skin'] = json.encode({})
            },function(changes)
                if changes then
                    rdebug(string.format('Job %s successfully created!'))
                else
                    rdebug(string.format('Error occured! Job %s cannot be created!'))
                end
            end)
        end
    end)
end

exports('createJobGrade',createJobGrade)