local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
function PaGlobal_GlobalKeyBinder.Process_GameMode()
  DragManager:clearInfo()
  if Panel_UIControl:IsShow() then
    Panel_UIControl_SetShow(false)
    Panel_Menu_ShowToggle()
  elseif Panel_PartyOption:GetShow() then
    PartyOption_Hide()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Housing(deltaTime)
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
  elseif not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Housing_CancelModeFromKeyBinder()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Mental(deltaTime)
  if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_MentalKnowledge)) then
    Panel_Knowledge_Hide()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_MentalGame(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LEFT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_A) then
    MentalKnowledge_CardRotation_Left()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RIGHT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_D) then
    MentalKnowledge_CardRotation_Right()
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    MentalGame_Hide()
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_NpcDialog(deltaTime)
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
    if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      handleClicked_GuildCreateCancel()
    end
    return
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_Trade(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    closeNpcTrade_Basket()
    TooltipSimple_Hide()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_WorldMap(deltaTime)
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
function PaGlobal_GlobalKeyBinder.Process_WorldMapSearch(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ClearFocusEdit()
    if ToClient_WorldMapIsShow() then
      SetUIMode(Defines.UIMode.eUIMode_WorldMap)
    else
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Stable(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_MiniGame(deltaTime)
  local MiniGame_BattleGauge_Space = Panel_BattleGauge:IsShow()
  local MiniGame_FillGauge_Mouse = Panel_FillGauge:IsShow()
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_DeadMessage(deltaTime)
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Chat) then
    ChatInput_Show()
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Guild) then
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil ~= guildWrapper then
      local guildGrade = guildWrapper:getGuildGrade()
      if 0 == guildGrade then
        if false == Panel_ClanList:IsShow() then
          audioPostEvent_SystemUi(1, 36)
          FGlobal_ClanList_Open()
        else
          audioPostEvent_SystemUi(1, 31)
          FGlobal_ClanList_Close()
        end
      elseif false == Panel_Window_Guild:IsShow() and not Panel_DeadMessage:GetShow() then
        audioPostEvent_SystemUi(1, 36)
        GuildManager:Show()
      else
        audioPostEvent_SystemUi(1, 31)
        GuildManager:Hide()
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
    end
  end
  if Panel_DeadMessage:GetShow() then
    GuildManager:Hide()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_PreventMoveNSkill(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Movie(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if check_ShowWindow() then
      close_WindowPanelList()
      return
    elseif Panel_UIControl:IsShow() then
      Panel_UIControl_SetShow(false)
      Panel_Menu_ShowToggle()
      return
    else
      Panel_UIControl_SetShow(true)
      Panel_Menu_ShowToggle()
      return
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_GameExit(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_Repair(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_FixEquip:GetShow() then
      PaGlobal_FixEquip:fixEquipExit()
    else
      PaGlobal_Repair:RepairExit()
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionKey(deltaTime)
  local isEnd = false
  local inputType
  if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Action_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Key()
    KeyCustom_Action_KeyButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPad(deltaTime)
  local isEnd = false
  local inputType
  if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Action_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_PadButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_UiKey(deltaTime)
  local isEnd = false
  local inputType
  if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Ui_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Ui_UpdateButtonText_Key()
    KeyCustom_Ui_KeyButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_UiPad(deltaTime)
  local isEnd = false
  local inputType
  if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Ui_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Ui_UpdateButtonText_Pad()
    KeyCustom_Ui_PadButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPadFunc1(deltaTime)
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(0)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPadFunc2(deltaTime)
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
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == isUsedNewOption() and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(1)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_PopupItem()
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_UseItem_ShowToggle_Func()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Extraction(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameCustomize(deltaTime)
  if Panel_CustomizationMain:IsShow() and Panel_CustomizationMain:GetAlpha() == 1 and not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
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
    if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameCashShop(delataTime)
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_Dye(delataTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Dyeing) then
    audioPostEvent_SystemUi(1, 23)
    FGlobal_Panel_DyeReNew_Hide()
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_ItemMarket(delataTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
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
    if true == Panel_IngameCashShop_Password:GetShow() then
      PayMentPassword_Confirm()
    else
      FGlobal_ItemMarketRegistItem_RegistDO()
    end
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_ProductNote(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_ProductNote_ShowToggle()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_QnAWebLink(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == Panel_QnAWebLink_ShowToggle() then
    CheckChattingInput()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_TradeGame(deltaTime)
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    Fglobal_TradeGame_Close()
    return
  end
  global_Update_TradeGame(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_CutSceneMode(deltaTime)
  if ToClient_cutsceneIsPlay() then
    if not MessageBox.isPopUp() and isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_UiSetting(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_UiSet_Close()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Gacha_Roulette(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    FGlobal_gacha_Roulette_OnPressSpace()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_gacha_Roulette_OnPressEscape()
  end
  return
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_EventNotify(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    EventNotifyContent_Close()
    CheckChattingInput()
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_ScreenShotMode(delataTime)
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameDance(deltaTime)
  if getGameDanceEditor():isShow() == true and not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Dance_Close()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ButtonShortcuts(deltaTime)
  local isEnd = false
  local clickedAlt = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU)
  local clickedShift = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT)
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    PaGlobal_ButtonShortcuts:Remove()
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if false == clickedAlt then
    return
  end
  local VirtualKeyCode = keyCustom_GetVirtualKey()
  if VirtualKeyCode > 0 then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    PaGlobal_ButtonShortcuts:Register(VirtualKeyCode, clickedAlt, clickedShift)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UiModeNotInput()
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if false == GlobalSwitch_UseOldAlchemy then
      FGlobal_Alchemy_Close()
    else
      Alchemy_Close()
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_ChattingMacro()
  if false == isKeyPressed(VCK.KeyCode_MENU) then
    return false
  end
  if false == isKeyPressed(VCK.KeyCode_SHIFT) then
    return false
  end
  local ii
  for ii = VCK.KeyCode_0, VCK.KeyCode_9 do
    local key = ii - VCK.KeyCode_0 - 1
    if key < 0 then
      key = VCK.KeyCode_9 - VCK.KeyCode_0
    end
    if isKeyDown_Once(ii) and "" ~= ToClient_getMacroChatMessage(key) then
      ToClient_executeChatMacro(key)
      return true
    end
  end
  return false
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SkillkeyBinder(deltaTime)
  if isUseNewQuickSlot() then
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
    for ii = quickSlot1, quickSlot20 do
      if keyCustom_IsDownOnce_Action(ii) then
        HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
        return
      end
    end
  else
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
    for ii = quickSlot1, quickSlot10 do
      if keyCustom_IsDownOnce_Action(ii) then
        QuickSlot_Click(tostring(ii - quickSlot1))
        return
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_Normal(deltaTime)
  if MessageBox.isPopUp() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      MessageBox.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBox.keyProcessEscape()
      return true
    end
  elseif Panel_UseItem:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      Click_Panel_UserItem_Yes()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_UseItem_ShowToggle_Func()
    end
    return true
  elseif Panel_ExitConfirm:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      Panel_GameExit_MinimizeTray()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_ExitConfirm:SetShow(false)
    end
    return true
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
    return true
  elseif Panel_Chatting_Macro:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Chatting_Macro_ShowToggle()
      FGlobal_Chatting_Macro_SetCHK(false)
      CheckChattingInput()
      return true
    end
  elseif Panel_Chat_SocialMenu:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_Chatting_Input:GetShow() then
        ChatInput_CancelAction()
        ChatInput_CancelMessage()
        ChatInput_Close()
        friend_clickAddFriendClose()
      else
        FGlobal_SocialAction_SetCHK(false)
        FGlobal_SocialAction_ShowToggle()
        CheckChattingInput()
      end
      return true
    end
  elseif Panel_Chat_SubMenu:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_Chatting_Block_GoldSeller:GetShow() then
        FGlobal_reportSeller_Close()
        return true
      end
      Panel_Chat_SubMenu:SetShow(false)
      return true
    end
  elseif Panel_GuildIncentive:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and not FGlobal_CheckSaveGuildMoneyUiEdit(GetFocusEdit()) then
      FGlobal_SaveGuildMoney_Send()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildIncentive_Close()
      return true
    end
    FGlobal_GuildDeposit_InputCheck()
    return true
  elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_AlchemySton) and false == isKeyPressed(VCK.KeyCode_CONTROL) then
    local inputMode = getInputMode()
    if inputMode == IM.eProcessorInputMode_GameMode then
      FGlobal_AlchemyStone_Use()
      return true
    elseif (inputMode == IM.eProcessorInputMode_UiMode or inputMode == IM.eProcessorInputMode_UiControlMode) and UIMode.eUIMode_Default == GetUIMode() then
      FGlobal_AlchemyStone_Use()
      return true
    end
  elseif Panel_EventNotifyContent:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleClicked_EventNotifyContent_Close()
      return true
    end
  elseif Panel_Window_PetInfoNew:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PetInfoNew_Close()
      return true
    end
  elseif Panel_EventNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EventNotifyClose()
      return true
    end
  elseif Panel_PcRoomNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PcRoomNotifyClose()
      return true
    end
  elseif Panel_Introduction:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Introcution_TooltipHide()
      return true
    end
  elseif Panel_ChallengePresent:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      FGlobal_ChallengePresent_AcceptReward()
      return true
    end
  elseif Panel_SaveFreeSet:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      HandleClicked_UiSet_ConfirmSetting()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_SaveSetting:GetShow() then
        PaGlobal_Panel_SaveSetting_Hide()
        return true
      else
        PaGlobal_UiSet_FreeSet_Close()
        return true
      end
    end
  elseif Panel_UI_Setting:IsUse() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      UiSet_FreeSet_Open()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_SaveSetting:GetShow() then
        PaGlobal_Panel_SaveSetting_Hide()
        return true
      else
        FGlobal_UiSet_Close()
        return true
      end
    end
  elseif Panel_Win_Check:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      MessageBoxCheck.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBoxCheck.keyProcessEscape()
      return true
    end
  elseif nil ~= getSelfPlayer() and getSelfPlayer():get():isShowWaitComment() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      EventSelfPlayerWaitCommentClose()
      return true
    end
  elseif Panel_RandomBoxSelect:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Gacha_Roulette_Close()
      return true
    end
  elseif Panel_IngameCashShop_EasyPayment:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_IngameCashShop_BuyOrGift:GetShow() then
        InGameShopBuy_Close()
        return true
      end
      PaGlobal_EasyBuy:Close()
      return true
    end
  elseif Panel_Window_StampCoupon:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_PearlStamp_Close()
    return true
  end
  if Panel_RecentMemory:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    RecentMemory_Close()
    return true
  end
  if Panel_Party_ItemList:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Party_ItemList_Close()
    return true
  end
  if Panel_LocalWarInfo:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_LocalWarInfo_Close()
    return true
  end
  if Panel_SavageDefenceInfo:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_SavageDefenceInfo_Close()
    return true
  end
  if Panel_SavageDefenceShop:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    SavageDefenceShop_CloseByKey()
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
function PaGlobal_GlobalKeyBinder.Process_ChattingInputMode()
  uiEdit = GetFocusEdit()
  if nil == uiEdit then
    return false
  end
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
  elseif true == isUsedMemoOpen() and FGlobal_Memo_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_Memo:Save()
    end
    return true
  elseif true == isUsedNewOption() and true == FGlobal_Option_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobal_Option:ClickedSeachOption()
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
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ClearFocusEdit()
  end
  return false
end
local fastPinDelta = 0
function PaGlobal_GlobalKeyBinder.Process_UIMode_CommonWindow(deltaTime)
  if true == FGlobal_GetFirstTutorialState() then
    return
  end
  local checkButtonShortcuts = ToClent_checkAndRunButtonShortcutsEvent()
  if true == checkButtonShortcuts then
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
        return
      elseif interactableActor ~= nil and interactableActor:get():isPlayer() and camBlur <= 0 then
        local interactionType = interactableActor:getSettedFirstInteractionType()
        if InteractionCheck(interactionType) then
          return
        end
        Interaction_ButtonPushed(interactionType)
        DragManager:clearInfo()
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_1) then
      if buttonCount >= 2 then
        FGlobal_InteractionButtonActionRun(1)
        DragManager:clearInfo()
        setUiInputProcessed(VCK.KeyCode_F5)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_2) then
      if buttonCount >= 3 then
        FGlobal_InteractionButtonActionRun(2)
        DragManager:clearInfo()
        setUiInputProcessed(VCK.KeyCode_F6)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_3) then
      if buttonCount >= 4 then
        FGlobal_InteractionButtonActionRun(3)
        DragManager:clearInfo()
        setUiInputProcessed(VCK.KeyCode_F7)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_4) then
      if buttonCount >= 5 then
        FGlobal_InteractionButtonActionRun(4)
        DragManager:clearInfo()
        setUiInputProcessed(VCK.KeyCode_F8)
        return
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Interaction_5) then
      if buttonCount >= 6 then
        FGlobal_InteractionButtonActionRun(5)
        DragManager:clearInfo()
        setUiInputProcessed(VCK.KeyCode_F9)
        return
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F10) and buttonCount >= 7 then
      FGlobal_InteractionButtonActionRun(6)
      DragManager:clearInfo()
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
    ChatInput_Show()
    return
  end
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) and Panel_Looting:IsShow() then
    Panel_Looting_buttonLootAll_Mouse_Click(false)
    Panel_Tooltip_Item_hideTooltip()
    QuestInfoData.questDescHideWindow()
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Help) then
    if nil ~= Panel_KeyboardHelp then
      FGlobal_Panel_WebHelper_ShowToggle()
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_ProductionNote) then
    if nil ~= Panel_ProductNote and not Panel_ProductNote:IsUISubApp() then
      Panel_ProductNote_ShowToggle()
    end
    return
  end
  local selfPlayer = getSelfPlayer()
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_PlayerInfo) then
    if Panel_Window_CharInfo_Status ~= nil then
      if Panel_Window_CharInfo_Status:GetShow() and not Panel_Window_CharInfo_Status:IsUISubApp() then
        audioPostEvent_SystemUi(1, 31)
        if isNewCharacterInfo() == false then
          CharacterInfoWindow_Hide()
        else
          PaGlobal_CharacterInfo:hideWindow()
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
          else
            requestInformationFromServant()
            ServantInfo_BeforOpenByActorKeyRaw(actorKeyRaw)
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
      else
        audioPostEvent_SystemUi(1, 18)
        PaGlobal_Skill:SkillWindow_Show()
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
        local isInvenOpen = Panel_Window_Inventory:GetShow()
        local isManufactureOpen = Panel_Manufacture:GetShow()
        if isManufactureOpen == false or isInvenOpen == false then
          audioPostEvent_SystemUi(1, 26)
          Manufacture_Show(nil, CppEnums.ItemWhereType.eInventory, true)
        else
          audioPostEvent_SystemUi(1, 25)
          Manufacture_Close()
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
        else
          audioPostEvent_SystemUi(1, 31)
          FGlobal_ClanList_Close()
        end
      elseif false == Panel_Window_Guild:IsShow() then
        audioPostEvent_SystemUi(1, 36)
        GuildManager:Show()
      else
        audioPostEvent_SystemUi(1, 31)
        GuildManager:Hide()
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Mail) then
    if Panel_Mail_Main ~= nil and Panel_Mail_Detail ~= nil then
      local isMailMain = Panel_Mail_Main:IsShow()
      if isMailMain == false then
        audioPostEvent_SystemUi(1, 22)
        Mail_Open()
      else
        audioPostEvent_SystemUi(1, 21)
        Mail_Close()
      end
    end
    return
  end
  if true == isUsedMemoOpen() and GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_Memo) then
    if Panel_Memo_List ~= nil then
      local isMemoList = Panel_Memo_List:IsShow()
      if isMemoList == false then
        audioPostEvent_SystemUi(1, 22)
        PaGlobal_Memo:ListOpen()
      else
        audioPostEvent_SystemUi(1, 21)
        PaGlobal_Memo:ListClose()
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_FriendList) then
    if Panel_FriendList ~= nil then
      local isFriendList = Panel_FriendList:IsShow()
      if isFriendList == false then
        FriendList_show()
        audioPostEvent_SystemUi(1, 28)
      else
        FriendList_hide()
        audioPostEvent_SystemUi(1, 27)
      end
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(CppEnums.UiInputType.UiInputType_QuestHistory) then
    if Panel_Window_Quest_New:GetShow() then
      audioPostEvent_SystemUi(1, 27)
      Panel_Window_QuestNew_Show(false)
    else
      audioPostEvent_SystemUi(1, 29)
      Panel_Window_QuestNew_Show(true)
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
    if not Panel_Global_Manual:GetShow() or FGlobal_BulletCount_UiShowCheck() then
      FGlobal_PushOpenWorldMap()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_MINIGAMING_NOT_WORLDMAP"))
      return
    end
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
  PaGlobal_GlobalKeyBinder.Process_CheckEscape()
end
function PaGlobal_GlobalKeyBinder.Process_CheckEscape()
  if true == getEscHandle() or false == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    return
  end
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
  if Panel_CustomizingAlbum:GetShow() == true then
    CustomizingAlbum_Close()
  end
  local checkShowWindow = check_ShowWindow()
  if checkShowWindow then
    close_WindowPanelList()
    FGlobal_NpcNavi_Hide()
    return
  end
  if checkShowWindow and FGlobal_NpcNavi_IsShowCheck() then
    close_WindowPanelList()
    FGlobal_NpcNavi_Hide()
    return
  elseif not checkShowWindow and FGlobal_NpcNavi_IsShowCheck() then
    FGlobal_NpcNavi_Hide()
    return
  elseif checkShowWindow and not FGlobal_NpcNavi_IsShowCheck() then
    close_WindowPanelList()
    return
  else
    Panel_Menu_ShowToggle()
  end
end
