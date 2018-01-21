local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
local _uiMode = UIMode.eUIMode_Default
local escHandle = false
local isRunClosePopup = false
local mouseKeyTable = {}
function GlobalKeyBinder_MouseKeyMap(uiInputType)
  mouseKeyTable[uiInputType] = true
  GlobalKeyBinder_Update(0)
end
local GlobalKeyBinder_CheckKeyPressed = function(keyCode)
  return isKeyDown_Once(keyCode)
end
local function GlobalKeyBinder_CheckCustomKeyPressed(uiInputType)
  return (keyCustom_IsDownOnce_Ui(uiInputType) or mouseKeyTable[uiInputType]) and not GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_MENU) and not isPhotoMode()
end
local GlobalKeyBinder_CheckProgress = function()
  if Panel_Collect_Bar:GetShow() or Panel_Product_Bar:GetShow() or Panel_Enchant_Bar:GetShow() then
    return true
  end
  return false
end
local InteractionCheck = function(interactionType)
  if interactionType == CppEnums.InteractionType.InteractionType_ExchangeItem or interactionType == CppEnums.InteractionType.InteractionType_InvitedParty or interactionType == CppEnums.InteractionType.InteractionType_GuildInvite then
    return true
  end
  return false
end
local function GlobalKeyBinder_Clear()
  mouseKeyTable = {}
end
local _keyBinder_GameMode = function()
  DragManager:clearInfo()
