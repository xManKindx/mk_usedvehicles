Config = {}

Config.VinNumberField = 'vin' --SET TO VIN NUMBER FIELD FOR PLAYER_VEHICLES (QB) OR OWNED_VEHICLES (ESX) TABLE IF YOU USE VIN NUMBER. EXAMPLE: 'vin_number'
Config.FinanceBalanceColumn = 'balance' --SET THIS TO YOUR COLUMN IN YOUR VEHICLES DATABASE THAT STORES FINANCING BALANCE FOR OWNED VEHICLES. SET false IF YOU DO NO USE FINANCING
Config.FakePlateColumn = 'fakeplate' --SET THIS TO YOUR COLUMN IN YOUR VEHICLES DATABASE THAT STORES FAKEPLATES FOR OWNED VEHICLES. SET false IF YOU DO NOT USE FAKE PLATES
Config.GarageColumn = 'garage' --SET THIS TO YOUR COLUMN IN YOUR VEHICLES DATABASE THAT STORES THE GARAGE NAME WHERE VEHICLES ARE PARKED

Config.ConsoleLogging = true --TRUE DISPLAYS SCRIPT LOGGING INFO IN F8 AND SERVER CONSOLE

Config.RestrictJobVehicles = {
    Restrict = true,
    JobColumn = 'job', --COLUMN TO CHECK IN THE VEHICLES DATABASE FOR A RESTRICTED JOB NAME.
    RestrictedJobs = {
        'police',
        'ambulance'
    }
}

