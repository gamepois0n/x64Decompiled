local luaLoadAfterTime = 0
local luaLoadAfterFrameCount = 0
local alchemyStoneTimeCheck = 0
function FGlobal_getLuaLoadTime()
  return luaLoadAfterTime
end
function FGlobal_getFrameCount()
  return luaLoadAfterFrameCount
end
function Panel_OnlyPerframeUsedFunction(deltaTime)
  luaLoadAfterTime = luaLoadAfterTime + deltaTime
  luaLoadAfterFrameCount = luaLoadAfterFrameCount + 1
  if nil ~= NewQuickSlot_UpdatePerFrame then
    NewQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame then
    FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= Competition_UpdatePerFrame then
    Competition_UpdatePerFrame(deltaTime)
  end
  if nil ~= GameTips_MessageUpdate then
    GameTips_MessageUpdate(deltaTime)
  end
  if nil ~= OnlyPerFrame_ProgressBar_Collect_Update then
    OnlyPerFrame_ProgressBar_Collect_Update(deltaTime)
  end
  if nil ~= WorldMap_NaviButton_RePos then
    WorldMap_NaviButton_RePos()
  end
  if nil ~= ChattingViewManager_UpdatePerFrame then
    ChattingViewManager_UpdatePerFrame(deltaTime)
  end
  if Panel_WhereUseItemDirection:GetShow() then
    WhereUseItemDirectionRestore()
  end
  if nil ~= FGlobal_AlchemyStonCheck() then
    local cooltime = FGlobal_AlchemyStonCheck()
    if cooltime > 0 then
      if 0 == alchemyStoneTimeCheck then
        FGlobal_AlchemyStone_Use()
      end
      alchemyStoneTimeCheck = alchemyStoneTimeCheck + deltaTime
      if cooltime < alchemyStoneTimeCheck then
        alchemyStoneTimeCheck = 0
      end
    else
      alchemyStoneTimeCheck = 0
    end
  end
  if nil ~= FGlobal_AutoQuestManager_UpdatePerFrame then
    FGlobal_AutoQuestManager_UpdatePerFrame(deltaTime)
  end
  if nil ~= AutoFrameCheckManager_UpdatePerFrame then
    AutoFrameCheckManager_UpdatePerFrame()
  end
  if nil ~= Update_ReconnectHorse then
    Update_ReconnectHorse()
  end
  if nil ~= Auto_FrameMove then
    Auto_FrameMove(deltaTime)
  end
  if CppEnums.CountryType.DEV == getGameServiceType() and nil ~= ConsoleUISimplifyPerFrameUpdate then
    ConsoleUISimplifyPerFrameUpdate(deltaTime)
  end
  if nil ~= FGlobal_GuildBattle_UpdatePerFrame then
    FGlobal_GuildBattle_UpdatePerFrame(deltaTime)
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_OnlyPerframeUsed")
function FromClient_luaLoadComplete_OnlyPerframeUsed()
  Panel_OnlyPerframeUsed:SetShow(true)
  Panel_OnlyPerframeUsed:RegisterUpdateFunc("Panel_OnlyPerframeUsedFunction")
  if CppEnums.CountryType.DEV == getGameServiceType() then
    Panel_OnlyPerframeUsed:setConsoleUIPanelType(3)
  end
end
