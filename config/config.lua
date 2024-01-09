Config = {}

Config.VinNumberField = 'vin' --SET TO VIN NUMBER FIELD FOR PLAYER_VEHICLES (QB) OR OWNED_VEHICLES (ESX) TABLE IF YOU USE VIN NUMBER. EXAMPLE: 'vin_number'
Config.FakePlateColumn = 'fakeplate' --SET THIS TO YOUR COLUMN IN YOUR VEHICLES DATABASE THAT STORES FAKEPLATES FOR OWNED VEHICLES. SET false IF YOU DO NOT USE FAKE PLATES
Config.GarageColumn = 'garage' --SET THIS TO YOUR COLUMN IN YOUR VEHICLES DATABASE THAT STORES THE GARAGE NAME WHERE VEHICLES ARE PARKED

Config.ConsoleLogging = true --TRUE DISPLAYS SCRIPT LOGGING INFO IN F8 AND SERVER CONSOLE
Config.DebugTarget = false --TRUE DISPLAYS F8 DEBUGGING FOR TARGET MENU. ONLY TURN ON IF HAVING ISSUES WITH TARGET MENU NOT SHOWING UP

Config.RestrictJobVehicles = {
    Restrict = true,
    JobColumn = 'job', --COLUMN TO CHECK IN THE VEHICLES DATABASE FOR A RESTRICTED JOB NAME.
    RestrictedJobs = {
        'police',
        'ambulance'
    }
}

Config.CheckFinance = function(vehicleData)
    ---@param vehicleData table (player_vehicles/owned_vehicles) database row for selected vehicle
    ---@return number the remaining balance owed on the vehicle or 0

    if not vehicleData or vehicleData == '' or next(vehicleData) == nil then return 0 end 

    if vehicleData.balance then --default qb-core column
        if tonumber(vehicleData.balance) then 
            return tonumber(vehicleData.balance)
        else
            return 0
        end
    else
        --custom check here
        return 0
    end
end

Config.VehiclePurchasedClientFunction = function(vehicle, plate)
    ---@param vehicle number Vehicle entity id
    ---@param plate string Vehicle plate text
    --client code to run after a vehicle has been purchased. (set fuel and give keys)

    --exports['LegacyFuel']:SetFuel(vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

end

Config.VehiclePurchasedServerFunction = function(vehicle, netId, plate)
    ---@param vehicle number Vehicle entity id
    ---@param netId number Vehicle network id
    ---@param plate string Vehicle plate text
    --Set/remove any statebags, ect here for a purchased vehicle

    Entity(vehicle).state.NoPush = nil
    Entity(vehicle).state.NoImpound = nil
    Entity(vehicle).state.NoInventory = nil
    Entity(vehicle).state.NoChop = nil
end

Config.VehicleRemovedClientFunction = function(vehicle, plate)
    ---@param vehicle number Vehicle entity id
    ---@param plate string Vehicle plate text
    --client code to run after a vehicle has been removed from a lot by the lister. (set fuel and give keys)

    --exports['LegacyFuel']:SetFuel(vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)
    
end

Config.VehicleRemovedServerFunction = function(vehicle, netId, plate)
    ---@param vehicle number Vehicle entity id
    ---@param netId number Vehicle network id
    ---@param plate string Vehicle plate text
    --Set/remove any statebags, ect here for a vehicle removed off a lot by the lister

    Entity(vehicle).state.NoPush = nil
    Entity(vehicle).state.NoImpound = nil
    Entity(vehicle).state.NoInventory = nil
    Entity(vehicle).state.NoChop = nil
end

Config.VehicleOnLotServerFunction = function(vehicle, netId)
    ---@param vehicle number Vehicle entity id
    ---@param netId number Vehicle network id
    --Set any statebags, ect here for each vehicle spawned on the used lot.

    Entity(vehicle).state.NoPush = true
    Entity(vehicle).state.NoImpound = true
    Entity(vehicle).state.NoInventory = true
    Entity(vehicle).state.NoChop = true
end

Config.VehicleSoldServerFunction = function(plate)
    ---@param Plate string Vehicle plate text
    --Server function called after a vehicle has been sold by its owner

end

Config.Logs = {
    WebHook = '', --Discord webhook
    ListingExpired = function(location, sellerIdentifier, model, plate, vin, garage)
        ---@param location string Location name taken from Config.Locations
        ---@param sellerIdentifier string Vehicle sellers identifier
        ---@param model string Vehicle model
        ---@param plate string Vehicle plate text
        ---@param vin string Vehicle vin number (returns as false if not used)
        ---@param garage string Garage vehicle set to based on Config.Locations
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) has expired. Vehicle returned to garage **'..garage..'**'
        Utils:DiscordLog(Config.Logs.WebHook, 'Listing Expired', 15548997, logString)
    end,
    ListingRemoved = function(location, sellerIdentifier, model, plate, vin, garage)
        ---@param location string Location name taken from Config.Locations
        ---@param sellerIdentifier string Vehicle sellers identifier
        ---@param model string Vehicle model
        ---@param plate string Vehicle plate text
        ---@param vin string Vehicle vin number (returns as false if not used)
        ---@param garage string Garage vehicle set to based on Config.Locations
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) was removed from the lot by the player. Vehicle returned to garage **'..garage..'**'
        Utils:DiscordLog(Config.Logs.WebHook, 'Listing Removed', 15105570, logString)
    end,
    ListingAdded = function(location, sellerSource, sellerIdentifier, model, plate, vin, listingPrice, listingDays)
        ---@param location string Location vehicle listed at based on Config.Locations
        ---@param sellerSource number Server ID of listing player
        ---@param sellerIdentifier string Vehicle sellers identifier
        ---@param model string Vehicle model
        ---@param plate string Vehicle plate text
        ---@param vin string Vehicle vin number (returns as false if not used)
        ---@param listingPrice number Price vehicle listed for
        ---@param listingDays number Days vehicle stays on lot before expiring
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by (Player: **'..sellerIdentifier..'** | ID: **'..sellerSource..'**) on lot (**'..location..'**) for (Price: $**'..Utils:FormatThousand(listingPrice)..'** | Days: **'..listingDays..'**)'
        Utils:DiscordLog(Config.Logs.WebHook, 'Listing Added', 15844367, logString)
    end,
    VehiclePurchased = function(location, buyerSource, buyerIdentifier, sellerSource, sellerIdentifier, model, plate, vin, price, commissionPaid, societyDeposit)
        ---@param location string Location vehicle listed at based on Config.Locations
        ---@param buyerSource number Server ID of buying player
        ---@param buyerIdentifier string Vehicle buyer identifier
        ---@param sellerSource number Server ID of listing player
        ---@param sellerIdentifier string Vehicle sellers identifier
        ---@param model string Vehicle model
        ---@param plate string Vehicle plate text
        ---@param vin string Vehicle vin number (returns as false if not used)
        ---@param price number Price vehicle purchased for
        ---@param commissionPaid number Amount paid to listing player (will be 0 if disabled in Config.Locations)
        ---@param societyDeposit number Amount sent to the DoPayment function to be deposited into society (Will be 0 if disabled in Config.Locations)
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) Purchased by (Player: **'..buyerIdentifier..'** | ID: **'..buyerSource..'**) for $**'..Utils:FormatThousand(price)..'** | Commission paid to seller: $**'..Utils:FormatThousand(commissionPaid)..'** | Society Deposit: $**'..Utils:FormatThousand(societyDeposit)..'**'
        Utils:DiscordLog(Config.Logs.WebHook, 'Listing Purchased', 5763719, logString)
    end,
    VehicleSold = function(location, sellerSource, sellerIdentifier, model, plate, price)
        ---@param location string Location vehicle listed at based on Config.Locations
        ---@param sellerSource number Server ID of player
        ---@param sellerIdentifier string Vehicle sellers identifier
        ---@param model string Vehicle model
        ---@param plate string Vehicle plate text
        ---@param price number Amount vehicle was sold for
        --Server code to create a log when player sells their vehicle
        
        local logString = 'Vehicle (Plate: [**'..plate..'**] '..'Model: [**'..model..'**]) Sold to dealership (**'..location..'**) by (Player: **'..sellerIdentifier..'** | ID: **'..sellerSource..'**) for $**'..Utils:FormatThousand(price)..'**'
        Utils:DiscordLog(Config.Logs.WebHook, 'Vehicle Sold To Dealer', 5763719, logString)
    end,
}