end
local _keyBinder_UIMode = function()
end
local function _keyBinder_Chatting()
  uiEdit = GetFocusEdit()
  if WaitComment_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      settingWaitCommentConfirm()
    end
    return true
  elseif FGlobal_CheckEditBox_IngameCashShop_NewCart(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EscapeEditBox_IngameCashShop_NewCart(false)
    end
    return true
  elseif FGlobal_CheckEditBox_GuildRank(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EscapeEditBox_GuildRank()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      GuildSearch_Confirm()
    end
    return true
  elseif FGlobal_CheckEditBox_IngameCashShop(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EscapeEditBox_IngameCashShop()
    end
    return true
  elseif FGlobal_CheckEditBox_PetCompose(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      FGlobal_EscapeEditBox_PetCompose(false)
    end
    return true
  elseif NpcNavi_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      NpcNavi_OutInputMode(false)
    end
    return true
  elseif ChatInput_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
      if ToClient_isComposition() then
        return
      end
      ChatInput_PressedUp()
    elseif isKeyPressed(VCK.KeyCode_MENU) then
      ChatInput_CheckReservedKey()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_TAB) then
      ChatInput_ChangeInputFocus()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if ToClient_isComposition() then
        return
      end
      ChatInput_CancelAction()
      ChatInput_CancelMessage()
      ChatInput_Close()
      ClearFocusEdit()
      friend_clickAddFriendClose()
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      ChatInput_CheckInstantCommand()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) or isKeyPressed(VCK.KeyCode_BACK) then
      ChatInput_CheckRemoveLinkedItem()
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ChatTabNext) then
      moveChatTab(true)
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ChatTabPrev) then
      moveChatTab(false)
    end
  elseif AddFriendInput_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      friend_clickAddFriendClose()
    end
    return true
  elseif FriendMessanger_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      friend_killFocusMessangerByKey()
    end
    return true
  elseif FGlobal_CheckCurrentVendingMachineUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_VendingMachineClearFocusEdit(uiEdit)
    end
    return true
  elseif FGlobal_CheckCurrentConsignmentSaleUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ConsignmentSaleClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckGuildLetsWarUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildLetsWarClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckGuildNoticeUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildNoticeClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckGuildIncentiveUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildIncentiveClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckArshaPvpUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaPvPClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckArshaNameUiEdit_A(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaNameClearFocusEdit_A()
    end
    return true
  elseif FGlobal_CheckArshaNameUiEdit_B(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaNameClearFocusEdit_B()
    end
    return true
  elseif FGlobal_CheckGuildIntroduceUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildIntroduceClearFocusEdit()
    end
    return true
  elseif FGlobal_ChattingFilter_UiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ChattingFilter_ClearFocusEdit()
    end
    return true
  elseif FGlobal_CheckPartyListUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PartyListClearFocusEdit()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      FGlobal_PartyListClearFocusEdit()
      HandleClicked_PartyList_DoSearch()
    end
    return true
  elseif FGlobal_CheckPartyListRecruiteUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PartyListClearFocusEdit()
    end
    return true
  elseif Panel_Knowledge_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_Knowledge_OutInputMode(false)
    end
    return true
  elseif false == GlobalSwitch_UseOldAlchemy and FGlobal_Alchemy_CheckEditBox(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Alchemy_ClearEditFocus()
    end
    return true
  elseif true == isUsedMemoOpen() then
    if FGlobal_Memo_CheckUiEdit(uiEdit) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_Memo:Save()
    end
    return true
  end
  if isNewCharacterInfo() == false then
    if FGlobal_CheckMyIntroduceUiEdit(uiEdit) then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        FGlobal_MyIntroduceClearFocusEdit()
      end
      return true
    end
  elseif isNewCharacterInfo() == true and FGlobal_UI_CharacterInfo_Basic_Global_CheckIntroduceUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      UI.ClearFocusEdit()
    end
    return true
  end
  return false
end
local function _keyBinder_Mail()
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    MailSend_PressedDown()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
    MailSend_PressedUp()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    MailSend_Close()
  end
end
local function _keyBinder_UiModeNotInput()
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if false == GlobalSwitch_UseOldAlchemy then
      FGlobal_Alchemy_Close()
    else
      Alchemy_Close()
    end
  end
end
local fastPinDelta = 0
local function _keyBinder_UIMode_CommonWindow(deltaTime)
  if true == FGlobal_GetFirstTutorialState() then
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_MentalKnowledge) then
    if GlobalValue_MiniGame_Value_HorseDrop == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
      return
    end
    Panel_Knowledge_Show()
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_PositionNotify) then
    local isGuild = false == isKeyPressed(VCK.KeyCode_SHIFT)
    local targetPosition = crossHair_GetTargetPosition()
    if true == ToClient_IsViewSelfPlayer(targetPosition) then
      if fastPinDelta < 0.5 then
        ToClient_RequestSendPositionGuide(isGuild, true, false, targetPosition)
        fastPinDelta = 10
      else
        ToClient_RequestSendPositionGuide(isGuild, false, false, targetPosition)
        fastPinDelta = 0
      end
    end
  end
  fastPinDelta = fastPinDelta + deltaTime
  if fastPinDelta > 10 then
    fastPinDelta = 10
  end
  if isKeyPressed(VCK.KeyCode_SHIFT) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_OEM_7) then
    if FGlobal_ChatInput_CheckReply() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_ChattingInputMode)
      ChatInput_Show()
      ChatInput_CheckInstantCommand()
      FGlobal_ChatInput_Reply(true)
      ChatInput_ChangeChatType_Immediately(4)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTINGINPUT_NONEREPLYTARGET"))
    end
    return
  end
  if Panel_Interaction:IsShow() then
    local buttonCount = FGlobal_InteractionButtonCount()
    if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
      local camBlur = getCameraBlur()
      local interactableActor = interaction_getInteractable()
      if interactableActor ~= nil and (not interactableActor:get():isPlayer() or interactableActor:get():isSelfPlayer()) and camBlur <= 0 then
        local interactionType = interactableActor:getSettedFirstInteractionType()
        if InteractionCheck(interactionType) then
          return
        end
        Interaction_ButtonPushed(interactionType)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        return
      elseif interactableActor ~= nil and interactableActor:get():isPlayer() and camBlur <= 0 then
        local interactionType = interactableActor:getSettedFirstInteractionType()
        if InteractionCheck(interactionType) then
          return
        end
        Interaction_ButtonPushed(interactionType)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_1) then
      if buttonCount >= 2 then
        FGlobal_InteractionButtonActionRun(1)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        setUiInputProcessed(VCK.KeyCode_F5)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_2) then
      if buttonCount >= 3 then
        FGlobal_InteractionButtonActionRun(2)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        setUiInputProcessed(VCK.KeyCode_F6)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_3) then
      if buttonCount >= 4 then
        FGlobal_InteractionButtonActionRun(3)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        setUiInputProcessed(VCK.KeyCode_F7)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_4) then
      if buttonCount >= 5 then
        FGlobal_InteractionButtonActionRun(4)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        setUiInputProcessed(VCK.KeyCode_F8)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_5) then
      if buttonCount >= 6 then
        FGlobal_InteractionButtonActionRun(5)
        DragManager:clearInfo()
        GlobalKeyBinder_Clear()
        setUiInputProcessed(VCK.KeyCode_F9)
        return
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F10) and buttonCount >= 7 then
      FGlobal_InteractionButtonActionRun(6)
      DragManager:clearInfo()
      GlobalKeyBinder_Clear()
      setUiInputProcessed(VCK.KeyCode_F10)
      return
    end
  end
  if (getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_Commercial or isGameTypeTaiwan()) and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_CashShop) then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    InGameShop_Open()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local playerLevel = selfPlayer:get():getLevel()
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_BlackSpirit) and false == Panel_Window_Exchange:GetShow() then
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    if true == PaGlobal_TutorialManager:isDoingTutorial() and false == PaGlobal_TutorialManager:isAllowCallBlackSpirit() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    FGlobal_TentTooltipHide()
    ToClient_AddBlackSpiritFlush()
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Chat) then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_ChattingInputMode)
    ChatInput_Show()
    return
  end
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) and Panel_Looting:IsShow() then
    Panel_Looting_buttonLootAll_Mouse_Click(false)
    Panel_Tooltip_Item_hideTooltip()
    QuestInfoData.questDescHideWindow()
  end
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if selfPlayerIsFreeCamStateInCompetitionArea() then
      selfPlayerCloseFreecam()
      return
    end
    if ToClient_WorldMapIsShow() then
      FGlobal_WorldMapWindowEscape()
      return
    end
    if Panel_EventNotify:GetShow() then
      FGlobal_NpcNavi_Hide()
      EventNotify_Close()
      return
    end
    if Panel_Window_DailyStamp:GetShow() then
      DailStamp_Hide()
      Panel_Tooltip_Item_hideTooltip()
      TooltipSimple_Hide()
      return
    end
    if Panel_Window_ArshaTeamNameChange:GetShow() then
      FGlobal_TeamNameChangeControl_Close()
      return
    end
    if Panel_Window_ArshaInviteList:GetShow() then
      FGlobal_ArshaPvP_InviteList_Close()
      return
    end
    if Panel_Window_Arsha:GetShow() then
      FGlobal_ArshaPvP_Close()
      return
    end
    if Panel_WatchingMode:GetShow() then
      return
    end
    if Panel_ScreenShotAlbum_FullScreen:GetShow() then
      ScreenshotAlbum_FullScreen_Close()
      return
    end
    if Panel_ScreenShotAlbum:GetShow() then
      ScreenshotAlbum_Close()
      return
    end
    if Panel_Window_BlackSpiritAdventure:GetShow() and not Panel_Window_BlackSpiritAdventure:IsUISubApp() then
      BlackSpiritAd_Hide()
      return
    end
    if Panel_Window_BlackSpiritAdventure_2:GetShow() then
      BlackSpirit2_Hide()
      return
    end
    if Panel_Window_BlackSpiritAdventureVerPC:GetShow() and not Panel_Window_BlackSpiritAdventure:IsUISubApp() then
      Panel_Window_BlackSpiritAdventureVerPC:SetShow(false, false)
      return
    end
    if Panel_Window_ClothInventory:GetShow() then
      ClothInventory_Close()
      return
    end
    if Panel_Window_Mercenary:GetShow() then
      FGlobal_MercenaryClose()
      return
    end
    if Panel_Window_MasterpieceAuction:GetShow() and FGlobal_MasterPieceAuction_IsOpenEscMenu() then
      PaGlobal_MasterpieceAuction:close()
      return
    end
    if Panel_MovieGuide_Web:GetShow() then
      if Panel_MovieGuide_Weblist:GetShow() then
        PaGlobal_MovieGuide_Weblist:Close()
        return
      else
        PaGlobal_MovieGuide_Web:Close()
        return
      end
    end
    if Panel_MovieGuide_Weblist:GetShow() then
      PaGlobal_MovieGuide_Weblist:Close()
      return
    end
    if Panel_MovieSkillGuide_Web:GetShow() then
      if Panel_MovieSkillGuide_Weblist:GetShow() then
        PaGlobal_MovieSkillGuide_Weblist:Close()
        return
      else
        PaGlobal_MovieSkillGuide_Web:Close()
        return
      end
    end
    if Panel_MovieSkillGuide_Weblist:GetShow() then
      PaGlobal_MovieSkillGuide_Weblist:Close()
      return
    end
    if Panel_SaveSetting:IsShow() then
      PaGlobal_Panel_SaveSetting_Hide()
      return
    end
    if Panel_HarvestList:GetShow() then
      HarvestList_Close()
      return
    end
    if Panel_PartyRecruite:GetShow() then
      PartyListRecruite_Close()
      return
    end
    if Panel_ServantResurrection:GetShow() then
      Panel_ServantResurrection_Close()
      return
    end
    if Panel_Window_Camp:GetShow() then
      if Panel_Window_NpcShop:GetShow() then
        NpcShop_WindowClose()
      else
        PaGlobal_Camp:close()
      end
      return
    end
    if Panel_Window_CampRegister:GetShow() then
      FGlobal_CampRegister_Close()
      return
    end
    if Panel_Window_MonsterRanking:GetShow() then
      FGlobal_MonsterRanking_Close()
      return
    end
    if Panel_ChatOption:GetShow() then
      ChattingOption_Close()
      return
    end
    if Panel_Window_BuildingBuff:GetShow() then
      PaGlobal_BuildingBuff:close()
      return
    end
    if true == isUsedMemoOpen() and Panel_Memo_List:GetShow() then
      PaGlobal_Memo:ListClose()
      return
    end
    if check_ShowWindow() then
      close_WindowPanelList()
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      FGlobal_NpcNavi_Hide()
      return
    end
    if check_ShowWindow() and FGlobal_NpcNavi_IsShowCheck() then
      close_WindowPanelList()
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      FGlobal_NpcNavi_Hide()
      return
    elseif not check_ShowWindow() and FGlobal_NpcNavi_IsShowCheck() then
      FGlobal_NpcNavi_Hide()
      return
    elseif check_ShowWindow() and not FGlobal_NpcNavi_IsShowCheck() then
      close_WindowPanelList()
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      return
    elseif IM.eProcessorInputMode_UiMode == getInputMode() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      if Panel_Menu_ShowToggle() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      end
      return
    else
      if Panel_Menu_ShowToggle() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      else
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
      return
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Help) then
    if nil ~= Panel_KeyboardHelp then
      if FGlobal_KeyboardHelpShow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      elseif false == check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ProductionNote) then
    if nil ~= Panel_ProductNote and not Panel_ProductNote:IsUISubApp() then
      if Panel_ProductNote_ShowToggle() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      elseif false == check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_PlayerInfo) then
    if Panel_Window_CharInfo_Status ~= nil then
      if Panel_Window_CharInfo_Status:GetShow() and not Panel_Window_CharInfo_Status:IsUISubApp() then
        audioPostEvent_SystemUi(1, 31)
        if isNewCharacterInfo() == false then
          CharacterInfoWindow_Hide()
        else
          PaGlobal_CharacterInfo:hideWindow()
        end
        if false == check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      else
        if Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow() then
          ServantInfo_Close()
          CarriageInfo_Close()
          ShipInfo_Close()
          Panel_Tooltip_Item_hideTooltip()
          TooltipSimple_Hide()
          return
        end
        audioPostEvent_SystemUi(1, 30)
        if isNewCharacterInfo() == false then
          CharacterInfoWindow_Show()
        else
          PaGlobal_CharacterInfo:showWindow(0)
        end
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      end
    end
    local selfProxy = selfPlayer:get()
    if nil ~= selfProxy then
      local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
      local temporaryWrapper = getTemporaryInformationWrapper()
      local unsealCacheData = getServantInfoFromActorKey(actorKeyRaw)
      if nil ~= unsealCacheData then
        local inventory = unsealCacheData:getInventory()
        local invenSize = inventory:size()
        if 0 ~= actorKeyRaw then
          if Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow() then
            ServantInfo_Close()
            CarriageInfo_Close()
            ShipInfo_Close()
            Panel_Tooltip_Item_hideTooltip()
            TooltipSimple_Hide()
            if false == check_ShowWindow() then
              UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
            end
          else
            requestInformationFromServant()
            ServantInfo_BeforOpenByActorKeyRaw(actorKeyRaw)
            UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
          end
        end
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Skill) then
    if nil ~= Panel_Window_Skill then
      if Panel_Window_Skill:IsShow() then
        audioPostEvent_SystemUi(1, 17)
        HandleMLUp_SkillWindow_Close()
        if false == check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      else
        audioPostEvent_SystemUi(1, 18)
        PaGlobal_Skill:SkillWindow_Show()
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ChatTabNext) then
    moveChatTab(true)
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ChatTabPrev) then
    moveChatTab(false)
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UIInputType_PossessionByBlackSpirit) then
    if PaGlobal_AutoManager._ActiveState then
      FGlobal_MouseclickTest()
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Inventory) then
    local isInvenOpen = Panel_Window_Inventory:IsShow()
    local isEquipOpen = Panel_Equipment:IsShow()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local servantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    local servantShipInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if isInvenOpen == false and isEquipOpen == false then
      if isEquipOpen == false then
        Equipment_SetShow(true)
      end
      audioPostEvent_SystemUi(1, 16)
      InventoryWindow_Show(true)
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      if Panel_Window_ServantInventory:GetShow() then
        TooltipSimple_Hide()
        Panel_Tooltip_Item_hideTooltip()
      end
    else
      if Panel_Window_Exchange:GetShow() then
        Panel_ExchangePC_BtnClose_Mouse_Click()
        return
      end
      if Panel_Window_Inventory:IsUISubApp() and isEquipOpen == false then
        Equipment_SetShow(true)
      else
        Equipment_SetShow(false)
      end
      audioPostEvent_SystemUi(1, 15)
      InventoryWindow_Close()
      ServantInventory_Close()
      TooltipSimple_Hide()
      if false == check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Dyeing) then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    if MiniGame_Manual_Value_FishingStart == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
      return
    elseif not Panel_Dye_ReNew:GetShow() then
      audioPostEvent_SystemUi(1, 24)
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      FGlobal_Panel_Dye_ReNew_Open()
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Present) then
    if not Panel_Window_CharInfo_Status:GetShow() then
      audioPostEvent_SystemUi(1, 34)
      if isNewCharacterInfo() == false then
        FGlobal_Challenge_Show()
      else
        PaGlobal_CharacterInfo:showWindow(3)
        FGlobal_TapButton_Complete()
      end
    else
      audioPostEvent_SystemUi(1, 31)
      if isNewCharacterInfo() == false then
        FGlobal_Challenge_Hide()
      else
        PaGlobal_CharacterInfo:hideWindow()
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Manufacture) then
    if MiniGame_Manual_Value_FishingStart == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
      return
    elseif 0 ~= ToClient_GetMyTeamNoLocalWar() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
      return
    elseif true == PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    else
      if not IsSelfPlayerWaitAction() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
        return
      end
      if Panel_Manufacture ~= nil and Panel_Window_Inventory ~= nil then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        local isInvenOpen = Panel_Window_Inventory:GetShow()
        local isManufactureOpen = Panel_Manufacture:GetShow()
        if isManufactureOpen == false or isInvenOpen == false then
          audioPostEvent_SystemUi(1, 26)
          Manufacture_Show(nil, CppEnums.ItemWhereType.eInventory, true)
        else
          audioPostEvent_SystemUi(1, 25)
          Manufacture_Close()
          if false == check_ShowWindow() then
            UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
          end
        end
      end
      return
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Guild) then
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil ~= guildWrapper then
      local guildGrade = guildWrapper:getGuildGrade()
      if 0 == guildGrade then
        if false == Panel_ClanList:IsShow() then
          audioPostEvent_SystemUi(1, 36)
          FGlobal_ClanList_Open()
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        else
          audioPostEvent_SystemUi(1, 31)
          FGlobal_ClanList_Close()
          if false == check_ShowWindow() then
            UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
          end
        end
      elseif false == Panel_Window_Guild:IsShow() then
        audioPostEvent_SystemUi(1, 36)
        GuildManager:Show()
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      else
        audioPostEvent_SystemUi(1, 31)
        GuildManager:Hide()
        if false == check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Mail) then
    if Panel_Mail_Main ~= nil and Panel_Mail_Detail ~= nil then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      local isMailMain = Panel_Mail_Main:IsShow()
      if isMailMain == false then
        audioPostEvent_SystemUi(1, 22)
        Mail_Open()
      else
        audioPostEvent_SystemUi(1, 21)
        Mail_Close()
        if false == check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_FriendList) then
    if Panel_FriendList ~= nil then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      local isFriendList = Panel_FriendList:IsShow()
      if isFriendList == false then
        FriendList_show()
        audioPostEvent_SystemUi(1, 28)
      else
        FriendList_hide()
        audioPostEvent_SystemUi(1, 27)
        if false == check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_QuestHistory) then
    if Panel_Window_Quest_New:GetShow() then
      audioPostEvent_SystemUi(1, 27)
      Panel_Window_QuestNew_Show(false)
      if false == check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    else
      audioPostEvent_SystemUi(1, 29)
      Panel_Window_QuestNew_Show(true)
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    end
    TooltipSimple_Hide()
    return
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_C) then
    if not isPvpEnable() then
      return
    else
      requestTogglePvP()
      return
    end
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_B) then
    requestBlackSpritSkill()
    return
  end
  if getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_Commercial and not isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_BeautyShop) then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    if not getCustomizingManager():isShow() then
      IngameCustomize_Show()
      return
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_WorldMap) then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    if not Panel_Global_Manual:GetShow() or FGlobal_BulletCount_UiShowCheck() then
      FGlobal_PushOpenWorldMap()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_MINIGAMING_NOT_WORLDMAP"))
      return
    end
  end
  if Panel_Window_ItemMarket:GetShow() and FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
    FGlobal_HandleClicked_ItemMarketBackPage()
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_House) then
    if Panel_HousingList:GetShow() then
      HousingList_Close()
    else
      FGlobal_HousingList_Open()
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Worker) then
    FGlobal_WorkerManger_ShowToggle()
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Pet) then
    FGlobal_PetListNew_Toggle()
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Maid) then
    if Panel_Window_MaidList:GetShow() then
      MaidList_Close()
    else
      MaidList_Open()
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Servant) then
    Servant_Call(0)
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_GuildServant) then
    FGlobal_GuildServantList_Open()
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_DeleteNavigation) then
    if getSelfPlayer():get():getLevel() < 11 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TUTORIAL_PROGRSS_ACK"))
      return
    end
    ToClient_DeleteNaviGuideByGroup(0)
    Panel_NaviButton:SetShow(false)
    audioPostEvent_SystemUi(0, 15)
  end
