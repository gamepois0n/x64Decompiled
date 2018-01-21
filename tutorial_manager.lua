PaGlobal_TutorialManager = {
  _isDoingTutorial = false,
  _currentPhaseNo = 0,
  _isInitialized = false,
  _isAllowCallBlackSpirit = false,
  _isAllowShowQuickSlot = true,
  _isAllowNewQuickSlot = true,
  _isAllowMainQuestWidget = true,
  _classType = 0,
  _phaseList = {},
  _classBasicSkillPhaseList = {},
  _skippableLevel = 50,
  _questList = {
    [1] = {_questGroupNo = 650, _questId = 1},
    [2] = {_questGroupNo = 650, _questId = 2},
    [3] = {_questGroupNo = 650, _questId = 3},
    [4] = {_questGroupNo = 653, _questId = 5},
    [5] = {_questGroupNo = 1001, _questId = 71},
    [6] = {_questGroupNo = 653, _questId = 7},
    [7] = {_questGroupNo = 2039, _questId = 2},
    [8] = {_questGroupNo = 2039, _questId = 3},
    [10] = {_questGroupNo = 654, _questId = 4},
    [11] = {_questGroupNo = 658, _questId = 8}
  },
  _checkPointList = {
    [1] = {_phaseNo = 1, _stepNo = 1},
    [2] = {_phaseNo = 5, _stepNo = 2},
    [3] = {_phaseNo = 5, _stepNo = 3},
    [4] = {_phaseNo = 6, _stepNo = 1},
    [5] = {_phaseNo = 7, _stepNo = 1},
    [6] = {_phaseNo = 7, _stepNo = 2},
    [7] = {_phaseNo = 8, _stepNo = 1},
    [8] = {_phaseNo = 8, _stepNo = 2},
    [9] = {_phaseNo = 9, _stepNo = 1},
    [10] = {_phaseNo = 14, _stepNo = 1},
    [11] = {_phaseNo = 15, _stepNo = 1},
    [13] = {_phaseNo = 17, _stepNo = 1},
    [15] = {_phaseNo = 20, _stepNo = 1}
  },
  _firstCutSceneList = {
    [1] = "CS_Velia_00_PHM_Start_0001.pas",
    [2] = "CS_Velia_00_PHW_Start_0001.pas",
    [3] = "CS_Velia_00_PGM_Start_0001.pas",
    [4] = "CS_Velia_00_PBW_Start_0001.pas",
    [5] = "CS_Velia_00_PKM_Start_0001.pas",
    [6] = "CS_Velia_00_PEW_Start_0001.pas",
    [7] = "CS_Velia_00_PVW_Start_0001.pas",
    [8] = "CS_Velia_00_PKW_Start_0001.pas",
    [9] = "CS_Velia_00_PWM_Start_0001.pas",
    [10] = "CS_Velia_00_PWW_Start_0001.pas",
    [11] = "CS_Velia_00_PNW_Start_0001.pas",
    [12] = "CS_Velia_00_PNM_Start_0001.pas"
  }
}
Panel_Tutorial:RegisterUpdateFunc("FGlobal_TutorialManager_UpdatePerFrame")
timeRatio = 1
function tutotest(phaseNo, stepNo, ratio)
  PaGlobal_TutorialManager:startTutorial(phaseNo, stepNo)
  if nil ~= ratio then
    timeRatio = ratio
  end
end
function tutoend()
  PaGlobal_TutorialManager:endTutorial()
end
function tutospeed(ratio)
  timeRatio = ratio
end
function PaGlobal_TutorialManager:getClassType()
  return self._classType
end
function FGlobal_TutorialManager_UpdatePerFrame(deltaTime)
  PaGlobal_TutorialManager:updatePerFrame(deltaTime)
end
function PaGlobal_TutorialManager:isDoingTutorial()
  return Panel_Tutorial:GetShow() or self._isDoingTutorial
end
function PaGlobal_TutorialManager:setDoingTutorial(bDoing)
  self._isDoingTutorial = bDoing
