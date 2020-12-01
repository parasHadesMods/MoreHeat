ModUtil.RegisterMod("MoreHeat")

ModUtil.LoadOnce(function()
  MetaUpgradeData.ShopPricesShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.EnemyHealthShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.EnemyDamageShrineUpgrade.MaxInvestment = 10
  MetaUpgradeData.TrapDamageShrineUpgrade.MaxInvestment = 2
  MetaUpgradeData.TrapDamageShrineUpgrade.HelpTextTable = nil
  MetaUpgradeData.EnemySpeedShrineUpgrade.MaxInvestment = 4
  MetaUpgradeData.EnemyShieldShrineUpgrade.CostTable = { 1, 1, 1, 1 }
  MetaUpgradeData.EnemyCountShrineUpgrade.CostTable = { 1, 1, 1, 1, 1, 1 }
  MetaUpgradeData.EnemyEliteShrineUpgrade.CostTable = { 2, 3, 3, 3 }
  MetaUpgradeData.BiomeSpeedShrineUpgrade.CostTable = { 1, 2, 3, 4, 5 }
  MetaUpgradeData.BiomeSpeedShrineUpgrade.HelpTextTable[4] = "BiomeSpeedShrineUpgrade_4"
  MetaUpgradeData.BiomeSpeedShrineUpgrade.HelpTextTable[5] = "BiomeSpeedShrineUpgrade_5"
  BiomeTimeLimits.Timers[4] = { 0, 180, 180, 180, 180 }
  BiomeTimeLimits.Timers[5] = { 0, 60, 60, 60, 60 }
  MetaUpgradeData.NoInvulnerabilityShrineUpgrade.GameStateRequirements = nil
end)