end
local function _keyBinder_UIMode_NpcDialog(deltaTime)
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
    if Panel_Window_NpcShop:GetShow() then
      return
    end
    local _uiNextButton = UI.getChildControl(Panel_Npc_Dialog, "Button_Next")
    if Panel_DetectPlayer:GetShow() then
      return
    end
    if Panel_CreateGuild:GetShow() then
      return
    end
    if Panel_GuildHouse_Auction:GetShow() then
      return
    end
    if _uiNextButton:GetShow() then
      HandleClickedDialogNextButton()
      audioPostEvent_SystemUi(0, 0)
    elseif isShowReContactDialog() then
      HandleClickedDialogButton(0)
      audioPostEvent_SystemUi(0, 0)
    elseif isShowDialogFunctionQuest() then
      HandleClickedFuncButton(0)
      audioPostEvent_SystemUi(0, 0)
      return
    elseif -1 < questDialogIndex() then
      HandleClickedDialogButton(questDialogIndex())
      audioPostEvent_SystemUi(0, 0)
    elseif -1 < exchangalbeButtonIndex() then
      HandleClickedDialogButton(exchangalbeButtonIndex())
      audioPostEvent_SystemUi(0, 0)
    end
    return
  end
  if FGlobal_CehckedGuildEditUI(GetFocusEdit()) then
    if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      handleClicked_GuildCreateCancel()
    end
    return
  end
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_MasterpieceAuction:GetShow() then
      PaGlobal_MasterpieceAuction:close()
      return
    end
    if Panel_EnchantExtraction:GetShow() then
      Panel_EnchantExtraction_Close()
      return
    end
    if Panel_Window_ServantInventory:GetShow() and Panel_Window_Warehouse:GetShow() then
      ServantInventory_Close()
      return
    end
    if Panel_Window_Enchant:GetShow() then
      PaGlobal_Enchant:enchantClose()
      return
    end
    if check_ShowWindow() then
      close_WindowPanelList()
      if Panel_Npc_Quest_Reward:GetShow() then
        FGlobal_HideDialog()
      end
    else
      FGlobal_HideDialog()
    end
    ServantInfo_Close()
    CarriageInfo_Close()
    ServantInventory_Close()
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Inventory) and getAuctionState() then
    local isInvenOpen = Panel_Window_Inventory:IsShow()
    if isInvenOpen == false then
      InventoryWindow_Show()
      Inventory_SetFunctor(nil, nil, nil, nil)
      return
    end
    if Panel_Window_Inventory ~= nil then
      InventoryWindow_Close()
      return
    end
  end
  if Panel_Dialog_Search:GetShow() then
    if isKeyPressed(VCK.KeyCode_A) then
      searchView_PushLeft()
    elseif isKeyPressed(VCK.KeyCode_S) then
      searchView_PushBottom()
    elseif isKeyPressed(VCK.KeyCode_D) then
      searchView_PushRight()
    elseif isKeyPressed(VCK.KeyCode_W) then
      searchView_PushTop()
    elseif isKeyPressed(VCK.KeyCode_Q) then
      searchView_ZoomIn()
    elseif isKeyPressed(VCK.KeyCode_E) then
      searchView_ZoomOut()
    end
  end
  if Panel_Window_ItemMarket_RegistItem:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    FGlobal_ItemMarketRegistItem_RegistDO()
  end
