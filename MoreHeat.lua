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
  MetaUpgradeData.BiomeSpeedShrineUpgrade.CostTable = { 1, 2, 3, 4 }
  MetaUpgradeData.BiomeSpeedShrineUpgrade.HelpTextTable[4] = "BiomeSpeedShrineUpgrade_4"
  BiomeTimeLimits.Timers[4] = { 0, 180, 180, 180, 180 }
  MetaUpgradeData.NoInvulnerabilityShrineUpgrade.GameStateRequirements = nil
end)
