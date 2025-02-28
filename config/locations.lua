Config.Locations = {
    Larrys = { --This table name must be unique from other locations. Make this something simple and identifiable as its name is used in the database
        MinListPercent = 0.25, --Minimum amount to list vehicle on lot (% of base vehicle price) default (0.25 which = 25%) - Prevents people from listing for $1
        ListingFeePercent = 0.05, --Fee charged to list vehicle on lot. (% of list amount) default (0.05 which = 5%)
        MinListingDays = 1, --Must be at least 1
        MaxListingDays = 7, --As many as you want
        PlateListing = 'FOR SALE', --What the plates will show as on each vehicle on the lot. Must be 8 characters or less.
        GarageReturn = '', --SET GARAGE VEHICLE IS DEFAULT TO WHEN LISTING EXPIRES OR VEHICLE IS PURCHASED.
        VehicleBuyback = {
            Enable = false, --true = Enable players to sell their owned vehicle for a percentage of the buy price / false = disabled on this lot
            Rate = 0.50, --% of original sale price vehicle will sell for (0.50 = 50%)
        },
        JobLocked = { --Any job listed in the table below will be allowed to list/sell vehicles on this lot. leave empty if you want anyone to list vehicles here
            --'myjob'
        },
        BuyerAuth = {
            ---@param vehicle number Vehicle entity id
            ---@param model string Model name of the vehicle
            ---@param plate string Vehicle plate text
            IsAuth = function(vehicle, model, plate) 
                --Set a custom function to check if a player is allowed to buy vehicles off this lot. must return true if they can or false if they cannot. Default is true

                return true
            end
        },
        SellerAuth = {
            ---@param vehicle number Vehicle entity id
            ---@param plate string Vehicle plate text
            IsAuth = function(vehicle, plate)
                --Set a custom function to check if a player is allowed to sell vehicles on this lot. Must return true if they can or false if they cannot. Default is true

                return true
            end
        },
        SocietyPayment = {
            Enable = false, --true = vehicle purchase amount is split between the player who listed the vehicle (commission) and a society account deposit / false = entire sale price goes to player who listed vehicle
            SellerComission = 0.10, --.10 = 10 % sale price given to player who listed the vehicle

            ---@param amount number Amount to be deposited into society (Vehicle sale price - Seller commission)
            DoPayment = function(amount)
                --Enter server side event/export here to deposit funds into your society account for this lot

            end
        },
        Blip = {
            Coords = {x = 1233.37, y = 2707.99, z = 38.01},
            Name = "Larry's Used Car Lot", 
            Sprite = 810, 
            Color = 38,
            ShortRange = true, --true = only see blip while close / false = see blip at all times
            Scale = 0.6
        },
        RestrictByModel = { --Add specific vehicle model/hashes here to limit only those types on this used lot
            --'blista',
            --1456744817
        },
        RestrictByClass = { --Add vehicle class numbers to this table to limit only those classes on this used lot (See all vehicle classes in documentation)
            --8, --Motorcycles 
        },
        BlacklistModels = { --Any models listed here will not be allowed to be listed on this lot
            --'blista',
            --1456744817
        },
        BlacklistClasses = { --Any vehicle classes listed here will not be allowed to be listed on this lot
            --8, --Motorcycles
        },
        LotPoly = { --Zone using ox_lib when entered will allow listing/buying of vehicles on the lot.
            Coords = {
                vector3(1201.6109619141, 2690.7583007812, 38.0),
                vector3(1281.3555908203, 2688.9653320312, 38.0),
                vector3(1301.6568603516, 2689.1506347656, 38.0),
                vector3(1300.3671875, 2711.5400390625, 38.0),
                vector3(1274.3854980469, 2746.8701171875, 38.0),
                vector3(1204.1881103516, 2752.3549804688, 38.0),
            },
            debug = false, --will show the zone for debug purposes if set to true
        },
        Spots = { --Spots listed below are the available areas where vehicles can be listed on this lot. 
            {Coords = {x = 1237.07, y = 2699.00, z = 38.27, h = 1.5}},
            {Coords = {x = 1232.98, y = 2698.92, z = 38.27, h = 2.5}},
            {Coords = {x = 1228.90, y = 2698.78, z = 38.27, h = 3.5}},
            {Coords = {x = 1224.90, y = 2698.51, z = 38.27, h = 2.5}},
            {Coords = {x = 1220.93, y = 2698.28, z = 38.27, h = 2.5}},
            {Coords = {x = 1216.97, y = 2698.05, z = 38.27, h = 0.5}},
            {Coords = {x = 1216.67, y = 2709.21, z = 38.27, h = 1.5}},
            {Coords = {x = 1220.67, y = 2709.26, z = 38.27, h = 1.5}},
            {Coords = {x = 1224.53, y = 2709.27, z = 38.27, h = 2.5}},
            {Coords = {x = 1228.52, y = 2709.42, z = 38.27, h = 1.5}},
            {Coords = {x = 1232.53, y = 2709.49, z = 38.27, h = 1.5}},
            {Coords = {x = 1236.71, y = 2709.51, z = 38.27, h = 1.5}},
            {Coords = {x = 1216.41, y = 2717.99, z = 38.27, h = 1.5}},
            {Coords = {x = 1220.39, y = 2718.00, z = 38.27, h = 0.5}},
            {Coords = {x = 1224.35, y = 2718.07, z = 38.27, h = 1.5}},
            {Coords = {x = 1228.41, y = 2718.22, z = 38.27, h = 1.5}},
            {Coords = {x = 1249.63, y = 2707.84, z = 38.27, h = 99.5}},
            {Coords = {x = 1248.92, y = 2712.25, z = 38.27, h = 101.5}},
            {Coords = {x = 1247.30, y = 2716.59, z = 38.27, h = 120.5}},
            {Coords = {x = 1243.34, y = 2719.39, z = 37.52, h = 142.05}},
            {Coords = {x = 1239.33, y = 2721.39, z = 37.52, h = 149.48}},
            {Coords = {x = 1248.28, y = 2727.41, z = 38.53, h = 338.5}},
            {Coords = {x = 1251.84, y = 2725.65, z = 38.52, h = 331.5}},
            {Coords = {x = 1255.19, y = 2723.21, z = 38.44, h = 309.5}},
            {Coords = {x = 1257.28, y = 2719.77, z = 38.49, h = 296.5}},
            {Coords = {x = 1258.43, y = 2716.20, z = 38.46, h = 285.5}},
            {Coords = {x = 1258.92, y = 2712.28, z = 38.37, h = 270.5}},
            {Coords = {x = 1258.90, y = 2708.30, z = 38.21, h = 269.5}},
            {Coords = {x = 1258.87, y = 2704.21, z = 38.05, h = 271.5}},
            {Coords = {x = 1269.11, y = 2694.67, z = 37.85, h = 184.5}},
            {Coords = {x = 1273.53, y = 2694.98, z = 37.87, h = 184.5}},
            {Coords = {x = 1277.56, y = 2695.43, z = 37.87, h = 183.5}},
            {Coords = {x = 1281.53, y = 2695.67, z = 37.88, h = 186.5}},
            {Coords = {x = 1285.51, y = 2696.02, z = 37.88, h = 185.5}},
            {Coords = {x = 1289.74, y = 2696.27, z = 37.88, h = 182.5}},
            {Coords = {x = 1293.75, y = 2696.47, z = 37.86, h = 184.5}}
        }
    },

    Mosley = { 
        MinListPercent = 0.25, 
        ListingFeePercent = 0.05, 
        MinListingDays = 1, 
        MaxListingDays = 7,
        PlateListing = 'FOR SALE', 
        GarageReturn = '', 
        VehicleBuyback = {
            Enable = false,
            Rate = 0.50,
        },
        JobLocked = {
            
        },
        BuyerAuth = {
            IsAuth = function(vehicle, model, plate)
                return true
            end
        },
        SellerAuth = {
            IsAuth = function(vehicle, plate)
                return true
            end
        },
        SocietyPayment = {
            Enable = false,
            SellerComission = 0.10,
            DoPayment = function(amount)

            end
        },
        Blip = {
            Coords = {x = -43.63, y = -1679.77, z = 29.02},
            Name = "Mosley's Used Car Lot", 
            Sprite = 810, 
            Color = 38,
            ShortRange = true,
            Scale = 0.6
        },
        RestrictByModel = { 

        },
        RestrictByClass = {

        },
        BlacklistModels = { 
            
        },
        BlacklistClasses = {
            
        },
        LotPoly = {
            Coords = {
                vec3(-10.0, -1681.0, 29.0),
                vec3(-55.0, -1702.0, 29.0),
                vec3(-69.0, -1690.0, 29.0),
                vec3(-29.0, -1642.0, 29.0),
            },
            debug = false,
        },
        Spots = { 
            {Coords = {x = -41.19, y = -1688.44, z =  29.06, h =  358.97}},
            {Coords = {x = -45.34, y = -1689.62, z =  29.08, h =  356.7}},
            {Coords = {x = -49.09, y = -1691.59, z =  29.14, h =  356.06}},
            {Coords = {x = -52.84, y = -1692.73, z =  29.17, h =  357.42}},
            {Coords = {x = -59.01, y = -1687.39, z =  29.17, h =  251.98}},
            {Coords = {x = -56.78, y = -1684.32, z =  29.17, h =  254.74}},
            {Coords = {x = -54.24, y = -1681.26, z =  29.15, h =  256.86}},
            {Coords = {x = -51.1,  y = -1677.82, z = 29.05,  h = 259.46}},
        }
    },
}