end
local function _keyBinder_UIMode_WorldMap(deltaTime)
  if FGlobal_IsFadeOutState() then
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_Quest_New:GetShow() and Panel_Window_Quest_New:IsUISubApp() == false then
      Panel_Window_QuestNew_Show(false)
      return
    end
    if Panel_ItemMarket_BidDesc:GetShow() then
      Panel_ItemMarket_BidDesc_Hide()
      return
    end
    if Panel_Window_ItemMarket:GetShow() and Panel_Window_ItemMarket:IsUISubApp() == false then
      FGolbal_ItemMarketNew_Close()
      return
    end
    if Panel_Window_ItemMarket_ItemSet:GetShow() then
      FGlobal_ItemMarketItemSet_Close()
      return
    end
    if isWorldMapGrandOpen() and Panel_WorldMap_MovieGuide:GetShow() then
      Panel_Worldmap_MovieGuide_Close()
      return
    end
    FGlobal_WorldMapWindowEscape()
  elseif FGlobal_AskCloseWorldMap() then
    FGlobal_PopCloseWorldMap()
  elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Chat) then
    if not Panel_Window_ItemMarket:GetShow() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_ChattingInputMode)
      ChatInput_Show()
      return
    else
      return
    end
  elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_WorldMap) then
    FGlobal_CloseWorldmapForLuaKeyHandling()
    return
  end
  if FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
    FGlobal_HandleClicked_ItemMarketBackPage()
  end
  if (isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_CBT and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ProductionNote) then
    if nil ~= Panel_ProductNote then
      Panel_ProductNote_ShowToggle()
    end
    return
  end
  if isKeyPressed(VCK.KeyCode_CONTROL) then
    ToClient_showWorldmapKeyGuide(true)
  elseif isKeyPressed(VCK.KeyCode_SHIFT) then
    ToClient_showWorldmapKeyGuide(true)
  elseif isKeyPressed(VCK.KeyCode_MENU) then
    ToClient_showWorldmapKeyGuide(true)
  else
    ToClient_showWorldmapKeyGuide(false)
  end
end
local function _keyBinder_WorldMapSearch(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ClearFocusEdit()
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    if ToClient_WorldMapIsShow() then
      SetUIMode(Defines.UIMode.eUIMode_WorldMap)
    else
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  end
end
local function _keyBinder_UIMode_Housing(deltaTime)
  if Panel_House_InstallationMode_VillageTent:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    VillageTent_Close()
    return
  elseif Panel_Housing_FarmInfo_New:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PAHousing_FarmInfo_Close()
    return
  elseif Panel_House_InstallationMode_ObjectControl:GetShow() and housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_HouseInstallationControl_Move()
    return
  elseif Panel_House_InstallationMode_ObjectControl:GetShow() and not housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_HouseInstallationControl_Close()
    return
  elseif Panel_House_InstallationMode_ObjectControl:GetShow() and not housing_isBuildMode() and true == FGlobal_HouseInstallationControl_IsConfirmStep() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    FGlobal_HouseInstallationControl_Confirm()
    return
  elseif not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Housing_CancelModeFromKeyBinder()
    return
  end
end
local function _keyBinder_UIMode_Mental(deltaTime)
  if not escHandle and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_MentalKnowledge)) then
    Panel_Knowledge_Hide()
    if UI.isGameOptionMouseMode() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
    end
  end
