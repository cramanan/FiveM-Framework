print("Starting core:shared...")

CORE = {
    events = {
        GET_INFO = "framework:core:get_info"
    }
}

BANKING = {
    config = {
        defaultBalanceAmount = 0,
        defaultWalletAmount = 0,
    },

    events = {
        GET_INFO = "framework:banking:server:get_banking"
    }
}

WEAPON = {
    events = {
        GET_INFO = "framework:banking:server:get_weapons"
    },
}
