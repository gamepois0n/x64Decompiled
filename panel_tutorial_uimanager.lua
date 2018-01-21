registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_TutorialUiManager")
registerEvent("onScreenResize", "FromClient_TutorialScreenReposition")
registerEvent("EventSelfPlayerLevelUp", "FromClient_EventSelfPlayerLevelUp_TutorialUiManager")
PaGlobal_TutorialUiManager = {
  _uiList = {
    _uiBlackSpirit = nil,
    _uiKeyButton = nil,
    _uiHeadlineMessage = nil,
    _uiMasking = nil
  },
  _uiPanelInfo = {}
}
PaGlobal_TutorialUiManager._uiPanelInfo = {
  [Panel_SelfPlayerExpGage] = CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage,
  [Panel_UIMain] = CppEnums.PAGameUIType.PAGameUIPanel_UIMenu,
  [Panel_Radar] = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
  [Panel_QuickSlot] = CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot,
  [Panel_MainStatus_User_Bar] = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusBar,
  [Panel_Party] = CppEnums.PAGameUIType.PAGameUIPanel_Party,
  [Panel_CheckedQuest] = CppEnums.PAGameUIType.PAGameUIPanel_CheckedQuest,
  [Panel_MyHouseNavi] = CppEnums.PAGameUIType.PAGameUIPanel_MyHouseNavi,
  [Panel_Window_Servant] = CppEnums.PAGameUIType.PAGameUIPanel_ServantWindow,
  [Panel_NewEquip] = CppEnums.PAGameUIType.PAGameUIPanel_NewEquipment,
  [Panel_PvpMode] = CppEnums.PAGameUIType.PAGameUIPanel_PvpMode,
  [Panel_Adrenallin] = CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin,
  [Panel_GameTips] = CppEnums.PAGameUIType.PAGameUIPanel_GameTips,
  [Panel_TimeBar] = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
  [Panel_SkillCommand] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand,
  [Panel_ClassResource] = CppEnums.PAGameUIType.PAGameUIPanel_ClassResource,
  [Panel_NewQuickSlot_1] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_1,
  [Panel_NewQuickSlot_2] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_2,
  [Panel_NewQuickSlot_3] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_3,
  [Panel_NewQuickSlot_4] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_4,
  [Panel_NewQuickSlot_5] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_5,
  [Panel_NewQuickSlot_6] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_6,
  [Panel_NewQuickSlot_7] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_7,
  [Panel_NewQuickSlot_8] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_8,
  [Panel_NewQuickSlot_9] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_9,
  [Panel_NewQuickSlot_0] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_0,
  [Panel_NewQuickSlot_11] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_11,
  [Panel_NewQuickSlot_12] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_12,
  [Panel_NewQuickSlot_13] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_13,
  [Panel_NewQuickSlot_14] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_14,
  [Panel_NewQuickSlot_15] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_15,
  [Panel_NewQuickSlot_16] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_16,
  [Panel_NewQuickSlot_17] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_17,
  [Panel_NewQuickSlot_18] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_18,
  [Panel_NewQuickSlot_19] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_19,
  [Panel_NewQuickSlot_10] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_10,
  [Panel_SkillCooltime] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
  [Panel_Movie_KeyViewer] = CppEnums.PAGameUIType.PAGameUIPanel_KeyViewer,
  [Panel_MainQuest] = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest
}
function PaGlobal_TutorialUiManager:initialize()
  self._uiList._uiBlackSpirit = PaGlobal_TutorialUiBlackSpirit
  self._uiList._uiKeyButton = PaGlobal_TutorialUiKeyButton
  self._uiList._uiHeadlineMessage = PaGlobal_TutorialUiHeadlineMessage
  self._uiList._uiMasking = PaGlobal_TutorialUiMasking
  _PA_LOG("\234\179\189\235\175\188\236\154\176", "PaGlobal_TutorialUiManager:initialize() UI \235\167\164\235\139\136\236\160\128 \236\180\136\234\184\176\237\153\148 \236\153\132\235\163\140!")
  Panel_Tutorial:RegisterShowEventFunc(true, "FGlobal_Tutorial_ShowAni()")
  Panel_Tutorial:RegisterShowEventFunc(false, "FGlobal_Tutorial_HideAni()")
  PaGlobal_TutorialManager:handleTutorialUiManagerInitialize()
end
function FGlobal_Tutorial_ShowAni()
  PaGlobal_TutorialUiManager:showAni()
end
function FGlobal_Tutorial_HideAni()
  PaGlobal_TutorialUiManager:hideAni()