end
local function _keyBinder_UIMode_MentalGame(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    MentalGame_Hide()
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  end
end
local function _keyBinder_UIMode_InGameDance(deltaTime)
  if getGameDanceEditor():isShow() == true and not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Dance_Close()
  end
end
local function _keyBinder_UIMode_InGameCustomize(deltaTime)
  if Panel_CustomizationMain:IsShow() and Panel_CustomizationMain:GetAlpha() == 1 and not escHandle and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
    if Panel_CustomizingAlbum:GetShow() then
      CustomizingAlbum_Close()
    else
      IngameCustomize_Hide()
    end
  end
  if Panel_CustomizationStatic:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) and not Panel_FileExplorer:GetShow() and not Panel_CustomizingAlbum:GetShow() then
    FGlobal_TakeScreenShotByHotKey()
  end
  if Panel_Widget_ScreenShotFrame:GetShow() then
    if not escHandle and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
      local screenShotFrame_Close = function()
        FGlobal_ScreenShotFrame_Close()
      end
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
        content = messageBoxMemo,
        functionYes = screenShotFrame_Close,
        functionNo = MessageBox_Empty_function,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ADD) then
      ScreenShotFrameSize_Increase()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SUBTRACT) then
      ScreenShotFrameSize_Decrease()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      FGlobal_TakeAScreenShot()
    end
  end
end
local prevPressControl
local function _keyBinder_UIMode_InGameCashShop(delataTime)
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_CashShop) then
    InGameShop_Close()
    Panel_Tooltip_Item_hideTooltip()
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_Inventory:IsShow() and not Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Inventory:SetShow(false)
    elseif Panel_IngameCashShop_BuyOrGift:GetShow() then
      InGameShopBuy_Close()
    elseif Panel_IngameCashShop_GoodsDetailInfo:GetShow() then
      InGameShopDetailInfo_Close()
      Panel_Tooltip_Item_hideTooltip()
    elseif Panel_QnAWebLink:GetShow() then
      FGlobal_QnAWebLink_Close()
    elseif Panel_IngameCashShop_MakePaymentsFromCart:GetShow() then
      FGlobal_IngameCashShop_MakePaymentsFromCart_Close()
    elseif Panel_IngameCashShop_HowUsePearlShop:GetShow() then
      Panel_IngameCashShop_HowUsePearlShop_Close()
    elseif Panel_IngameCashShop_Coupon:GetShow() then
      IngameCashShopCoupon_Close()
    elseif getGameDanceEditor():isShow() then
      getGameDanceEditor():hide()
    else
      InGameShop_Close()
    end
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and FGlobal_InGameShop_IsSelectedSearchName() then
    InGameShop_Search()
  end
  if FGlobal_InGameShop_IsSelectedSearchName() then
    local pressControl = getPressControl()
    if nil == pressControl then
      pressControl = prevPressControl
    end
    local searchEdit = FGlobal_InGameCashShop_GetSearchEdit()
    prevPressControl = pressControl
    if nil == pressControl or pressControl:GetKey() ~= searchEdit:GetKey() then
      ClearFocusEdit()
    else
      return
    end
  end
  if not Panel_IngameCashShop_BuyOrGift:GetShow() and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Inventory) then
    if Panel_Window_Inventory:IsShow() then
      InventoryWindow_Close()
    else
      FGlobal_InGameShop_OpenInventory()
    end
  end
end
local function _keyBinder_UIMode_Dye(delataTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Dyeing) then
    audioPostEvent_SystemUi(1, 23)
    FGlobal_Panel_DyeReNew_Hide()
    if false == check_ShowWindow() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
    end
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local function _keyBinder_UIMode_ItemMarket(delataTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_ItemMarket_ItemSet:GetShow() then
      FGlobal_ItemMarketItemSet_Close()
    elseif Panel_Window_ItemMarket_RegistItem:GetShow() then
      FGlobal_ItemMarketRegistItem_Close()
    elseif Panel_ItemMarket_PreBid_Manager:GetShow() then
      FGlobal_ItemMarketPreBid_Manager_Close()
    elseif Panel_ItemMarket_PreBid:GetShow() then
      FGlobal_ItemMarketPreBid_Close()
    elseif Panel_ItemMarket_AlarmList:GetShow() then
      FGlobal_ItemMarketAlarmList_Close()
    elseif Panel_ItemMarket_BidDesc:GetShow() then
      Panel_ItemMarket_BidDesc_Hide()
    elseif Panel_Window_ItemMarket:GetShow() and not Panel_Window_ItemMarket:IsUISubApp() then
      if Panel_Window_ItemMarket_BuyConfirm:GetShow() then
        FGlobal_ItemMarket_BuyConfirm_Close()
      else
        FGolbal_ItemMarketNew_Close()
        InventoryWindow_Close()
        Equipment_SetShow(false)
      end
    else
      FGolbal_ItemMarket_Function_Close()
    end
    if ToClient_CheckExistSummonMaid() and Panel_Window_ItemMarket:GetShow() == false then
      ToClient_CallHandlerMaid("_maidLogOut")
    end
  end
  if FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
    FGlobal_HandleClicked_ItemMarketBackPage()
  end
  if Panel_Window_ItemMarket_BuyConfirm:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    HandleClicked_ItemMarket_BuyItem()
  end
  if Panel_Window_ItemMarket:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    FGolbal_ItemMarketNew_Search()
  end
  if Panel_ItemMarket_PreBid:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    if 0 == FGlobal_ItemMarketPreBid_Check_OpenType() then
      FGlobal_ItemMarketPreBid_Confirm()
    else
      FGlobal_ItemMarketPreBid_Close()
    end
  end
  if Panel_Window_ItemMarket_RegistItem:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    FGlobal_ItemMarketRegistItem_RegistDO()
  end
  if getInputMode() ~= IM.eProcessorInputMode_ChattingInputMode and Panel_Window_ItemMarket:GetShow() and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Inventory) then
    if Panel_Window_Inventory:IsShow() then
      InventoryWindow_Close()
      Equipment_SetShow(false)
    else
      FGlobal_ItemmarketNew_OpenInventory()
      Equipment_SetShow(true)
    end
  end
end
local function _keyBinder_UIMode_Trade(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    closeNpcTrade_Basket()
    TooltipSimple_Hide()
  end
end
local function _keyBinder_UIMode_Stable(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if CppEnums.ServantType.Type_Vehicle == stable_getServantType() and -1 == FGlobal_IsButtonClick() then
      if Panel_Window_StableMarket:GetShow() then
        StableMarket_Close()
      elseif Panel_Window_StableMating:GetShow() then
        StableMating_Close()
      elseif Panel_Window_StableMix:GetShow() then
        StableMix_Close()
      elseif Panel_Window_StableStallion:GetShow() then
        StableStallion_Close()
      elseif Panel_AddToCarriage:GetShow() then
        stableCarriage_Close()
      elseif Panel_Window_Inventory:GetShow() and not Panel_Window_Inventory:IsUISubApp() then
        InventoryWindow_Close()
      else
        StableFunction_Close()
        GuildStableFunction_Close()
      end
    elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
      WharfFunction_Close()
      GuildWharfFunction_Close()
    end
  end
end
local function _keyBinder_UIMode_GameExit(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if true == Panel_Window_DeliveryForGameExit:GetShow() then
      FGlobal_DeliveryForGameExit_Show(false)
      return
    elseif true == Panel_Event_100Day:GetShow() then
      FGlobal_Event_100Day_Close()
    elseif true == Panel_ChannelSelect:GetShow() then
      FGlobal_ChannelSelect_Hide()
    else
      GameExitShowToggle(false)
    end
  end
end
local function _keyBinder_UIMode_DeadMessage(deltaTime)
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Chat) then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_ChattingInputMode)
    ChatInput_Show()
    return
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_TAB) then
    ChatInput_ChangeInputFocus()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
    if ToClient_isComposition() then
      return
    end
    ChatInput_PressedUp()
  elseif isKeyPressed(VCK.KeyCode_MENU) then
    ChatInput_CheckReservedKey()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    ChatInput_CheckInstantCommand()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Chatting_Input:GetShow() then
      if ToClient_isComposition() then
        return
      end
      ChatInput_CancelAction()
      ChatInput_CancelMessage()
      ChatInput_Close()
      friend_clickAddFriendClose()
      if check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      end
    end
    return
  end