end
function PaGlobal_TutorialManager:findCheckPointNoForContinue()
  local checkPointNo = -1
  if false == questList_isClearQuest(650, 1) and false == questList_hasProgressQuest(650, 1) then
    checkPointNo = 1
  elseif true == questList_hasProgressQuest(650, 1) then
    checkPointNo = 2
  elseif true == questList_isClearQuest(650, 1) and false == questList_isClearQuest(650, 2) and false == questList_hasProgressQuest(650, 2) then
    checkPointNo = 2
  elseif true == questList_hasProgressQuest(650, 2) then
    checkPointNo = 3
  elseif true == questList_isClearQuest(650, 2) and false == questList_isClearQuest(650, 3) and false == questList_hasProgressQuest(650, 3) then
    checkPointNo = 4
  elseif true == questList_hasProgressQuest(650, 3) and false == self:isSatisfiedQuestCondition(650, 3) then
    checkPointNo = 5
  elseif true == questList_hasProgressQuest(650, 3) and true == self:isSatisfiedQuestCondition(650, 3) then
    checkPointNo = 6
  end
  if true == questList_hasProgressQuest(653, 5) and false == questList_isClearQuest(1001, 71) and false == questList_hasProgressQuest(1001, 71) then
    checkPointNo = 7
  elseif true == questList_hasProgressQuest(653, 5) and true == questList_hasProgressQuest(1001, 71) and false == self:isSatisfiedQuestCondition(1001, 71) then
    checkPointNo = 8
  end
  if true == questList_isClearQuest(653, 5) and true == questList_hasProgressQuest(653, 7) then
    checkPointNo = 9
  end
  if true == questList_hasProgressQuest(2039, 2) and false == self:isSatisfiedQuestCondition(2039, 2) then
    checkPointNo = 10
  end
  if true == questList_hasProgressQuest(658, 8) and false == self:isSatisfiedQuestCondition(658, 8) then
    checkPointNo = 15
  end
  return checkPointNo
end
function PaGlobal_TutorialManager:isSatisfiedQuestCondition(questGroupNo, questId)
  local uiQuestInfo = ToClient_GetQuestInfo(questGroupNo, questId)
  if nil == uiQuestInfo then
    _PA_ASSERT(false, "\237\128\152\236\138\164\237\138\184\234\176\128 \236\160\149\235\179\180\234\176\128 \236\151\134\236\150\180\236\132\156 \236\167\132\237\150\137\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \235\141\176\236\157\180\237\132\176\234\176\128 \235\179\128\234\178\189\235\144\156\234\178\131\236\157\184\234\177\176\235\130\152 \235\163\168\236\149\132\237\133\140\236\157\180\235\184\148\236\157\152 \236\152\164\237\131\128\236\157\188\236\136\152\235\143\132 \236\158\136\236\138\181\235\139\136\235\139\164. PaGlobal_TutorialManager:isSatisfiedQuestCondition()")
    return nil
  end
  return uiQuestInfo:isSatisfied()
end
function PaGlobal_TutorialManager:checkHaveOverLevelCharacter(destLevel)
  local characterDataCount = getCharacterDataCount()
  local compLevel = self._skippableLevel
  if nil ~= destLevel then
    compLevel = destLevel
  end
  for index = 0, characterDataCount - 1 do
    local characterData = getCharacterDataByIndex(index)
    if compLevel <= characterData._level then
      return true
    end
  end
  return false
end
function PaGlobal_TutorialManager:initialize()
  if nil ~= getSelfPlayer() then
    self._classType = getSelfPlayer():getClassType()
  end
  self._phaseList[1] = PaGlobal_TutorialPhase_BasicMove
  self._phaseList[2] = PaGlobal_TutorialPhase_BasicControl
  self._phaseList[3] = PaGlobal_TutorialPhase_InteractionSupplyBox
  self._phaseList[4] = PaGlobal_TutorialPhase_InventoryAndQuickSlot
  self._phaseList[5] = PaGlobal_TutorialPhase_CallBlackSpirit
  self:initializeClassBasicSkillPhaseTable()
  self._phaseList[6] = self:getClassBasicSkillPhase()
  self._phaseList[7] = PaGlobal_TutorialPhase_FindRequestTarget
  self._phaseList[8] = PaGlobal_TutorialPhase_WesternGuardCamp
  self._phaseList[9] = PaGlobal_TutorialPhase_AncientStoneChamber
  self._phaseList[10] = PaGlobal_TutorialPhase_WorldmapNodeAndNavi
  self._phaseList[11] = PaGlobal_TutorialPhase_WorldmapBuyHouse
  self._phaseList[12] = PaGlobal_TutorialPhase_WorldmapMenu
  self._phaseList[13] = PaGlobal_TutorialPhase_Hidel_FindNearNpc
  self._phaseList[14] = PaGlobal_TutorialPhase_Hidel_Trade
  self._phaseList[15] = PaGlobal_TutorialPhase_Hidel_Worker
  self._phaseList[16] = PaGlobal_TutorialPhase_NewItemEquip
  self._phaseList[17] = PaGlobal_TutorialPhase_ItemSell
  self._phaseList[18] = PaGlobal_TutorialPhase_Enchant
  self._phaseList[19] = PaGlobal_TutorialPhase_ExtractionEnchantStone
  self._phaseList[20] = PaGlobal_TutorialPhase_WallRiding
  self._phaseList[21] = PaGlobal_TutorialPhase_ItemSellPractice
  self._phaseList[22] = PaGlobal_TutorialPhase_EnchantStack
  self._isInitialized = true
