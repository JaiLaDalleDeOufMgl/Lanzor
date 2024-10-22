function MOD_InteractionKey:addListerner(handler)
    MOD_InteractionKey.listeners[#MOD_InteractionKey.listeners + 1] = handler
end