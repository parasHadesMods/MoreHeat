ModUtil.RegisterMod("MoreHeat")

ModUtil.LoadOnce(function()
  MetaUpgradeData.ShopPricesShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.EnemyHealthShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.EnemyDamageShrineUpgrade.MaxInvestment = 10
  MetaUpgradeData.TrapDamageShrineUpgrade.MaxInvestment = 2
  MetaUpgradeData.TrapDamageShrineUpgrade.HelpTextTable = nil
  MetaUpgradeData.EnemySpeedShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.ReducedLootChoicesShrineUpgrade.CostTable = { 2, 3, 4 }
  MetaUpgradeData.EnemyShieldShrineUpgrade.CostTable = { 1, 1, 1, 1 }
  MetaUpgradeData.EnemyCountShrineUpgrade.CostTable = { 1, 1, 1, 1, 1, 1 }
  MetaUpgradeData.EnemyEliteShrineUpgrade.CostTable = { 2, 3, 3, 3 }
  MetaUpgradeData.BiomeSpeedShrineUpgrade.CostTable = { 1, 2, 3, 4 }
  MetaUpgradeData.BiomeSpeedShrineUpgrade.HelpTextTable[4] = "BiomeSpeedShrineUpgrade_4"
  BiomeTimeLimits.Timers[4] = { 0, 180, 180, 180, 180 }
  MetaUpgradeData.NoInvulnerabilityShrineUpgrade.GameStateRequirements = nil
end)

function MoreHeat.CloneFunction(func, wrapper)
  local newEnv = {}
  setmetatable(newEnv, {__index = _G})
  local newFunc = load(string.dump(func), nil, "b", newEnv)
  return wrapper(newEnv, newFunc)
end

function MoreHeat.WrapWithin(caller, callee, wrapper)
  local newEnv = {}
  setmetatable(newEnv, {__index = _G})
  local oldCallee = newEnv[callee]
  newEnv[callee] = function(...)
    return wrapper(oldCallee, ...)
  end
  ModUtil.BaseOverride(caller, load(string.dump(_G[caller]), nil, "b", newEnv))
end

MoreHeat.CreateBoonLootButtons = MoreHeat.CloneFunction(CreateBoonLootButtons, function(env, func)
  local originalIsMetaUpgradeSelected = env.IsMetaUpgradeSelected
  env.IsMetaUpgradeSelected = function(name)
    local components = ScreenAnchors.ChoiceScreen.Components
    if name == "RerollPanelMetaUpgrade" and CalcNumLootChoices() == 0 then
      components["RerollPanel"] = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu_TraitTray" })
      Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 410 })
      components["RerollPanel"].OnPressedFunctionName = "CancelUpgrade"
      return false
    else
      return originalIsMetaUpgradeSelected(name)
    end
  end
  return func
end)

ModUtil.BaseOverride("CreateBoonLootButtons", function( lootData, reroll )
  return MoreHeat.CreateBoonLootButtons(lootData, reroll)
end)

function CancelUpgrade(screen, button)
  CloseUpgradeChoiceScreen( screen, button )
  wait( 0.2, RoomThreadName )
  if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
    UnlockRoomExits( CurrentRun, CurrentRun,CurrentRoom )
  end
end
