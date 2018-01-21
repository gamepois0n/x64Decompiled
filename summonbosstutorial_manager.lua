Panel_SummonBossTutorial:RegisterUpdateFunc("FGlobal_SummonBossTutorialManager_UpdatePerFrame")
local summonText = {}
PaGlobal_SummonBossTutorial_Manager = {
  _isDoingSummonBossTutorial = false,
  _stepNo = 0,
  _updateTime = 0
}
function PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial()
  return self._isDoingSummonBossTutorial
end
function PaGlobal_SummonBossTutorial_Manager:setDoingSummonBossTutorial(bDoing)
  self._isDoingSummonBossTutorial = bDoing
end
function PaGlobal_SummonBossTutorial_Manager:checkPossibleTutorial(index)
  if true == PaGlobal_TutorialManager:isDoingTutorial() or true == PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return false
  end
  if isFlushedUI() then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local inventory = selfPlayer:get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  if nil == inventory then
    return false
  end
  local hasSummonItem = true
  if 0 == index then
    if toInt64(0, 0) == inventory:getItemCount_s64(ItemEnchantKey(42000, 1)) then
      hasSummonItem = false
    end
  elseif 1 == index and toInt64(0, 0) == inventory:getItemCount_s64(ItemEnchantKey(42001, 1)) then
    hasSummonItem = false
  end
  if false == hasSummonItem then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONBOSSTUTORIAL_NOITEM"))
    return false
  end
  return true
