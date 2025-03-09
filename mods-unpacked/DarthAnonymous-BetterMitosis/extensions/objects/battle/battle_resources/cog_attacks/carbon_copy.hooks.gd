extends Object
func action(chain: ModLoaderHookChain) -> void:
    var hooked_instance = chain.reference_object
    var original_hp = hooked_instance.user.stats.hp
    await chain.execute_next_async()
      # --- At this point vanilla code has executed ---
    # The original action has already instanced and added the copy cog.
    var manager = hooked_instance.manager
    var user_index: int = manager.cogs.find(hooked_instance.user)
    if user_index == -1 or user_index + 1 >= manager.cogs.size():
        push_warning("Carbon Copy hook: couldn't locate the copy cog")
        return
    var copy: Cog = hooked_instance.manager.cogs[user_index + 1]
    # Set the copy's HP to be the same as the original cog's HP.
    copy.stats.hp = original_hp
    
