local IM = CppEnums.EProcessorInputMode
local UI_classType = CppEnums.ClassType
runLua("UI_Data/Script/Tutorial/KeyTutorial.lua")
isClearedQuest = false
registerEvent("executeLuaFunc", "executeLuaFunc")
local isFirstSummonBoss = false
function executeLuaFunc(funcText)
  local classType = getSelfPlayer():getClassType()
  if isIntroMoviePlaying then
    return
  end
  local charLevel = getSelfPlayer():get():getLevel()
  if funcText == "move_tutorial1" or funcText == "move_tutorial2" then
  elseif funcText == "closeDialog" then
    close_WindowPanelList()
  elseif funcText == "PVP_Notice" then
    close_WindowPanelList()
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NOWYOUCANKILLANYONE")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = pvpMode_changedMode,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif funcText == "manufacture" then
    Panel_WebHelper_ShowToggle("PanelManufacture")
  elseif funcText == "gathering" then
    Panel_WebHelper_ShowToggle("Gathering")
  elseif funcText == "trade" then
    Panel_WebHelper_ShowToggle("PanelTradeMarketGraph")
  elseif funcText == "node" then
    Panel_WebHelper_ShowToggle("NodeMenu")
  elseif funcText == "housing" then
    Panel_WebHelper_ShowToggle("PanelHouseControl")
  elseif funcText == "tent" then
    Panel_WebHelper_ShowToggle("PanelWindowTent")
  elseif funcText == "alchemy" then
    Panel_WebHelper_ShowToggle("PanelAlchemy")
  elseif funcText == "cook" then
    Panel_WebHelper_ShowToggle("PanelCook")
  elseif funcText == "pet" then
    Panel_WebHelper_ShowToggle("Pet")
  elseif funcText == "servant" then
    Panel_WebHelper_ShowToggle("PanelServantinfo")
  elseif funcText == "stable" then
    Panel_WebHelper_ShowToggle("PanelWindowStableShop")
  elseif funcText == "selectQuest" then
    FGlobal_HideDialog()
    FGlobal_FirstLogin_InGameOpen()
  elseif funcText == "findTargetMovieGuide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif funcText == "learnSkillMovieGuide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
    FGlobal_FirstLearnSkill_WindowShow()
    Panel_SkillCommand:SetShow(false)
  elseif funcText == "acceptQuestMovieGuide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
    Panel_SkillCommand:SetShow(false)
  elseif funcText == "callblackspiritmovieguide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
    Panel_SkillCommand:SetShow(false)
  elseif funcText == "summonBoss1" then
    PaGlobal_SummonBossTutorial_Manager:startTutorial(0)
  elseif funcText == "summonBoss2" then
    PaGlobal_SummonBossTutorial_Manager:startTutorial(1)
  elseif funcText == "summonBoss3" or funcText == "summonBoss4" or funcText == "summonBoss5" or funcText == "summonBoss6" or funcText == "summonBoss7" or funcText == "summonBoss8" or funcText == "summonBoss9" or funcText == "summonBoss10" or funcText == "summonBoss11" or funcText == "summonBoss12" or funcText == "summonBoss13" or funcText == "summonBoss14" or funcText == "summonBoss15" or funcText == "summonBoss16" or funcText == "summonBoss17" or funcText == "summonBoss18" or funcText == "summonBoss19" or funcText == "summonBoss20" or funcText == "summonBoss21" or funcText == "summonBoss22" or funcText == "summonBoss23" or funcText == "summonBoss24" then
    PaGlobal_SummonBossTutorial_Manager:startTutorial(2)
  elseif funcText == "arousal_attack_tutorial" then
    PaGlobal_ArousalTutorial_Manager:startTutorial()
  elseif funcText == "huntingTutorial1" then
    FGlobal_HuntingTutorial(1)
  elseif funcText == "huntingTutorial2" then
    FGlobal_HuntingTutorial(2)
  elseif funcText == "huntingTutorial3" then
    FGlobal_HuntingTutorial(3)
  elseif funcText == "huntingTutorialEnd" then
    FGlobal_HuntingTutorialEnd()
  end
end