end
function PaGlobal_TutorialUiManager:showAni()
  PaGlobal_TutorialUiBlackSpirit:changeBubbleTextureForAni(false)
  Panel_Tutorial:ResetVertexAni()
  Panel_Tutorial:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo = Panel_Tutorial:addColorAnimation(0, 0.75, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
end
function PaGlobal_TutorialUiManager:hideAni()
  PaGlobal_TutorialUiBlackSpirit:changeBubbleTextureForAni(false)
  Panel_Tutorial:ResetVertexAni()
  Panel_Tutorial:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo = Panel_Tutorial:addColorAnimation(0, 1.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo.IsChangeChild = true
  aniInfo:SetHideAtEnd(true)
  aniInfo:SetDisableWhileAni(true)
end
function PaGlobal_TutorialUiManager:loadAllUiSavedInfo()
  for key, value in pairs(self._uiPanelInfo) do
    local isShow = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if -1 ~= isShow then
      key:SetShow(isShow)
      local posX = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_PositionX)
      local posY = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_PositionY)
      local relativePosX = -1
      local relativePosY = -1
      if CppDefine.ChangeUIAndResolution == true then
        relativePosX = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        relativePosY = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      end
      if -1 ~= posX or -1 ~= posY then
        key:SetPosX(posX)
        key:SetPosY(posY)
        if CppDefine.ChangeUIAndResolution == true then
          key:SetRelativePosX(relativePosX)
          key:SetRelativePosY(relativePosY)
          PAGlobal_setIsChangePanelState(value, true, false)
        end
        onReSizePanel(key)
      end
      checkAndSetPosInScreen(key)
    end
  end
  Panel_ClassResource:SetShow(true)
  local chattingPanelCount = ToClient_getChattingPanelCount()
  for panelIndex = 0, chattingPanelCount - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIndex)
    local chatPanelUI = FGlobal_getChattingPanel(panelIndex)
    chatPanelUI:SetShow(chatPanel:isOpen())
    local posX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_PositionX)
    local posY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_PositionY)
    chatPanelUI:SetPosX(posX)
    chatPanelUI:SetPosY(posY)
    if CppDefine.ChangeUIAndResolution == true then
      local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
      local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      chatPanelUI:SetRelativePosX(relativePosX)
      chatPanelUI:SetRelativePosY(relativePosY)
      PAGlobal_setIsChangePanelState(panelIndex + chattingPanelCount, true, true)
    end
  end
  Chatting_OnResize()
end
function onReSizePanel(key)
  if key == Panel_NewEquip then
    Panel_NewEquip_ScreenResize()
  elseif key == Panel_MainStatus_User_Bar then
    Panel_MainStatus_User_Bar_Onresize()
  elseif key == Panel_MainQuest then
    FromClient_MainQuestWidget_ResetPosition()
  elseif key == Panel_SkillCommand then
    FGlobal_SkillCommand_ResetPosition()
  elseif key == Panel_PvpMode then
    PvpMode_Resize()
  elseif key == Panel_Party then
    partWidget_OnscreenEvent()
  elseif key == Panel_Movie_KeyViewer then
    Panel_KeyViewer_ScreenRePosition()
  elseif key == Panel_CheckedQuest then
    FromClient_questWidget_ResetPosition()
  elseif key == Panel_Adrenallin then
    Panel_Adrenallin_OnSreenResize()
  elseif key == Panel_QuickSlot then
    QuickSlot_OnscreenResize()
  end
end
function FromClient_TutorialScreenReposition()
  PaGlobal_TutorialUiManager:repositionScreen()
end
function PaGlobal_TutorialUiManager:repositionScreen()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Tutorial:SetSize(scrX, scrY)
  Panel_Tutorial:SetPosX(0)
  Panel_Tutorial:SetPosY(0)
  for key, value in pairs(self._uiList) do
    for _, vv in pairs(value._ui) do
      vv:ComputePos()
    end
  end
end
function PaGlobal_TutorialUiManager:closeAllWindow()
  if check_ShowWindow() then
    close_WindowPanelList()
  else
    FGlobal_HideDialog()
  end
end
function PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  local isTutorialSkip = 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(CppEnums.GlobalUIOptionType.TutorialSkip)
  if CheckTutorialEnd() or isTutorialSkip then
    self:loadAllUiSavedInfo()
    if true == Panel_WorldMap:GetShow() and Panel_CheckedQuest:GetShow() then
      FGlobal_QuestWidget_Close()
    end
  end
  if isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KOR) or isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_JAP) then
    FGlobal_PersonalIcon_ButtonPosUpdate()
  end
  self:showConditionalUi()
  Panel_ClassResource:SetShow(true)
