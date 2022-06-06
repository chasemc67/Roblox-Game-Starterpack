local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

-- Action creator for the ReceivedNewPhoneNumber action
local ReceivedNewPhoneNumber = Rodux.makeActionCreator("ReceivedNewPhoneNumber", function(phoneNumber)
    return {
        phoneNumber = phoneNumber,
    }
end)

-- Action creator for the MadeNewFriends action
local function MadeNewFriends(listOfNewFriends)
    return {
        type = "MadeNewFriends",
        newFriends = listOfNewFriends,
    }
end

-- Reducer for the current user's phone number
local phoneNumberReducer = Rodux.createReducer("", {
    ReceivedNewPhoneNumber = function(state, action)
        return action.phoneNumber
    end,
})

-- Reducer for the current user's list of friends
local friendsReducer = Rodux.createReducer({}, {
    MadeNewFriends = function(state, action)
        local newState = {}

        -- Since state is read-only, we copy it into newState
        for index, friend in ipairs(state) do
            newState[index] = friend
        end

        for _, friend in ipairs(action.newFriends) do
            table.insert(newState, friend)
        end

        return newState
    end,
})

local reducer = Rodux.combineReducers({
    myPhoneNumber = phoneNumberReducer,
    myFriends = friendsReducer,
})

local store = Rodux.Store.new(reducer, nil, {
    Rodux.loggerMiddleware,
})

-- store:dispatch(ReceivedNewPhoneNumber("15552345678"))
-- store:dispatch(MadeNewFriends({
--     "Cassandra",
--     "Joe",
-- }))

return store