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

function MoreHeat.WrapWithin(caller, callee, wrapper)
  local newEnv = {}
  setmetatable(newEnv, {__index = _G})
  local oldCallee = newEnv[callee]
  newEnv[callee] = function(...)
    return wrapper(oldCallee, ...)
  end
  ModUtil.BaseOverride(caller, load(string.dump(_G[caller]), nil, "b", newEnv))
end

MoreHeat.WrapWithin("CreateBoonLootButtons", "IsMetaUpgradeSelected", function(baseFunc, name)
  local components = ScreenAnchors.ChoiceScreen.Components
  if name == "RerollPanelMetaUpgrade" and CalcNumLootChoices() == 0 then
    components["RerollPanel"] = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu_TraitTray" })
    Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 410 })
    components["RerollPanel"].OnPressedFunctionName = "CancelUpgrade"
    components["RerollPanel"].ControlHotkey = "Confirm"
    return false
  else
    return baseFunc(name)
  end
end)

function CancelUpgrade(screen, button)
  CloseUpgradeChoiceScreen( screen, button )
  wait( 0.2, RoomThreadName )
  if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
    UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
  end
end
