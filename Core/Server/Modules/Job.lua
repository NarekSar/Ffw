Job = {}
Job.__index = Job
JobsData = {}

function Job.new(params)
    local self = {}

    self.name = params.name
    self.label = params.label
    self.grades = params.grades
    self.account = params.account or 0
    self.inventory = data.inventory or {}

    return setmetatable(self, Job)
end