end
function PaGlobal_SummonBossTutorial_Manager:startTutorial(index)
  if false == self:checkPossibleTutorial(index) then
    return
  end
  Panel_SummonBossTutorial:SetShow(true, true)
  PaGlobal_SummonBossTutorial_Manager:setDoingSummonBossTutorial(true)
  PaGlobal_SummonBossTutorial_UiManager:hideAllTutorialUi()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetShow(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B_Left:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_R:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:EraseAllEffect()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
  PaGlobal_SummonBossTutorial_UiManager:getUiKeyButton():ButtonToggleAll(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiKeyButton():setShowAll(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit():hideBubbleKey()
  if 0 == index then
    summonText[0] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_23")
    summonText[1] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_24")
    summonText[2] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_26")
  elseif 1 == index then
    summonText[0] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_29")
    summonText[1] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_30")
    summonText[2] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_31")
  elseif 2 == index then
    summonText[0] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_50")
    summonText[1] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_51")
    summonText[2] = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_52")
  end
  self._stepNo = 51
  self:setDoingSummonBossTutorial(true)
end
function PaGlobal_SummonBossTutorial_Manager:updateDeltaTime_SummonBoss_Step1(deltaTime)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B_Left:SetShow(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_I:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetText(summonText[0])
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetText(summonText[1])
  local textSizeX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeX()
  local textSizeY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeY()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetSize(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeX() + PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_I:GetSizeX() + 30, PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeY() + textSizeY + 40)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetSize(textSizeX, textSizeY)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosX(scrX / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetSizeX() / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetSizeX() / 2)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosY(100)
  local obsidianX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosX()
  local obsidianY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosX(obsidianX + 80)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosY(obsidianY + 30)
  local obsidianB_X = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosX()
  local obsidianB_Y = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosY(obsidianB_Y + 25)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_I:SetPosX(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetPosX() + PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeX() + 10)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_I:SetPosY(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetPosY())
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosY(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetPosY() + textSizeY + 5)
  local invenOpenCheck = Panel_Window_Inventory:GetShow()
  self._updateTime = self._updateTime + deltaTime
  if invenOpenCheck or self._updateTime > 20 then
    if not Panel_Window_Inventory:GetShow() then
      InventoryWindow_Show()
    end
    audioPostEvent_SystemUi(4, 12)
    self._updateTime = 0
    self._stepNo = 52
    PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._bubbleKey_I:SetShow(false)
  end
end
function PaGlobal_SummonBossTutorial_Manager:updateDeltaTime_SummonBoss_Step2(deltaTime)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B_Left:SetShow(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_25"))
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetText(summonText[2])
  local textSizeX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeX()
  local textSizeY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeY()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetSize(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeX() + 20, PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeY() + textSizeY + 40)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetSize(textSizeX, textSizeY)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosX(scrX / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetSizeX() / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetSizeX() / 2)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosY(100)
  local obsidianX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosX()
  local obsidianY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosX(obsidianX + 80)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosY(obsidianY + 30)
  local obsidianB_X = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosX()
  local obsidianB_Y = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosY(obsidianB_Y + 25)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosY(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetPosY() + textSizeY + 5)
  if FGlobal_FirstSummonItemUse() then
    self._updateTime = 0
    self._stepNo = 53
  end
  if not Panel_Window_Inventory:GetShow() then
    self._updateTime = 0
    self._stepNo = 0
    PaGlobal_SummonBossTutorial_Manager:endTutorial()
  end
end
function PaGlobal_SummonBossTutorial_Manager:updateDeltaTime_SummonBoss_Step3(deltaTime)
  self._updateTime = self._updateTime + deltaTime
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B_Left:SetShow(false)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetShow(true)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_27"))
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_28"))
  local textSizeX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeX()
  local textSizeY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetTextSizeY()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetSize(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeX() + 20, PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:GetTextSizeY() + textSizeY + 40)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetSize(textSizeX, textSizeY)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosX(scrX / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetSizeX() / 2 - PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetSizeX() / 2)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:SetPosY(100)
  local obsidianX = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosX()
  local obsidianY = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosX(obsidianX + 80)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:SetPosY(obsidianY + 30)
  local obsidianB_X = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosX()
  local obsidianB_Y = PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_B:GetPosY()
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:SetPosY(obsidianB_Y + 25)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosX(obsidianB_X + 3)
  PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text_2:SetPosY(PaGlobal_SummonBossTutorial_UiManager:getUiBlackSpirit()._ui._obsidian_Text:GetPosY() + textSizeY + 5)
  if self._updateTime > 8 then
    self._updateTime = 0
    self._stepNo = 0
    PaGlobal_SummonBossTutorial_Manager:endTutorial()
  end
end
function FGlobal_SummonBossTutorialManager_UpdatePerFrame(deltaTime)
  PaGlobal_SummonBossTutorial_Manager:updatePerFrame(deltaTime)
end
function PaGlobal_SummonBossTutorial_Manager:updatePerFrame(deltaTime)
  if 51 == self._stepNo then
    self:updateDeltaTime_SummonBoss_Step1(deltaTime)
  elseif 52 == self._stepNo then
    self:updateDeltaTime_SummonBoss_Step2(deltaTime)
  elseif 53 == self._stepNo then
    self:updateDeltaTime_SummonBoss_Step3(deltaTime)
  end
end
local summonBossQuest = {
  groupId = {
    654,
    655,
    658,
    682,
    661,
    662,
    663,
    664,
    667,
    669,
    671,
    672,
    673,
    674,
    675,
    675,
    677,
    678,
    690,
    212,
    212,
    351,
    4019,
    4020
  },
  questId = {
    3,
    5,
    6,
    1,
    3,
    4,
    10,
    6,
    6,
    5,
    9,
    1,
    3,
    6,
    4,
    5,
    1,
    6,
    23,
    1,
    2,
    3,
    1,
    1
  }
}
function PaGlobal_SummonBossTutorial_Manager:checkQuestCondition()
  for index = 1, #summonBossQuest.groupId do
    local bossTutorialProgress = questList_hasProgressQuest(summonBossQuest.groupId[index], summonBossQuest.questId[index])
    if bossTutorialProgress then
      local uiQuestInfo = ToClient_GetQuestInfo(summonBossQuest.groupId[index], summonBossQuest.questId[index])
      local questCondition = uiQuestInfo:getDemandAt(0)
      if questCondition._destCount <= questCondition._currentCount then
        PaGlobal_SummonBossTutorial_Manager:endTutorial()
        return
      end
    end
  end
end
function PaGlobal_SummonBossTutorial_Manager:endTutorial()
  Panel_SummonBossTutorial:SetShow(false, true)
  self._isDoingSummonBossTutorial = false
end