end
local function _keyBinder_UIMode_MiniGame(deltaTime)
  local MiniGame_BattleGauge_Space = Panel_BattleGauge:IsShow()
  local MiniGame_FillGauge_Mouse = Panel_FillGauge:IsShow()
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    close_WindowPanelList()
    if Panel_Window_DailyStamp:GetShow() then
      DailStamp_Hide()
      return
    end
  end
  if MiniGame_FillGauge_Mouse then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LBUTTON) then
      FillGauge_UpdateGauge(deltaTime, true)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RBUTTON) then
      FillGauge_UpdateGauge(deltaTime, false)
    end
  end
end
local _keyBinder_UIMode_PreventMoveNSkill = function(deltaTime)
end
local function _keyBinder_UIMode_Movie(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if check_ShowWindow() then
      close_WindowPanelList()
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      return
    elseif Panel_UIControl:IsShow() then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      Panel_UIControl_SetShow(false)
      Panel_Menu_ShowToggle()
      return
    else
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiControlMode)
      Panel_UIControl_SetShow(true)
      Panel_Menu_ShowToggle()
      return
    end
  end
end
local function _keyBinder_UIMode_Repair(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_FixEquip:GetShow() then
      PaGlobal_FixEquip:fixEquipExit()
    else
      PaGlobal_Repair:RepairExit()
    end
  end
end
local function _keyBinder_UIMode_Extraction(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_Extraction_Cloth:GetShow() then
      ExtractionCloth_WindowClose()
      InventoryWindow_Close()
      EquipmentWindow_Close()
    elseif Panel_Window_Extraction_Crystal:GetShow() then
      Socket_ExtractionCrystal_WindowClose()
      InventoryWindow_Close()
      EquipmentWindow_Close()
    elseif Panel_Window_Extraction_EnchantStone:GetShow() then
      ExtractionEnchantStone_WindowClose()
      InventoryWindow_Close()
      EquipmentWindow_Close()
    else
      PaGlobal_Extraction:openPanel(false)
    end
  end
end
local _keyBinder_UIMode_KeyCustom_ActionKey = function(deltaTime)
  local isEnd = false
  local inputType = KeyCustom_Action_GetInputType()
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionKey(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionKey(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Action_UpdateButtonText_Key()
    KeyCustom_Action_KeyButtonCheckReset(inputType)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local _keyBinder_UIMode_KeyCustom_ActionPad = function(deltaTime)
  local isEnd = false
  local inputType = KeyCustom_Action_GetInputType()
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPad(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPad(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_PadButtonCheckReset(inputType)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local _keyBinder_UIMode_KeyCustom_UiKey = function(deltaTime)
  local isEnd = false
  local inputType = KeyCustom_Ui_GetInputType()
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_UiKey(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_UiKey(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Ui_UpdateButtonText_Key()
    KeyCustom_Ui_KeyButtonCheckReset(inputType)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local _keyBinder_UIMode_KeyCustom_UiPad = function(deltaTime)
  local isEnd = false
  local inputType = KeyCustom_Ui_GetInputType()
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_UiPad(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_UiPad(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Ui_UpdateButtonText_Pad()
    KeyCustom_Ui_PadButtonCheckReset(inputType)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local _keyBinder_UIMode_KeyCustom_ActionPadFunc1 = function(deltaTime)
  local isEnd = false
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPadFunc1(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPadFunc1(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(0)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local _keyBinder_UIMode_KeyCustom_ActionPadFunc2 = function(deltaTime)
  local isEnd = false
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPadFunc2(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPadFunc2(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(1)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
local function _keyBinder_UIMode_PopupItem()
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_UseItem_ShowToggle_Func()
  end
end
local function _keyBinder_UIMode_ProductNote(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_ProductNote_ShowToggle()
  end
end
local function _keyBinder_UIMode_QnAWebLink(deltaTime)
  if not escHandle and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == Panel_QnAWebLink_ShowToggle() then
    if AllowChangeInputMode() then
      if check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      else
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    else
      SetFocusChatting()
    end
  end
end
local _KeyBinder_UIMode_TradeGame = function(deltaTime)
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    Fglobal_TradeGame_Close()
    return
  end
  global_Update_TradeGame(deltaTime)
end
local function _KeyBinder_UIMode_CutSceneMode(deltaTime)
  if ToClient_cutsceneIsPlay() then
    if not MessageBox.isPopUp() and isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) and false == isRunClosePopup then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "CUTSCENE_EXIT_MESSAGEBOX_MEMO")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
        content = messageBoxMemo,
        functionYes = ToClient_CutsceneStop,
        functionNo = MessageBox_Empty_function,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    Panel_MovieTheater_LowLevel_WindowClose()
    return
  end
end
local function _KeyBinder_UIMode_UiSetting(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_UiSet_Close()
    return
  end
end
local function _KeyBinder_UIMode_Gacha_Roulette(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    FGlobal_gacha_Roulette_OnPressSpace()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_gacha_Roulette_OnPressEscape()
  end
  return
end
local function _KeyBinder_UIMode_ScreenShotMode(delataTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    local screenShotFrame_Close = function()
      FGlobal_ScreenShotFrame_Close()
    end
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
      content = messageBoxMemo,
      functionYes = screenShotFrame_Close,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    setUiInputProcessed(VCK.KeyCode_SPACE)
    FGlobal_TakeAScreenShot()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ADD) then
    ScreenShotFrameSize_Increase()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SUBTRACT) then
    ScreenShotFrameSize_Decrease()
  end
  return
end
local function _KeyBinder_UIMode_EventNotify(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    EventNotifyContent_Close()
    if AllowChangeInputMode() then
      if check_ShowWindow() then
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      else
        UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
      end
    else
      SetFocusChatting()
    end
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function SetUIMode(uiMode)
  if uiMode >= 0 and uiMode < UIMode.eUIMode_Count then
    _uiMode = uiMode
  end
end
function GetUIMode()
  return _uiMode
end
function IsBubbleAndInterActionShowCondition()
  return _uiMode == UIMode.eUIMode_Default
end
function IsWaitCommentAndInterActionShowCondition()
  return _uiMode == UIMode.eUIMode_Default
end
function IsCharacterNameTagShowCondition()
  return _uiMode == UIMode.eUIMode_Default or _uiMode == UIMode.eUIMode_Housing
end
local function GlobalKeyBinder_MouseDragEvent()
  if DragManager:isDragging() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    DragManager:clearInfo()
    Inventory_DropEscape()
    escHandle = true
  else
    escHandle = false
  end
end
local function _ChattingMacro_Process()
  if false == isKeyPressed(VCK.KeyCode_MENU) then
    return false
  end
  if false == isKeyPressed(VCK.KeyCode_SHIFT) then
    return false
  end
  if isKeyDown_Once(VCK.KeyCode_1) and "" ~= ToClient_getMacroChatMessage(0) then
    ToClient_executeChatMacro(0)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_2) and "" ~= ToClient_getMacroChatMessage(1) then
    ToClient_executeChatMacro(1)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_3) and "" ~= ToClient_getMacroChatMessage(2) then
    ToClient_executeChatMacro(2)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_4) and "" ~= ToClient_getMacroChatMessage(3) then
    ToClient_executeChatMacro(3)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_5) and "" ~= ToClient_getMacroChatMessage(4) then
    ToClient_executeChatMacro(4)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_6) and "" ~= ToClient_getMacroChatMessage(5) then
    ToClient_executeChatMacro(5)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_7) and "" ~= ToClient_getMacroChatMessage(6) then
    ToClient_executeChatMacro(6)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_8) and "" ~= ToClient_getMacroChatMessage(7) then
    ToClient_executeChatMacro(7)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_9) and "" ~= ToClient_getMacroChatMessage(8) then
    ToClient_executeChatMacro(8)
    return true
  elseif isKeyDown_Once(VCK.KeyCode_0) and "" ~= ToClient_getMacroChatMessage(9) then
    ToClient_executeChatMacro(9)
    return true
  end
  return false
end
local _SkillkeyBinder_UIMode_CommonWindow = function(deltaTime)
  if isUseNewQuickSlot() then
    if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot1) then
      HandleClicked_NewQuickSlot_Use(0)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot2) then
      HandleClicked_NewQuickSlot_Use(1)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot3) then
      HandleClicked_NewQuickSlot_Use(2)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot4) then
      HandleClicked_NewQuickSlot_Use(3)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot5) then
      HandleClicked_NewQuickSlot_Use(4)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot6) then
      HandleClicked_NewQuickSlot_Use(5)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot7) then
      HandleClicked_NewQuickSlot_Use(6)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot8) then
      HandleClicked_NewQuickSlot_Use(7)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot9) then
      HandleClicked_NewQuickSlot_Use(8)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot10) then
      HandleClicked_NewQuickSlot_Use(9)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot11) then
      HandleClicked_NewQuickSlot_Use(10)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot12) then
      HandleClicked_NewQuickSlot_Use(11)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot13) then
      HandleClicked_NewQuickSlot_Use(12)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot14) then
      HandleClicked_NewQuickSlot_Use(13)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot15) then
      HandleClicked_NewQuickSlot_Use(14)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot16) then
      HandleClicked_NewQuickSlot_Use(15)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot17) then
      HandleClicked_NewQuickSlot_Use(16)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot18) then
      HandleClicked_NewQuickSlot_Use(17)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot19) then
      HandleClicked_NewQuickSlot_Use(18)
    elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot20) then
      HandleClicked_NewQuickSlot_Use(19)
    end
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot1) then
    QuickSlot_Click("0")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot2) then
    QuickSlot_Click("1")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot3) then
    QuickSlot_Click("2")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot4) then
    QuickSlot_Click("3")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot5) then
    QuickSlot_Click("4")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot6) then
    QuickSlot_Click("5")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot7) then
    QuickSlot_Click("6")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot8) then
    QuickSlot_Click("7")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot9) then
    QuickSlot_Click("8")
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_QuickSlot10) then
    QuickSlot_Click("9")
  end