end
function PaGlobal_TutorialManager:getClassBasicSkillPhase()
  if nil ~= self._classType then
    return self._classBasicSkillPhaseList[self._classType]
  end
  _PA_ASSERT(false, "PaGlobal_TutorialManager:getClassBasicSkillPhase() : classType\236\157\180 \235\185\132\236\160\149\236\131\129\236\160\129\236\158\133\235\139\136\235\139\164.")
  return nil
end
function PaGlobal_TutorialManager:initializeClassBasicSkillPhaseTable()
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Warrior] = PaGlobal_TutorialPhase_BasicSkill_Warrior
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Sorcerer] = PaGlobal_TutorialPhase_BasicSkill_Sorcerer
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Ranger] = PaGlobal_TutorialPhase_BasicSkill_Ranger
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Giant] = PaGlobal_TutorialPhase_BasicSkill_Giant
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Tamer] = PaGlobal_TutorialPhase_BasicSkill_Tamer
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_BladeMaster] = PaGlobal_TutorialPhase_BasicSkill_BladeMaster
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_BladeMasterWomen] = PaGlobal_TutorialPhase_BasicSkill_BladeMasterWomen
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Valkyrie] = PaGlobal_TutorialPhase_BasicSkill_Valkyrie
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_NinjaMan] = PaGlobal_TutorialPhase_BasicSkill_NinjaMan
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_NinjaWomen] = PaGlobal_TutorialPhase_BasicSkill_NinjaWomen
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Wizard] = PaGlobal_TutorialPhase_BasicSkill_Wizard
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_WizardWomen] = PaGlobal_TutorialPhase_BasicSkill_WizardWomen
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_DarkElf] = PaGlobal_TutorialPhase_BasicSkill_DarkElf
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Combattant] = PaGlobal_TutorialPhase_BasicSkill_Combattant
  self._classBasicSkillPhaseList[23] = PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  self._classBasicSkillPhaseList[11] = PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  self._classBasicSkillPhaseList[17] = PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  self._classBasicSkillPhaseList[CppEnums.ClassType.ClassType_Lahn] = PaGlobal_TutorialPhase_BasicSkill_Ran
end
function PaGlobal_TutorialManager:checkPossibleTutorial(phaseNo)
  if true == PaGlobal_ArousalTutorial_Manager:isDoingArousalTutorial() then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\234\176\129\236\132\177 \237\138\156\237\134\160\235\166\172\236\150\188 \236\167\132\237\150\137\236\164\145\236\157\180\235\175\128\235\161\156 \237\138\156\237\134\160\235\166\172\236\150\188\236\157\132 \236\139\156\236\158\145\236\139\156\237\130\164\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. phaseNo : " .. tostring(phaseNo))
    return false
  end
  return true
end
function PaGlobal_TutorialManager:continueTutorial()
  local checkPointNo = self:findCheckPointNoForContinue()
  if -1 == checkPointNo then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\237\138\156\237\134\160\235\166\172\236\150\188\236\157\132 \236\157\180\236\150\180\236\132\156 \237\149\160 \236\167\128\236\160\144\236\157\132 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\150\180\236\132\156 \237\138\156\237\134\160\235\166\172\236\150\188\236\157\132 \236\139\156\236\158\145\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. \235\167\140\236\149\189 \237\138\156\237\134\160\235\166\172\236\150\188\236\157\132 \236\167\132\237\150\137\237\149\180\236\149\188 \237\149\152\235\138\148 \236\131\129\237\153\169\236\157\180\235\157\188\235\169\180 \236\178\180\237\129\172\237\143\172\236\157\184\237\138\184\235\165\188 \236\176\190\235\138\148 \236\161\176\234\177\180\236\157\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. findCheckPointNoForContinue()")
    return
  end
  local destCheckPoint = self._checkPointList[checkPointNo]
  if nil == destCheckPoint or nil == destCheckPoint._phaseNo or nil == destCheckPoint._stepNo then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\237\138\156\237\134\160\235\166\172\236\150\188 checkPoint\236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  self:initialize()
  self:startTutorial(destCheckPoint._phaseNo, destCheckPoint._stepNo)