end
function PaGlobal_TutorialUiManager:showConditionalUi()
  FGlobal_MyHouseNavi_Update()
  FGlobal_PersonalIcon_ButtonPosUpdate()
  Panel_Widget_TownNpcNavi:SetShow(true, true)
  FGlobal_PetControl_CheckUnSealPet()
  FGlobal_Party_ConditionalShow()
  PaGlobal_PossessByBlackSpiritIcon_UpdateVisibleState()
  PaGlobal_CharacterTag_SetPosIcon()
  if 1 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_GameTips, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
    GameTips_Show()
    GameTips_Reposition()
  end
  if isPvpEnable() then
    PvpMode_ShowButton(true)
  else
    PvpMode_ShowButton(false)
  end
  FGlobal_ResetRadarUI()
end
function PaGlobal_TutorialUiManager:setShowAllDefaultUi(isShow)
  Panel_SelfPlayerExpGage:SetShow(isShow)
  Panel_PersonalIcon:SetShow(isShow)
  Panel_PersonalIcon_Left:SetShow(isShow)
  Panel_TimeBar:SetShow(isShow)
  FGlobal_Panel_Radar_Show(isShow)
  FGlobal_Panel_RadarRealLine_Show(isShow)
  Panel_Adrenallin:SetShow(isShow)
  Panel_CheckedQuest:SetShow(isShow)
  Panel_MainQuest:SetShow(isShow)
  PaGlobal_TutorialUiManager:setShowChattingPanel(isShow)
  Panel_GameTips:SetShow(isShow)
  Panel_GameTipMask:SetShow(isShow)
  Panel_MainStatus_User_Bar:SetShow(isShow)
  if true == Panel_MainStatus_User_Bar:GetShow() then
    FGlobal_ClassResource_SetShowControl(true)
  elseif false == Panel_MainStatus_User_Bar:GetShow() then
    FGlobal_ClassResource_SetShowControl(false)
  end
  FGlobal_NewQuickSlot_Update()
  QuickSlot_UpdateData()
  Panel_UIMain:SetShow(isShow)
  Panel_SkillCommand:SetShow(isShow)
  if true == isShow then
    FGlobal_PersonalIcon_ButtonPosUpdate()
    FGlobal_MyHouseNavi_Update()
    Panel_NewEventProduct_Alarm:SetShow(isShow)
    FGlobal_PetControl_CheckUnSealPet()
    PaGlobal_PossessByBlackSpiritIcon_UpdateVisibleState()
    PaGlobal_CharacterTag_SetPosIcon()
  elseif false == isShow then
    local navi = FGlobal_GetPersonalIconControl(0)
    local movie = FGlobal_GetPersonalIconControl(1)
    local voiceChat = FGlobal_GetPersonalIconControl(2)
    local hunting = FGlobal_GetPersonalIconControl(3)
    local siegeArea = FGlobal_GetPersonalIconControl(4)
    siegeArea:SetShow(false)
    hunting:SetShow(false)
    voiceChat:SetShow(false)
    movie:SetShow(false)
    Panel_Widget_TownNpcNavi:SetShow(false)
    Panel_MyHouseNavi:SetShow(false)
    Panel_Window_PetIcon:SetShow(false)
    Panel_Window_PetControl:SetShow(false)
    Panel_ChallengeReward_Alert:SetShow(false)
    Panel_Movie_KeyViewer:SetShow(false)
    PaGlobal_Camp._btn_Camp:SetShow(false)
    Panel_Icon_CharacterTag:SetShow(false)
  end
  if isPvpEnable() then
    PvpMode_ShowButton(true)
  else
    PvpMode_ShowButton(false)
  end
end
function PaGlobal_TutorialUiManager:hideAllTutorialUi()
  for _, v in pairs(self._uiList) do
    for __, vv in pairs(v._ui) do
      vv:SetShow(false)
    end
  end
end
function PaGlobal_TutorialUiManager:setShowChattingPanel(isShow)
  local chattingPanelCount = ToClient_getChattingPanelCount()
  for panelIndex = 0, chattingPanelCount - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIndex)
    if chatPanel:isOpen() then
      local chatPanelUI = FGlobal_getChattingPanel(panelIndex)
      chatPanelUI:SetShow(isShow)
      if chatPanel:isCombinedToMainPanel() == true and panelIndex ~= 0 then
        chatPanelUI:SetShow(false)
      end
    end
  end
  Panel_Chat0:SetShow(isShow)
end
function FromClient_luaLoadComplete_TutorialUiManager()
  PaGlobal_TutorialUiManager:initialize()
end
function FromClient_EventSelfPlayerLevelUp_TutorialUiManager()
  if CheckTutorialEnd() then
    PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  end
end
function PaGlobal_TutorialUiManager:getUiBlackSpirit()
  return self._uiList._uiBlackSpirit
end
function PaGlobal_TutorialUiManager:getUiKeyButton()
  return self._uiList._uiKeyButton
end
function PaGlobal_TutorialUiManager:getUiHeadlineMessage()
  return self._uiList._uiHeadlineMessage
end
function PaGlobal_TutorialUiManager:getUiMasking()
  return self._uiList._uiMasking
end