------------------------------------------------------PROGRESS BAR------------------------------------------------------------
Config.ProgressCircle = false --true = circle progress bar from ox_lib / false = rectangle progress bar from ox_lib
Config.ProgressCirclePosition = 'middle' --position of the progress circle. can be either 'middle' or 'bottom'
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------VEHICLE TRANSFER--------------------------------------------------------
Config.VehicleTransfer = {
    Command = {
        UseCommand = true,
        CommandName = 'vehtransfer',
    },
    Item = {
        UseItem = false,
        ItemName = 'vehiclecontract',
    },
    VehicleTransferServerFunction = function(vehicle, netId, plate, sellerSource, buyerSource)
        ---@param vehicle number Vehicle entity id
        ---@param netId number Vehicle net id
        ---@param plate string Vehicle plate text
        ---@param sellerSource number Server ID of selling player
        ---@param buyerSource number Server ID of buying player
        --custom server code after a vehicle is transferred

        --Add code to give vehicle keys to new owner. ([qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

    end,
    VehicleTransferAuthFunction = function(vehicle, model, plate, buyerSource, buyerPlayerData)
        ---@param vehicle number Vehicle entity id
        ---@param model number Vehicle model
        ---@param plate string Vehicle plate text
        ---@param buyerSource number Server ID of buying player
        ---@param buyerPlayerData table Player Data of buying player
        ---@return boolean
        
        --Add custom code here if you want to disable vehicle transfers in a custom way
        return true
    end,
    VehicleTransferBlacklist = { --Vehicles listed here will not be allowed to be transferred between players
        --list models here by spawn code or model number to blacklist them
        --'blista', 
        --1456744817
        
    }
}
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------NOTIFICATIONS-----------------------------------------------------------
Config.Notify = { 
    UseCustom = false, --FALSE = DEFAULT NOTIFY WILL BE YOUR FRAMEWORKS NOTIFY SYSTEM (QBCore:Notify / esx:showNotification) / TRUE = CUSTOM NOTIFY SCRIPT (OX_LIB / T-NOTIFY / ECT) (VIEW README FILE FOR DETAILED SETUP INFO)
    CustomClientNotifyFunction = function(data) --**CLIENT SIDE CODE**
        ---@param data table: { message string, type string, duration number }
        
        --TriggerEvent('QBCore:Notify', data.message, data.type, data.duration) --QBCORE EXAMPLE
    end,
    CustomServerNotifyFunction = function(playerSource, data) --**SERVER SIDE CODE** SAME AS ABOVE EXCEPT PASSES THE SOURCE TO SEND THE NOTIFICATION TO FROM THE SERVER
        ---@param playerSource number Server id of the player
        ---@param data table: { message string, type string, duration number }

        --TriggerClientEvent('QBCore:Notify', playerSource, data.message, data.type, data.duration) --QBCORE EXAMPLE
    end,
}
------------------------------------------------------------------------------------------------------------------------------