end
function GlobalKeyBinder_Update(deltaTime)
  isRunClosePopup = false
  if isIntroMoviePlaying then
    SetUIMode(UIMode.eUIMode_Movie)
  end
  GlobalKeyBinder_MouseDragEvent()
  local inputMode = UI.Get_ProcessorInputMode()
  if MessageBox.isPopUp() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      MessageBox.keyProcessEnter()
      GlobalKeyBinder_Clear()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBox.keyProcessEscape()
      isRunClosePopup = true
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_UseItem:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      Click_Panel_UserItem_Yes()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_UseItem_ShowToggle_Func()
    end
    GlobalKeyBinder_Clear()
    return
  elseif Panel_ExitConfirm:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      Panel_GameExit_MinimizeTray()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_ExitConfirm:SetShow(false)
    end
    GlobalKeyBinder_Clear()
    return
  elseif Panel_NumberPad_IsPopUp() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) then
      Panel_NumberPad_ButtonAllSelect_Mouse_Click(0)
      setUiInputProcessed(VCK.KeyCode_F)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
      Panel_NumberPad_ButtonConfirm_Mouse_Click()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      keyCustom_KeyProcessed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_NumberPad_ButtonCancel_Mouse_Click()
    end
    Panel_NumberPad_NumberKey_Input()
    GlobalKeyBinder_Clear()
    return
  elseif Panel_Chatting_Macro:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Chatting_Macro_ShowToggle()
      FGlobal_Chatting_Macro_SetCHK(false)
      if AllowChangeInputMode() then
        if check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        else
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      else
        SetFocusChatting()
      end
      return
    end
  elseif Panel_Chat_SocialMenu:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_Chatting_Input:GetShow() then
        ChatInput_CancelAction()
        ChatInput_CancelMessage()
        ChatInput_Close()
        friend_clickAddFriendClose()
        if check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        end
      else
        FGlobal_SocialAction_SetCHK(false)
        FGlobal_SocialAction_ShowToggle()
        if not AllowChangeInputMode() then
          SetFocusChatting()
        elseif check_ShowWindow() then
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        else
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
        end
      end
      return
    end
  elseif Panel_Chat_SubMenu:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_Chatting_Block_GoldSeller:GetShow() then
        FGlobal_reportSeller_Close()
        return
      end
      Panel_Chat_SubMenu:SetShow(false)
      return
    end
  elseif Panel_GuildIncentive:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and not FGlobal_CheckSaveGuildMoneyUiEdit(GetFocusEdit()) then
      FGlobal_SaveGuildMoney_Send()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildIncentive_Close()
      return
    end
    FGlobal_GuildDeposit_InputCheck()
    GlobalKeyBinder_Clear()
    return
  elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_AlchemySton) and false == isKeyPressed(VCK.KeyCode_CONTROL) then
    if inputMode == IM.eProcessorInputMode_GameMode then
      FGlobal_AlchemyStone_Use()
      return
    elseif (inputMode == IM.eProcessorInputMode_UiMode or inputMode == IM.eProcessorInputMode_UiControlMode) and UIMode.eUIMode_Default == _uiMode then
      FGlobal_AlchemyStone_Use()
      return
    end
  elseif Panel_EventNotifyContent:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleClicked_EventNotifyContent_Close()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_Window_PetInfoNew:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PetInfoNew_Close()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_EventNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EventNotifyClose()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_PcRoomNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PcRoomNotifyClose()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_Introduction:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Introcution_TooltipHide()
      return
    end
  elseif Panel_ChallengePresent:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      FGlobal_ChallengePresent_AcceptReward()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_SaveFreeSet:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      HandleClicked_UiSet_ConfirmSetting()
      GlobalKeyBinder_Clear()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_UiSet_FreeSet_Close()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_UI_Setting:IsUse() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      UiSet_FreeSet_Open()
      GlobalKeyBinder_Clear()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_UiSet_Close()
      GlobalKeyBinder_Clear()
      return
    end
  elseif Panel_Win_Check:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      MessageBoxCheck.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      GlobalKeyBinder_Clear()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBoxCheck.keyProcessEscape()
      GlobalKeyBinder_Clear()
      return
    end
  elseif nil ~= getSelfPlayer() and getSelfPlayer():get():isShowWaitComment() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      EventSelfPlayerWaitCommentClose()
      return
    end
  elseif Panel_RandomBoxSelect:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Gacha_Roulette_Close()
      return
    end
  elseif Panel_IngameCashShop_EasyPayment:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_IngameCashShop_BuyOrGift:GetShow() then
        InGameShopBuy_Close()
        return
      end
      PaGlobal_EasyBuy:Close()
      return
    end
  elseif Panel_Window_StampCoupon:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PearlStamp_Close()
      GlobalKeyBinder_Clear()
      return
    end
  elseif UIMode.eUIMode_Housing == _uiMode then
    _keyBinder_UIMode_Housing(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Mental == _uiMode then
    if inputMode == IM.eProcessorInputMode_ChattingInputMode then
      _keyBinder_Chatting(deltaTime)
      GlobalKeyBinder_Clear()
    else
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      _keyBinder_UIMode_Mental(deltaTime)
      GlobalKeyBinder_Clear()
    end
    return
  elseif UIMode.eUIMode_MentalGame == _uiMode then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LEFT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_A) then
      MentalKnowledge_CardRotation_Left()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RIGHT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_D) then
      MentalKnowledge_CardRotation_Right()
    end
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_MentalGame(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_InGameCustomize == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_InGameCustomize(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_InGameDance == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_InGameDance(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_InGameCashShop == _uiMode then
    if inputMode == IM.eProcessorInputMode_ChattingInputMode then
      _keyBinder_Chatting(deltaTime)
      GlobalKeyBinder_Clear()
    else
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      _keyBinder_UIMode_InGameCashShop(deltaTime)
      GlobalKeyBinder_Clear()
    end
    return
  elseif UIMode.eUIMode_DyeNew == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_Dye(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_ItemMarket == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiModeNotInput)
    _keyBinder_UIMode_ItemMarket(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_NpcDialog == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_NpcDialog(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_NpcDialog_Dummy == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Trade == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_Trade(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Stable == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_Stable(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_WorldMap == _uiMode then
    if inputMode == IM.eProcessorInputMode_ChattingInputMode and not Panel_Window_ItemMarket:GetShow() then
      _keyBinder_Chatting(deltaTime)
      GlobalKeyBinder_Clear()
    elseif getInputMode() ~= IM.eProcessorInputMode_ChattingInputMode or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
      _keyBinder_UIMode_WorldMap(deltaTime)
      GlobalKeyBinder_Clear()
    end
    return
  elseif UIMode.eUIMode_WoldMapSearch == _uiMode then
    _keyBinder_WorldMapSearch(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_MiniGame == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
    _keyBinder_UIMode_MiniGame(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_DeadMessage == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_DeadMessage(deltaTime)
    if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Guild) then
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil ~= guildWrapper then
        local guildGrade = guildWrapper:getGuildGrade()
        if 0 == guildGrade then
          if false == Panel_ClanList:IsShow() then
            audioPostEvent_SystemUi(1, 36)
            FGlobal_ClanList_Open()
            UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
          else
            audioPostEvent_SystemUi(1, 31)
            FGlobal_ClanList_Close()
            if false == check_ShowWindow() then
              UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
            end
          end
        elseif false == Panel_Window_Guild:IsShow() and not Panel_DeadMessage:GetShow() then
          audioPostEvent_SystemUi(1, 36)
          GuildManager:Show()
          UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
        else
          audioPostEvent_SystemUi(1, 31)
          GuildManager:Hide()
          if false == check_ShowWindow() then
            UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
          end
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
      end
    end
    if Panel_DeadMessage:GetShow() then
      GuildManager:Hide()
    end
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_PreventMoveNSkill == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_PreventMoveNSkill(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Movie == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_GameMode)
    _keyBinder_UIMode_Movie(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_GameExit == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiModeNotInput)
    _keyBinder_UIMode_GameExit(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Repair == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_Repair(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Extraction == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_Extraction(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_ActionKey == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_ActionKey(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_ActionPad == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_ActionPad(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_UiKey == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_UiKey(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_UiPad == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_UiPad(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_ActionPadFunc1 == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_ActionPadFunc1(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_KeyCustom_ActionPadFunc2 == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_KeyCustomizing)
    _keyBinder_UIMode_KeyCustom_ActionPadFunc2(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_PopupItem == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _keyBinder_UIMode_PopupItem()
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_ProductNote == _uiMode then
    _keyBinder_UIMode_ProductNote(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_QnAWebLink == _uiMode then
    _keyBinder_UIMode_QnAWebLink(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_TradeGame == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _KeyBinder_UIMode_TradeGame(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Cutscene == _uiMode then
    _KeyBinder_UIMode_CutSceneMode(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_UiSetting == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiMode)
    _KeyBinder_UIMode_UiSetting(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_EventNotify == _uiMode then
    _KeyBinder_UIMode_EventNotify(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_Gacha_Roulette == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiModeNotInput)
    _KeyBinder_UIMode_Gacha_Roulette(deltaTime)
    GlobalKeyBinder_Clear()
    return
  elseif UIMode.eUIMode_ScreenShotMode == _uiMode then
    UI.Set_ProcessorInputMode(IM.eProcessorInputMode_UiModeNotInput)
    _KeyBinder_UIMode_ScreenShotMode(delataTime)
    GlobalKeyBinder_Clear()
    return
  end
  if Panel_RecentMemory:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    RecentMemory_Close()
    return
  end
  if Panel_Party_ItemList:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Party_ItemList_Close()
    return
  end
  if Panel_LocalWarInfo:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_LocalWarInfo_Close()
    return
  end
  if Panel_SavageDefenceInfo:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_SavageDefenceInfo_Close()
    return
  end
  if Panel_SavageDefenceShop:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    SavageDefenceShop_CloseByKey()
    return
  end
  if true == _ChattingMacro_Process() then
    return
  end
  if inputMode == IM.eProcessorInputMode_GameMode then
    if Panel_UIControl:IsShow() then
      Panel_UIControl_SetShow(false)
      Panel_Menu_ShowToggle()
    elseif Panel_PartyOption:GetShow() then
      PartyOption_Hide()
    end
    _keyBinder_GameMode(deltaTime)
    _keyBinder_UIMode_CommonWindow(deltaTime)
    _SkillkeyBinder_UIMode_CommonWindow(deltaTime)
  elseif inputMode == IM.eProcessorInputMode_UiMode or inputMode == IM.eProcessorInputMode_UiControlMode then
    _keyBinder_UIMode(deltaTime)
    if UIMode.eUIMode_Default == _uiMode then
      _keyBinder_UIMode_CommonWindow(deltaTime)
      _SkillkeyBinder_UIMode_CommonWindow(deltaTime)
    end
  elseif inputMode == IM.eProcessorInputMode_ChattingInputMode then
    _keyBinder_Chatting(deltaTime)
  elseif inputMode == IM.eProcessorInputMode_UiModeNotInput then
    _keyBinder_UiModeNotInput(deltaTime)
  end
  GlobalKeyBinder_Clear()
end
registerEvent("EventGlobalKeyBinder", "GlobalKeyBinder_Update")
