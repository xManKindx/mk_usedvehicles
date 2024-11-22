Config = {}

Config.CurrencyIcon = 'fas fa-dollar-sign'

Config.RestrictJobVehicles = {
    Restrict = true,
    JobColumn = 'job', --COLUMN TO CHECK IN THE VEHICLES DATABASE FOR A RESTRICTED JOB NAME.
    RestrictedJobs = {
        'police',
        'ambulance'
    }
}

---@param vehicle number Vehicle entity id
---@param plate string Vehicle plate text
---client code to run after a vehicle has been purchased. (set fuel and give keys)
Config.VehiclePurchasedClientFunction = function(vehicle, plate)
    --exports['LegacyFuel']:SetFuel(vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

end

---@param vehicle number Vehicle entity id
---@param plate string Vehicle plate text
 --client code to run after a vehicle has been removed from a lot by the lister. (set fuel and give keys)
Config.VehicleRemovedClientFunction = function(vehicle, plate)
    --exports['LegacyFuel']:SetFuel(vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)
    
end

------------------------------------------------------PROGRESS BAR------------------------------------------------------------
Config.ProgressCircle = false --true = circle progress bar from ox_lib / false = rectangle progress bar from ox_lib
Config.ProgressCirclePosition = 'middle' --position of the progress circle. can be either 'middle' or 'bottom'
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------VEHICLE TRANSFER--------------------------------------------------------
Config.VehicleTransfer = {
    ---@param vehicle number Vehicle entity id
    ---@param model number Vehicle model
    ---@param plate string Vehicle plate text
    ---@param buyerSource number Server ID of buying player
    ---@param buyerPlayerData table Player Data of buying player
    ---@return boolean
    VehicleTransferAuthFunction = function(vehicle, model, plate, buyerSource, buyerPlayerData)
        --Add custom code here if you want to disable vehicle transfers in a custom way
        return true
    end,

    --Vehicles listed here will not be allowed to be transferred between players
    VehicleTransferBlacklist = {
        --list models here by spawn code or model number to blacklist them
        --'blista', 
        --1456744817
        
    }
}
------------------------------------------------------------------------------------------------------------------------------