Config.VehiclePurchasedClientFunction = function(Vehicle, Plate)
    ---@param Vehicle number Vehicle entity id
    ---@param Plate string Vehicle plate text
    --client code to run after a vehicle has been purchased. (set fuel and give keys)

    --exports['LegacyFuel']:SetFuel(Vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

end

Config.VehiclePurchasedServerFunction = function(Vehicle, NetId, Plate)
    ---@param Vehicle number Vehicle entity id
    ---@param NetId number Vehicle network id
    ---@param Plate string Vehicle plate text
    --Set/remove any statebags, ect here for a purchased vehicle

    Entity(Vehicle).state.NoPush = nil
    Entity(Vehicle).state.NoImpound = nil
    Entity(Vehicle).state.NoInventory = nil
    Entity(Vehicle).state.NoChop = nil
end

Config.VehicleRemovedClientFunction = function(Vehicle, Plate)
    ---@param Vehicle number Vehicle entity id
    ---@param Plate string Vehicle plate text
    --client code to run after a vehicle has been removed from a lot by the lister. (set fuel and give keys)

    --exports['LegacyFuel']:SetFuel(Vehicle, 100) 
    --custom give keys function here [qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)
    
end

Config.VehicleRemovedServerFunction = function(Vehicle, NetId, Plate)
    ---@param Vehicle number Vehicle entity id
    ---@param NetId number Vehicle network id
    ---@param Plate string Vehicle plate text
    --Set/remove any statebags, ect here for a vehicle removed off a lot by the lister

    Entity(Vehicle).state.NoPush = nil
    Entity(Vehicle).state.NoImpound = nil
    Entity(Vehicle).state.NoInventory = nil
    Entity(Vehicle).state.NoChop = nil
end

Config.VehicleOnLotServerFunction = function(Vehicle, NetId)
    ---@param Vehicle number Vehicle entity id
    ---@param NetId number Vehicle network id
    --Set any statebags, ect here for each vehicle spawned on the used lot.

    Entity(Vehicle).state.NoPush = true
    Entity(Vehicle).state.NoImpound = true
    Entity(Vehicle).state.NoInventory = true
    Entity(Vehicle).state.NoChop = true
end

Config.VehicleSoldServerFunction = function(Plate)
    ---@param Plate string Vehicle plate text
    --Server function called after a vehicle has been sold by its owner
end

Config.Logs = {
    ListingExpired = function(Location, SellerIdentifier, Model, Plate, Vin, Garage)
        ---@param Location string Location name taken from Config.Locations
        ---@param SellerIdentifier string Vehicle sellers identifier
        ---@param Model string Vehicle model
        ---@param Plate string Vehicle plate text
        ---@param Vin string Vehicle vin number (returns as false if not used)
        ---@param Garage string Garage vehicle set to based on Config.Locations
        --Server code to create a log using listed information

    end,
    ListingRemoved = function(Location, SellerIdentifier, Model, Plate, Vin, Garage)
        ---@param Location string Location name taken from Config.Locations
        ---@param SellerIdentifier string Vehicle sellers identifier
        ---@param Model string Vehicle model
        ---@param Plate string Vehicle plate text
        ---@param Vin string Vehicle vin number (returns as false if not used)
        ---@param Garage string Garage vehicle set to based on Config.Locations
        --Server code to create a log using listed information

    end,
    ListingAdded = function(Location, SellerSource, SellerIdentifier, Model, Plate, Vin, ListingPrice, ListingDays)
        ---@param Location string Location vehicle listed at based on Config.Locations
        ---@param SellerSource number Server ID of listing player
        ---@param SellerIdentifier string Vehicle sellers identifier
        ---@param Model string Vehicle model
        ---@param Plate string Vehicle plate text
        ---@param Vin string Vehicle vin number (returns as false if not used)
        ---@param ListingPrice number Price vehicle listed for
        ---@param ListingDays number Days vehicle stays on lot before expiring
        --Server code to create a log using listed information

    end,
    VehiclePurchased = function(Location, BuyerSource, BuyerIdentifier, SellerSource, SellerIdentifier, Model, Plate, Vin, Price, CommissionPaid, SocietyDeposit)
        ---@param Location string Location vehicle listed at based on Config.Locations
        ---@param BuyerSource number Server ID of buying player
        ---@param BuyerIdentifier string Vehicle buyer identifier
        ---@param SellerSource number Server ID of listing player
        ---@param SellerIdentifier string Vehicle sellers identifier
        ---@param Model string Vehicle model
        ---@param Plate string Vehicle plate text
        ---@param Vin string Vehicle vin number (returns as false if not used)
        ---@param Price number Price vehicle purchased for
        ---@param CommissionPaid number Amount paid to listing player (will be 0 if disabled in Config.Locations)
        ---@param SocietyDeposit number Amount sent to the DoPayment function to be deposited into society (Will be 0 if disabled in Config.Locations)
        --Server code to create a log using listed information

    end,
    VehicleSold = function(Location, SellerSource, SellerIdentifier, Model, Plate, Price)
        ---@param Location string Location vehicle listed at based on Config.Locations
        ---@param SellerSource number Server ID of player
        ---@param SellerIdentifier string Vehicle sellers identifier
        ---@param Model string Vehicle model
        ---@param Plate string Vehicle plate text
        ---@param Price number Amount vehicle was sold for
        --Server code to create a log when player sells their vehicle
        
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
    VehicleTransferServerFunction = function(Vehicle, NetId, Plate, SellerSource, BuyerSource)
        ---@param Vehicle number Vehicle entity id
        ---@param NetId number Vehicle net id
        ---@param Plate string Vehicle plate text
        ---@param SellerSource number Server ID of selling player
        ---@param BuyerSource number Server ID of buying player
        --custom server code after a vehicle is transferred

        --Add code to give vehicle keys to new owner. ([qb-vehiclekeys] and [mk_vehiclekeys] are checked automatically by the script so you don't have to add them here)

    end,
    VehicleTransferAuthFunction = function(Vehicle, Model, Plate)
        ---@param Vehicle number Vehicle entity id
        ---@param Model number Vehicle model
        ---@param Plate string Vehicle plate text
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
    CustomClientNotifyFunction = function(Data) --**CLIENT SIDE CODE**
        ---@param Data table: { Message string, Type string, Duration number }
        
        --TriggerEvent('QBCore:Notify', Data.Message, Data.Type, Data.Duration) --QBCORE EXAMPLE
    end,
    CustomServerNotifyFunction = function(PlayerSource, Data) --**SERVER SIDE CODE** SAME AS ABOVE EXCEPT PASSES THE SOURCE TO SEND THE NOTIFICATION TO FROM THE SERVER
        ---@param PlayerSource number Server id of the player
        ---@param Data table: { Message string, Type string, Duration number }

        --TriggerClientEvent('QBCore:Notify', PlayerSource, Data.Message, Data.Type, Data.Duration) --QBCORE EXAMPLE
    end,
}
------------------------------------------------------------------------------------------------------------------------------