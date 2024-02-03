---@param vehicleData table (player_vehicles/owned_vehicles) database row for selected vehicle
---@return number the remaining balance owed on the vehicle or 0
---Check if a vehicle is under finance
Config.CheckFinance = function(vehicleData)
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

---@param vehicle number Vehicle entity id
---@param netId number Vehicle network id
---@param plate string Vehicle plate text
Config.VehiclePurchasedServerFunction = function(vehicle, netId, plate)
    --Set/remove any statebags, ect here for a purchased vehicle

    Entity(vehicle).state.NoPush = nil
    Entity(vehicle).state.NoImpound = nil
    Entity(vehicle).state.NoInventory = nil
    Entity(vehicle).state.NoChop = nil
end

---@param vehicle number Vehicle entity id
---@param netId number Vehicle network id
---@param plate string Vehicle plate text
Config.VehicleRemovedServerFunction = function(vehicle, netId, plate)
    --Set/remove any statebags, ect here for a vehicle removed off a lot by the lister

    Entity(vehicle).state.NoPush = nil
    Entity(vehicle).state.NoImpound = nil
    Entity(vehicle).state.NoInventory = nil
    Entity(vehicle).state.NoChop = nil
end

---@param vehicle number Vehicle entity id
---@param netId number Vehicle network id
Config.VehicleOnLotServerFunction = function(vehicle, netId)
    --Set any statebags, ect here for each vehicle spawned on the used lot.

    Entity(vehicle).state.NoPush = true
    Entity(vehicle).state.NoImpound = true
    Entity(vehicle).state.NoInventory = true
    Entity(vehicle).state.NoChop = true
end

---@param plate string Vehicle plate text
Config.VehicleSoldServerFunction = function(plate)
    --Server function called after a vehicle has been sold by its owner

end

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
    
    ---@param vehicle number Vehicle entity id
    ---@param netId number Vehicle net id
    ---@param plate string Vehicle plate text
    ---@param sellerSource number Server ID of selling player
    ---@param buyerSource number Server ID of buying player
    --custom server code after a vehicle is transferred
    VehicleTransferServerFunction = function(vehicle, netId, plate, sellerSource, buyerSource)
        --Add code to give vehicle keys to new owner. ([qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

    end
}
------------------------------------------------------------------------------------------------------------------------------

Config.Logs = {
    WebHook = '', --Discord webhook

    ---@param location string Location name taken from Config.Locations
    ---@param sellerIdentifier string Vehicle sellers identifier
    ---@param model string Vehicle model
    ---@param plate string Vehicle plate text
    ---@param vin string Vehicle vin number (returns as false if not used)
    ---@param garage string Garage vehicle set to based on Config.Locations
    ListingExpired = function(location, sellerIdentifier, model, plate, vin, garage)
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) has expired. Vehicle returned to garage **'..garage..'**'
        utils:discordLog(Config.Logs.WebHook, 'Listing Expired', 15548997, logString)
    end,

    ---@param location string Location name taken from Config.Locations
    ---@param sellerIdentifier string Vehicle sellers identifier
    ---@param model string Vehicle model
    ---@param plate string Vehicle plate text
    ---@param vin string Vehicle vin number (returns as false if not used)
    ---@param garage string Garage vehicle set to based on Config.Locations
    ListingRemoved = function(location, sellerIdentifier, model, plate, vin, garage)
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) was removed from the lot by the player. Vehicle returned to garage **'..garage..'**'
        utils:discordLog(Config.Logs.WebHook, 'Listing Removed', 15105570, logString)
    end,

    ---@param location string Location vehicle listed at based on Config.Locations
    ---@param sellerSource number Server ID of listing player
    ---@param sellerIdentifier string Vehicle sellers identifier
    ---@param model string Vehicle model
    ---@param plate string Vehicle plate text
    ---@param vin string Vehicle vin number (returns as false if not used)
    ---@param listingPrice number Price vehicle listed for
    ---@param listingDays number Days vehicle stays on lot before expiring
    ListingAdded = function(location, sellerSource, sellerIdentifier, model, plate, vin, listingPrice, listingDays)
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by (Player: **'..sellerIdentifier..'** | ID: **'..sellerSource..'**) on lot (**'..location..'**) for (Price: $**'..utils:formatThousand(listingPrice)..'** | Days: **'..listingDays..'**)'
        utils:discordLog(Config.Logs.WebHook, 'Listing Added', 15844367, logString)
    end,

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
    VehiclePurchased = function(location, buyerSource, buyerIdentifier, sellerSource, sellerIdentifier, model, plate, vin, price, commissionPaid, societyDeposit)
        --Server code to create a log using listed information

        local logString = 'Vehicle (Plate: [**'..plate..'**] '..(vin and 'VIN: [**'..vin..'**] ' or '')..'Model: [**'..model..'**]) Listed by player (**'..sellerIdentifier..'**) on lot (**'..location..'**) Purchased by (Player: **'..buyerIdentifier..'** | ID: **'..buyerSource..'**) for $**'..utils:formatThousand(price)..'** | Commission paid to seller: $**'..utils:formatThousand(commissionPaid)..'** | Society Deposit: $**'..utils:formatThousand(societyDeposit)..'**'
        utils:discordLog(Config.Logs.WebHook, 'Listing Purchased', 5763719, logString)
    end,

    ---@param location string Location vehicle listed at based on Config.Locations
    ---@param sellerSource number Server ID of player
    ---@param sellerIdentifier string Vehicle sellers identifier
    ---@param model string Vehicle model
    ---@param plate string Vehicle plate text
    ---@param price number Amount vehicle was sold for
    VehicleSold = function(location, sellerSource, sellerIdentifier, model, plate, price)
        --Server code to create a log when player sells their vehicle
        
        local logString = 'Vehicle (Plate: [**'..plate..'**] '..'Model: [**'..model..'**]) Sold to dealership (**'..location..'**) by (Player: **'..sellerIdentifier..'** | ID: **'..sellerSource..'**) for $**'..utils:formatThousand(price)..'**'
        utils:discordLog(Config.Logs.WebHook, 'Vehicle Sold To Dealer', 5763719, logString)
    end,
}