end
function PaGlobal_TutorialManager:startTutorial(phaseNo, stepNo, typeNo)
  _PA_LOG("\234\179\189\235\175\188\236\154\176", "#####\237\138\156\237\134\160\235\166\172\236\150\188 \236\139\156\236\158\145\236\139\156\235\143\132#####")
  if false == self:checkPossibleTutorial(phaseNo) then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\237\138\156\237\134\160\235\166\172\236\150\188 \236\139\156\236\158\145 \236\161\176\234\177\180\236\157\132 \235\167\140\236\161\177\237\149\152\236\167\128 \235\170\187\237\149\180\236\132\156 \236\139\156\236\158\145\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. phaseNo : " .. tostring(phaseNo))
    return
  end
  if false == self._isInitialized then
    self:initialize()
  end
  local destPhaseNo = 0
  if nil == phaseNo or 0 == phaseNo then
    destPhaseNo = 1
  else
    destPhaseNo = phaseNo
  end
  if nil == self:getPhase(destPhaseNo) then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\236\139\156\236\158\145\237\149\152\235\160\164\235\138\148 \237\142\152\236\157\180\236\166\136\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. destPhaseNo : " .. tostring(destPhaseNo))
    return
  end
  local destStepNo = 0
  if nil == stepNo or 0 == stepNo then
    destStepNo = 1
  else
    destStepNo = stepNo
  end
  local destTypeNo = 0
  if nil == typeNo or 0 == typeNo then
    destTypeNo = 1
  else
    destTypeNo = typeNo
  end
  self._phaseList[destPhaseNo]:startPhase(destStepNo, destTypeNo)
end
function PaGlobal_TutorialManager:startNextPhase()
  self._currentPhaseNo = self._currentPhaseNo + 1
  if self._currentPhaseNo > 0 and nil == self._phaseList[self._currentPhaseNo] then
    self:endTutorial()
  else
    self._phaseList[self._currentPhaseNo]:startPhase(1, 1)
  end
end
function PaGlobal_TutorialManager:endTutorial()
  self:setDoingTutorial(false)
  if 1 == self._currentPhaseNo then
    getSelfPlayer():setActionChart("WAIT")
  end
  Panel_Tutorial:SetShow(false, true)
  FGlobal_NewQuickSlot_Update()
  QuickSlot_UpdateData()
  PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  self:setAllowCallBlackSpirit(true)
  self:setCurrentPhaseNo(0)
  _PA_LOG("\234\179\189\235\175\188\236\154\176", "#####\237\138\156\237\134\160\235\166\172\236\150\188 \236\162\133\235\163\140#####")
end
function PaGlobal_TutorialManager:getCurrentPhase()
  if nil == self._phaseList[self._currentPhaseNo] then
    return nil
  end
  return self._phaseList[self._currentPhaseNo]
end
function PaGlobal_TutorialManager:setCurrentPhaseNo(phaseNo)
  self._currentPhaseNo = phaseNo
end
function PaGlobal_TutorialManager:getPhase(phaseNo)
  return self._phaseList[phaseNo]
end
function PaGlobal_TutorialManager:updatePerFrame(deltaTime)
  if nil ~= self:getCurrentPhase() and true == self:isDoingTutorial() then
    self:getCurrentPhase():updatePerFrame(deltaTime)
  end
end
function PaGlobal_TutorialManager:getQuestIdByQuestNoRaw(questNoRaw)
  return math.floor(questNoRaw / 65536)
end
function PaGlobal_TutorialManager:getQuestGroupNoByQuestNoRaw(questNoRaw)
  return questNoRaw % 65536
end
function PaGlobal_TutorialManager:getQuestNoRawByQuestGroupNoAndQuestId(questGroupNo, questId)
  return questId * 65536 + questGroupNo
end
function PaGlobal_TutorialManager:setAllowCallBlackSpirit(bAllow)
  self._isAllowCallBlackSpirit = bAllow
end
function PaGlobal_TutorialManager:isAllowCallBlackSpirit()
  return self._isAllowCallBlackSpirit
end
function PaGlobal_TutorialManager:isBeginnerTutorialQuest(questGroupNo, questId)
  for index, value in pairs(self._questList) do
    if value._questGroupNo == questGroupNo and value._questId == questId then
      return true
    end
  end
  return false
