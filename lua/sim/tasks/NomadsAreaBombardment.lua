local ScriptTask = import('/lua/sim/ScriptTask.lua').ScriptTask
local TASKSTATUS = import('/lua/sim/ScriptTask.lua').TASKSTATUS
local AIRESULT = import('/lua/sim/ScriptTask.lua').AIRESULT

NomadsAreaBombardment = Class(ScriptTask) {

    StartTask = function(self)
        self.ScriptIsDone = false
        if not self:IfBrainAllowsRun( self.OrbitalStrike ) then
            self:SetAIResult(AIRESULT.Ignored)
        end
    end,

    OrbitalStrike = function(self)
        local locations = self:GetLocations()
        local brain = self:GetAIBrain()
        for k, loc in locations do
            brain:OrbitalStrikeTarget( loc )
        end
        self:SetAIResult(AIRESULT.Success)
        self.ScriptIsDone = true
    end,

    TaskTick = function(self)
        if self.ScriptIsDone then
            return TASKSTATUS.Done
        else
            return TASKSTATUS.Wait
        end
    end,
}