end
function PaGlobal_TutorialManager:isSkippablePhase(phaseTable)
  if true == phaseTable._isSkippable then
    return true
  end
  return false
end
function PaGlobal_TutorialManager:questionPhaseSkip(phase, stepNo, typeNo)
  local function askYesButton()
    phase:startPhaseXXX(stepNo, typeNo)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(CppEnums.GlobalUIOptionType.TutorialSkip, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  local function askNoButton()
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "\237\138\156\237\134\160\235\166\172\236\150\188\236\157\180 \236\130\172\236\154\169\236\158\144\236\151\144 \236\157\152\237\149\180 \236\138\164\237\130\181\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. phase : " .. tostring(phase._phaseNo))
    PaGlobal_TutorialManager:endTutorial()
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(CppEnums.GlobalUIOptionType.TutorialSkip, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  local isTutorialSkip = 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(CppEnums.GlobalUIOptionType.TutorialSkip)
  if isTutorialSkip then
    askNoButton()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_NEW_KR_29")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_NEW_KR_30"),
      content = messageBoxMemo,
      functionYes = askYesButton,
      functionNo = askNoButton,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_TutorialManager:showSuggestTutorialButton(phaseNo, stepNo, typeNo)
  local function askYesButton()
    self:startTutorial(phaseNo, stepNo, typeNo)
  end
  local messageBoxMemo = "(\237\133\140\236\138\164\237\138\184)\237\138\156\237\134\160\235\166\172\236\150\188\236\157\132 \236\139\156\236\158\145\237\149\160\234\185\140\236\154\148~?"
  local messageBoxData = {
    title = "\237\138\156\237\134\160\235\166\172\236\150\188 \236\160\156\236\149\136 \235\178\132\237\138\188 \237\133\140\236\138\164\237\138\184",
    content = messageBoxMemo,
    functionYes = askYesButton,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_TutorialManager:acceptTriggerQuest(questNoRaw)
  local questGroupNo = self:getQuestGroupNoByQuestNoRaw(questNoRaw)
  local questId = self:getQuestIdByQuestNoRaw(questNoRaw)
  if true == self:isBeginnerTutorialQuest(questGroupNo, questId) then
    self:continueTutorial()
  end
end
function PaGlobal_TutorialManager:clearTriggerQuest(questNoRaw)
  local questGroupNo = self:getQuestGroupNoByQuestNoRaw(questNoRaw)
  local questId = self:getQuestIdByQuestNoRaw(questNoRaw)
  if true == self:isBeginnerTutorialQuest(questGroupNo, questId) then
    self:continueTutorial()
  end
end
function PaGlobal_TutorialManager:setAllowShowQuickSlot(bAllow)
  self._isAllowShowQuickSlot = bAllow
end
function PaGlobal_TutorialManager:isAllowShowQuickSlot()
  if true == self:isDoingTutorial() then
    return self._isAllowShowQuickSlot
  end
  return true
end
function PaGlobal_TutorialManager:setAllowNewQuickSlot(bAllow)
  self._isAllowNewQuickSlot = bAllow
end
function PaGlobal_TutorialManager:isAllowNewQuickSlot(bAllow)
  if true == self:isDoingTutorial() then
    return self._isAllowNewQuickSlot
  end
  return true
end
function PaGlobal_TutorialManager:setAllowMainQuestWidget(bAllow)
  self._isAllowMainQuestWidget = bAllow
end
function PaGlobal_TutorialManager:isAllowMainQuestWidget()
  if true == self:isDoingTutorial() then
    return self._isAllowMainQuestWidget
  end
  return true
end
function PaGlobal_TutorialManager:getStringResize(string1, string2, stringType)
  local stringSizeY = 0
  if 1 == stringType then
    PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_1:SetText(string1)
    stringSizeY = PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_1:GetTextSizeY()
  elseif 2 == stringType then
    PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_2:SetText(string1)
    stringSizeY = PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_2:GetTextSizeY()
  elseif 3 == stringType then
    PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_3:SetText(string1)
    stringSizeY = PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_3:GetTextSizeY()
  elseif 4 == stringType then
    PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_4:SetText(string1)
    stringSizeY = PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._nextStep_4:GetTextSizeY()
  end
  local stringSet = string1 .. "\n" .. string2
  if stringSizeY > 20 then
    stringSet = string1 .. string2
  else
    stringSet = string1 .. "\n" .. string2
  end
  return stringSet
end
