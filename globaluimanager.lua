local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local isClickControlKey = 0
local panel_WindowList = {
  Panel_Window_ServantInfo,
  Panel_PartyOption,
  Panel_Alchemy,
  Panel_Window_StableFunction,
  Panel_Window_StableList,
  Panel_Window_StableInfo,
  Panel_Window_StableEquipInfo,
  Panel_Window_StableShop,
  Panel_Window_StableMating,
  Panel_Window_StableRegister,
  Panel_Window_StableStallion,
  Panel_Servant_Market_Input,
  Panel_Window_WharfFunction,
  Panel_Window_WharfList,
  Panel_Window_WharfInfo,
  Panel_Window_WharfRegister,
  Panel_Window_Exchange_Number,
  Panel_Win_System,
  Panel_Window_Delivery_Request,
  Panel_Window_Delivery_Information,
  Panel_Window_Delivery_CarriageInformation,
  Panel_Mail_Detail,
  Panel_Mail_Send,
  Panel_CreateClan,
  Panel_IntroMovie,
  Panel_Window_Repair,
  Panel_Scroll,
  Panel_SkillAwaken,
  Panel_Popup_MoveItem,
  Panel_LordMenu,
  Panel_CarriageInfo,
  Panel_FixEquip,
  Panel_Dialogue_Itemtake,
  Panel_CreateGuild,
  Panel_EnableSkill,
  Panel_HelpMessage,
  Panel_ProductNote,
  Panel_KeyboardHelp,
  Panel_WebControl,
  Panel_Window_Quest_New,
  Panel_Interaction_HouseRank,
  Panel_ColorBalance,
  Panel_CheckedQuestInfo,
  Panel_Window_Quest_History,
  Panel_Tooltip_Common,
  Panel_ShipInfo,
  Panel_Window_PetListNew,
  Panel_AgreementGuild_Master,
  Panel_Housing_FarmInfo_New,
  Panel_Window_ItemMarket_ItemSet,
  Panel_ClanList,
  Panel_CarveSeal,
  Panel_ResetSeal,
  Panel_ClearVested,
  Panel_Window_CharInfo_Status,
  Panel_Chatting_Input,
  Panel_Window_GameTips,
  Panel_Window_SkillGuide,
  Panel_MovieTheater_320,
  Panel_MovieTheater_640,
  Panel_MovieTheater_SkillGuide_640,
  Panel_NewKnowledge,
  Panel_QuestInfo,
  Panel_MovieGuide,
  Panel_Window_PetRegister,
  Panel_FishEncyclopedia,
  Panel_Tooltip_Item_chattingLinkedItem,
  Panel_Window_ItemMarket_BuyConfirm,
  Panel_Tooltip_SimpleText,
  Panel_Event_100Day,
  Panel_HousingList,
  Panel_LifeRanking,
  Panel_RecommandName,
  Panel_Interaction_FriendHouseList,
  Panel_GuildWarScore,
  Panel_KnowledgeManagement,
  Panel_Window_StableMix,
  Panel_RecentCook,
  Panel_Window_PetCompose,
  Panel_GuildWebInfo,
  Panel_Guild_Rank,
  Panel_TransferLifeExperience,
  Panel_LinkedHorse_Skill,
  Panel_Window_MaidList,
  Panel_Window_WorkerRandomSelect,
  Panel_Worker_Auction,
  Panel_Window_UnknownRandomSelect,
  Panel_NodeWarMenu,
  Panel_RallyRanking,
  Panel_Window_Warehouse,
  Panel_Manufacture,
  Panel_EnchantExtraction,
  Panel_Join,
  Panel_Window_PetMarket,
  Panel_Window_PetMarketRegist,
  Panel_Window_GuildStableFunction,
  Panel_Window_GuildStable_List,
  Panel_Window_GuildStable_Info,
  Panel_Window_GuildStableRegister,
  Panel_ChangeWeapon,
  Panel_WorkerChangeSkill,
  Panel_GuildServantList,
  Panel_DyePalette,
  Panel_SetShortCut,
  Panel_ExitConfirm,
  Panel_Party_ItemList,
  Panel_Harvest_WorkManager,
  Panel_HarvestList,
  Panel_GuildDuel,
  Panel_Window_PetLookChange,
  Panel_Win_Check,
  Panel_Chatting_Filter,
  Panel_CustomizingAlbum,
  Panel_SetVoiceChat,
  Panel_Chatting_Color,
  Panel_WorkerShipInfo,
  Panel_Window_ItemMarket,
  Panel_GuildRank_Web,
  Panel_SkillReinforce,
  Panel_ItemWarp,
  Panel_Tooltip_Item_chattingLinkedItemClick,
  Panel_GoldenTreasureBox,
  Panel_ScreenShotAlbum,
  Panel_ScreenShotAlbum_FullScreen,
  Panel_GuildHouse_Auction,
  Panel_Window_ReinforceSkill,
  Panel_Guild_Incentive_Foundation,
  Panel_Window_Quest_New_Option,
  Panel_CompetitionGame_JoinDesc,
  Panel_IngameCashShop_Coupon,
  Panel_CompetitionGame_GuildReservation,
  Panel_PartyList,
  Panel_Window_Profile,
  Panel_Window_Dance,
  Panel_DanceFrame,
  Panel_GuildServant_RevivalList,
  Panel_Copyright,
  Panel_TranslationReport,
  Panel_CharacterTag,
  Panel_Widget_DropItem,
  Panel_Window_DropItem,
  Panel_SkillCoolTimeSlot,
  Panel_PetRestoreAll
}
local panel_SoundedWindowList = {
  Panel_Window_Inventory,
  Panel_Equipment,
  Panel_Window_Skill,
  Panel_Window_Enchant,
  Panel_Window_ServantInventory,
  Panel_Window_Warehouse,
  Panel_Mail_Main,
  Panel_Window_Option,
  Panel_Manufacture,
  Panel_Window_Socket,
  Panel_FriendList,
  Panel_Housing_SettingVendingMachine,
  Panel_Housing_VendingMachineList,
  Panel_Housing_SettingConsignmentSale,
  Panel_Housing_RegisterConsignmentSale,
  Panel_Housing_ConsignmentSale,
  Panel_SkillAwaken,
  Panel_Improvement
}
if isUsedNewOption() then
  panel_SoundedWindowList[8] = Panel_Window_cOption
end
local panel_HideListAnimationTrue = {}
if isUsedNewTradeEventNotice_chk() then
  panel_HideListAnimationTrue = {
    Panel_Window_Guild,
    Panel_ItemMarket_AlarmList,
    Panel_GuildWarInfo,
    Panel_ChannelSelect,
    Panel_TradeEventNotice_Renewal,
    Panel_WorkerManager,
    Panel_LevelupGuide
  }
else
  panel_HideListAnimationTrue = {
    Panel_Window_Guild,
    Panel_ItemMarket_AlarmList,
    Panel_GuildWarInfo,
    Panel_ChannelSelect,
    Panel_TradeMarket_EventInfo,
    Panel_WorkerManager,
    Panel_LevelupGuide
  }
end
local panel_MinigameList = {
  Panel_Minigame_Gradient,
  Panel_SinGauge,
  Panel_Command,
  Panel_RhythmGame,
  Panel_BattleGauge,
  Panel_FillGauge,
  Panel_MiniGame_Gradient_Y,
  Panel_MiniGame_Timing,
  Panel_MiniGame_Drag,
  Panel_MiniGame_PowerControl,
  Panel_RhythmGame_ForAction,
  Panel_MiniGame_Steal,
  Panel_MiniGame_PowerControl,
  Panel_MiniGame_Jaksal,
  Panel_RhythmGame_Drum
}
local panel_ExceptionWindowList = {Panel_Npc_Quest_Reward}
local _panelCloseAni = UIAni.closeAni
function check_ShowWindow()
  local panel
  for idx = 1, #panel_WindowList do
    panel = panel_WindowList[idx]
    if nil == panel then
      _PA_ASSERT(false, "GlobalUIManager WindowList\236\151\144\236\132\156 " .. tostring(idx) .. "\235\178\136\236\167\184 Panel\236\157\180 nil \236\158\133\235\139\136\235\139\164. \236\167\128\236\155\140\236\163\188\236\132\184\236\154\148")
    elseif panel:IsShow() and panel:IsUISubApp() == false then
      return true
    end
  end
  for idx = 1, #panel_HideListAnimationTrue do
    panel = panel_HideListAnimationTrue[idx]
    if nil == panel then
      _PA_ASSERT(false, "GlobalUIManager panel_HideListAnimationTrue\236\151\144\236\132\156 " .. tostring(idx) .. "\235\178\136\236\167\184 Panel\236\157\180 nil \236\158\133\235\139\136\235\139\164. \236\167\128\236\155\140\236\163\188\236\132\184\236\154\148")
    elseif panel:IsShow() and panel:IsUISubApp() == false then
      return true
    end
  end
  for idx = 1, #panel_SoundedWindowList do
    panel = panel_SoundedWindowList[idx]
    if nil == panel then
      _PA_ASSERT(false, "GlobalUIManager SoundedWindowList\236\151\144\236\132\156 " .. tostring(idx) .. "\235\178\136\236\167\184 Panel\236\157\180 nil \236\158\133\235\139\136\235\139\164. \236\167\128\236\155\140\236\163\188\236\132\184\236\154\148")
    elseif panel:IsShow() and panel:IsUISubApp() == false then
      audioPostEvent_SystemUi(1, 1)
      return true
    end
  end
  for idx = 1, #panel_ExceptionWindowList do
    panel = panel_ExceptionWindowList[idx]
    if nil == panel then
      _PA_ASSERT(false, "GlobalUIManager SoundedWindowList\236\151\144\236\132\156 " .. tostring(idx) .. "\235\178\136\236\167\184 Panel\236\157\180 nil \236\158\133\235\139\136\235\139\164. \236\167\128\236\155\140\236\163\188\236\132\184\236\154\148")
    elseif panel:IsShow() and panel:IsUISubApp() == false then
      audioPostEvent_SystemUi(1, 1)
      return true
    end
  end
  return false
end
local Panel_LowLevelGuide_Value_IsCheckMoviePlay = Panel_LowLevelGuide_Value_IsCheckMoviePlay
isComboMovieClosedCount = 0
function close_WindowPanelList()
  if Panel_MovieTheater_320:IsShow() == false then
    value_Panel_MovieTheater_320_IsCheckedShow = false
  end
  if value_Panel_MovieTheater_320_IsCheckedShow == true then
    isComboMovieClosedCount = isComboMovieClosedCount + 1
    if isComboMovieClosedCount >= 3 then
      Panel_MovieTheater320_MessageBox()
      Panel_MovieTheater_MessageBox:SetShow(true)
    else
      Panel_MovieTheater320_ResetMessageBox()
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()
  Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  Panel_SkillTooltip_Hide()
  FGlobal_BuffTooltipOff()
  if Panel_IngameCashShop_GoodsTooltip:IsShow() then
    Panel_IngameCashShop_GoodsTooltip:SetShow(false)
  end
  if Panel_CustomizingAlbum:GetShow() == true then
    CustomizingAlbum_Close()
  end
  Panel_Knowledge_Hide()
  if Panel_ProductNote:IsShow() and false == Panel_ProductNote:IsUISubApp() then
    Panel_ProductNote_ShowToggle()
    return
  end
  if Panel_KeyboardHelp:IsShow() then
    FGlobal_KeyboardHelpShow()
    return
  end
  if Panel_WebControl:IsShow() then
    Panel_WebHelper_ShowToggle()
    return
  end
  if Panel_Window_Warehouse:GetShow() then
    Warehouse_Close()
  end
  if Panel_Window_Skill:IsShow() then
    HandleMLUp_SkillWindow_Close()
  end
  if Panel_EventNotify:GetShow() then
    FGlobal_EventNotifyClose()
  end
  if Panel_SetVoiceChat:GetShow() then
    FGlobal_SetVoiceChat_Close()
  end
  if Panel_WorkerChangeSkill:GetShow() then
    FGlobal_workerChangeSkill_Close()
  end
  if Panel_FileExplorer:GetShow() then
    closeExplorer()
    return
  end
  if Panel_WorkerManager:GetShow() and not Panel_WorldMap:GetShow() and Panel_WorkerManager:IsUISubApp() == false then
    workerManager_Close()
    FGlobal_HideWorkerTooltip()
    return
  end
  if Panel_Worker_Auction:GetShow() then
    if Panel_WorkerResist_Auction:GetShow() then
      FGlobal_ResistWorkerToAuction_Close()
      return
    end
    if Panel_WorkerList_Auction:GetShow() then
      MyworkerList_Close()
      return
    end
    WorkerAuction_Close()
  end
  if Panel_Window_Exchange:GetShow() then
    Panel_ExchangePC_BtnClose_Mouse_Click()
    return
  end
  if Panel_TransferLifeExperience:GetShow() then
    FGlobal_TransferLife_Close()
    return
  end
  if Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if Panel_SetShortCut:GetShow() then
    FGlobal_NewShortCut_Close()
    return
  end
  if Panel_Window_Inventory:IsShow() and Panel_Window_Inventory:IsUISubApp() == false then
    InventoryWindow_Close()
    if Panel_Equipment:GetShow() then
      Equipment_SetShow(false)
    end
  end
  if Panel_Window_Exchange_Number:IsShow() then
    Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  end
  if FGlobal_Option_GetShow() then
    GameOption_Cancel()
    TooltipSimple_Hide()
  end
  if Panel_CarveSeal:IsShow() then
    FromClient_SealWindowHide()
  end
  if Panel_GuildWebInfo:GetShow() then
    FGlobal_GuildWebInfoClose()
    return
  end
  if Panel_GuildRank_Web:GetShow() then
    GuildRank_Web_Close()
  end
  if Panel_Guild_Rank:GetShow() then
    FGlobal_guildRanking_Close()
    return
  end
  if Panel_ChangeWeapon:GetShow() then
    WeaponChange_Close()
    return
  end
  if Panel_SkillReinforce:GetShow() then
    Panel_SkillReinforce_Close()
  end
  messageBox_CloseButtonUp()
  if Panel_Looting:IsShow() == true then
  end
  if Panel_FriendList:IsShow() then
    FriendList_hide()
  end
  if Panel_KnowledgeManagement:GetShow() then
    FGlobal_KnowledgeClose()
  end
  if Panel_Window_Quest_New:GetShow() and Panel_Window_Quest_New:IsUISubApp() == false then
    Panel_Window_QuestNew_Show(false)
  end
  if Panel_CheckedQuestInfo:GetShow() and not Panel_CheckedQuestInfo:IsUISubApp() then
    FGlobal_QuestInfoDetail_Close()
  end
  if Panel_IntroMovie:IsShow() then
    CloseIntroMovie()
    return true
  end
  if Panel_Window_Delivery_Request:GetShow() then
    DeliveryRequestWindow_Close()
  end
  if Panel_Window_Guild:GetShow() then
    if Panel_AgreementGuild_Master:GetShow() then
      agreementGuild_Master_Close()
      return
    elseif Panel_GuildIncentive:GetShow() then
      FGlobal_GuildIncentive_Close()
      return
    elseif Panel_GuildDuel:GetShow() then
      FGlobal_GuildDuel_Close()
      return
    end
    audioPostEvent_SystemUi(1, 31)
    GuildManager:Hide()
  end
  if Panel_AgreementGuild:GetShow() then
    CheckChattingInput()
    audioPostEvent_SystemUi(1, 31)
    FGlobal_AgreementGuild_Close()
    return
  end
  if Panel_Window_GameTips:IsShow() then
    FGlobal_GameTipsHide()
  end
  if Panel_Window_PetInfoNew:IsShow() then
    TooltipSimple_Hide()
  end
  if Panel_Event_100Day:IsShow() then
    FGlobal_Event_100Day_Close()
    return
  end
  if Panel_DanceFrame:GetShow() == true then
    FGlobal_DanceFrame_Close()
    return
  end
  if Panel_WorkerManager:GetShow() and Panel_WorkerManager:IsUISubApp() == false then
    workerManager_Close()
  end
  if Panel_Worker_Tooltip:GetShow() then
    FGlobal_HideWorkerTooltip()
  end
  if Panel_ChangeItem:GetShow() then
    ItemChange_Close()
  end
  if Panel_MovieGuide:IsShow() then
    Panel_MovieGuide_ShowToggle()
  end
  if Panel_Window_ItemMarket_RegistItem:GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
  if Panel_AlchemyStone:GetShow() and Panel_AlchemyStone:IsUISubApp() == false then
    FGlobal_AlchemyStone_Close()
  end
  if Panel_AlchemyFigureHead:GetShow() and Panel_AlchemyFigureHead:IsUISubApp() == false then
    FGlobal_AlchemyFigureHead_Close()
  end
  if Panel_MovieTheater_320:IsShow() then
    Panel_MovieTheater320_JustClose()
  end
  if Panel_Window_ItemMarket:GetShow() and Panel_Window_ItemMarket:IsUISubApp() == false then
    FGolbal_ItemMarketNew_Close()
  end
  if Panel_CharacterTag:GetShow() then
    PaGlobal_CharacterTag_Close()
  end
  for _, loopPanel in ipairs(panel_WindowList) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, false)
    end
  end
  for _, loopPanel in ipairs(panel_HideListAnimationTrue) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, true)
    end
  end
  for _, loopPanel in ipairs(panel_SoundedWindowList) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, false)
    end
  end
  if not Panel_Npc_Dialog:GetShow() then
    for _, loopPanel in ipairs(panel_ExceptionWindowList) do
      if loopPanel:IsUISubApp() == false then
        loopPanel:SetShow(false, false)
      end
    end
  end
  AcquireDirecteReShowUpdate()
  if isFocusInChatting() then
    Panel_Chatting_Input:SetShow(true, false)
  end
  if Panel_LowLevelGuide_Value_IsCheckMoviePlay == 1 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindWay()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 2 then
    FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 3 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 4 then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 99 then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
  end
end
function close_force_WindowPanelList()
  if Panel_MovieTheater_320:IsShow() == false then
    value_Panel_MovieTheater_320_IsCheckedShow = false
  end
  if value_Panel_MovieTheater_320_IsCheckedShow == true then
    isComboMovieClosedCount = isComboMovieClosedCount + 1
    if isComboMovieClosedCount >= 3 then
      Panel_MovieTheater320_MessageBox()
      Panel_MovieTheater_MessageBox:SetShow(true)
    else
      Panel_MovieTheater320_ResetMessageBox()
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()
  Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  Panel_SkillTooltip_Hide()
  FGlobal_BuffTooltipOff()
  if Panel_IngameCashShop_GoodsTooltip:IsShow() then
    Panel_IngameCashShop_GoodsTooltip:SetShow(false)
  end
  Panel_Knowledge_Hide()
  if Panel_WebControl:IsShow() then
    Panel_WebHelper_ShowToggle()
  end
  if Panel_Window_Warehouse:GetShow() then
    Warehouse_Close()
  end
  if Panel_Window_Skill:IsShow() then
    HandleMLUp_SkillWindow_Close()
  end
  if Panel_SetVoiceChat:GetShow() then
    FGlobal_SetVoiceChat_Close()
  end
  if Panel_WorkerChangeSkill:GetShow() then
    FGlobal_workerChangeSkill_Close()
  end
  if Panel_FileExplorer:GetShow() then
    closeExplorer()
  end
  if Panel_WorkerManager:GetShow() and not Panel_WorldMap:GetShow() then
    HandleClicked_WorkerManager_Close()
    FGlobal_HideWorkerTooltip()
  end
  if Panel_Worker_Auction:GetShow() then
    if Panel_WorkerResist_Auction:GetShow() then
      FGlobal_ResistWorkerToAuction_Close()
    end
    if Panel_WorkerList_Auction:GetShow() then
      MyworkerList_Close()
    end
    WorkerAuction_Close()
  end
  if Panel_Window_Exchange:GetShow() then
    Panel_ExchangePC_BtnClose_Mouse_Click()
  end
  if Panel_TransferLifeExperience:GetShow() then
    FGlobal_TransferLife_Close()
  end
  if Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if Panel_SetShortCut:GetShow() then
    FGlobal_NewShortCut_Close()
    return
  end
  if Panel_Window_Inventory:IsShow() then
    HandleClicked_InventoryWindow_Close()
    if Panel_Equipment:GetShow() then
      Equipment_SetShow(false)
    end
  end
  if Panel_Window_Exchange_Number:IsShow() then
    Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  end
  if FGlobal_Option_GetShow() then
    GameOption_Cancel()
    TooltipSimple_Hide()
  end
  if Panel_CarveSeal:IsShow() then
    FromClient_SealWindowHide()
  end
  if Panel_GuildWebInfo:GetShow() then
    FGlobal_GuildWebInfoClose()
  end
  if Panel_GuildRank_Web:GetShow() then
    GuildRank_Web_Close()
  end
  if Panel_Guild_Rank:GetShow() then
    FGlobal_guildRanking_Close()
  end
  if Panel_ChangeWeapon:GetShow() then
    WeaponChange_Close()
  end
  if Panel_SkillReinforce:GetShow() then
    Panel_SkillReinforce_Close()
  end
  messageBox_CloseButtonUp()
  if Panel_Looting:IsShow() == true then
  end
  if Panel_FriendList:IsShow() then
    FriendList_hide()
  end
  if Panel_KnowledgeManagement:GetShow() then
    FGlobal_KnowledgeClose()
  end
  if Panel_Window_Quest_New:GetShow() then
    HandleClicked_QuestNew_Close()
  end
  if Panel_CheckedQuestInfo:GetShow() and not Panel_CheckedQuestInfo:IsUISubApp() then
    FGlobal_QuestInfoDetail_Close()
  end
  if Panel_IntroMovie:IsShow() then
    CloseIntroMovie()
  end
  if Panel_Window_Delivery_Request:GetShow() then
    DeliveryRequestWindow_Close()
  end
  if Panel_Window_Guild:GetShow() then
    if Panel_AgreementGuild_Master:GetShow() then
      agreementGuild_Master_Close()
    elseif Panel_GuildIncentive:GetShow() then
      FGlobal_GuildIncentive_Close()
    elseif Panel_GuildDuel:GetShow() then
      FGlobal_GuildDuel_Close()
    end
    audioPostEvent_SystemUi(1, 31)
    GuildManager:Hide()
  end
  if Panel_AgreementGuild:GetShow() then
    CheckChattingInput()
    audioPostEvent_SystemUi(1, 31)
    FGlobal_AgreementGuild_Close()
  end
  if Panel_Window_GameTips:IsShow() then
    FGlobal_GameTipsHide()
  end
  if Panel_Window_PetInfoNew:IsShow() then
    TooltipSimple_Hide()
  end
  if Panel_ProductNote:IsShow() then
    Panel_ProductNote_ShowToggle()
  end
  if Panel_KeyboardHelp:IsShow() then
    FGlobal_KeyboardHelpShow()
  end
  if Panel_Event_100Day:IsShow() then
    FGlobal_Event_100Day_Close()
  end
  if Panel_WorkerManager:GetShow() then
    workerManager_Close()
  end
  if Panel_Worker_Tooltip:GetShow() then
    FGlobal_HideWorkerTooltip()
  end
  if Panel_ChangeItem:GetShow() then
    ItemChange_Close()
  end
  if Panel_MovieGuide:IsShow() then
    Panel_MovieGuide_ShowToggle()
  end
  if Panel_Window_ItemMarket_RegistItem:GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
  if Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if Panel_AlchemyFigureHead:GetShow() then
    FGlobal_AlchemyFigureHead_Close()
  end
  if Panel_MovieTheater_320:IsShow() then
    Panel_MovieTheater320_JustClose()
  end
  if isUsedNewTradeEventNotice_chk() then
    if Panel_TradeEventNotice_Renewal:IsShow() then
      FGlobal_TradeEventNotice_Renewal_Close()
    end
  elseif Panel_TradeMarket_EventInfo:IsShow() then
    TradeEventInfo_Close()
  end
  if Panel_Window_ItemMarket:GetShow() then
    HandleClicked_ItemMarket_Close()
  end
  for _, loopPanel in ipairs(panel_WindowList) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, false)
    end
  end
  for _, loopPanel in ipairs(panel_HideListAnimationTrue) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, true)
    end
  end
  for _, loopPanel in ipairs(panel_SoundedWindowList) do
    if loopPanel:IsUISubApp() == false then
      loopPanel:SetShow(false, false)
    end
  end
  if not Panel_Npc_Dialog:GetShow() then
    for _, loopPanel in ipairs(panel_ExceptionWindowList) do
      if loopPanel:IsUISubApp() == false then
        loopPanel:SetShow(false, false)
      end
    end
  end
  AcquireDirecteReShowUpdate()
  if isFocusInChatting() then
    Panel_Chatting_Input:SetShow(true, false)
  end
  if Panel_LowLevelGuide_Value_IsCheckMoviePlay == 1 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindWay()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 2 then
    FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 3 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 4 then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 99 then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
  end
  if Panel_Window_Camp:GetShow() then
    PaGlobal_Camp:close()
  end
  if Panel_Window_MonsterRanking:GetShow() then
    FGlobal_MonsterRanking_Close()
  end
  if Panel_ChatOption:GetShow() then
    ChattingOption_Close()
  end
  close_UISubAppPanelList()
end
function close_WindowMinigamePanelList()
  for _, loopPanel in ipairs(panel_MinigameList) do
    loopPanel:SetShow(false, false)
  end
end
function close_UISubAppPanelList()
  Panel_Knowledge_Hide()
  if Panel_WorkerManager:GetShow() and not Panel_WorldMap:GetShow() then
    HandleClicked_WorkerManager_Close()
    FGlobal_HideWorkerTooltip()
  end
  if Panel_Window_Inventory:IsShow() and Panel_Window_Inventory:IsUISubApp() then
    HandleClicked_InventoryWindow_Close()
  end
  if Panel_Equipment:IsShow() and Panel_Equipment:IsUISubApp() then
    HandleClicked_EquipmentWindow_Close()
  end
  if Panel_KnowledgeManagement:GetShow() then
    FGlobal_KnowledgeClose()
  end
  if Panel_Window_Quest_New:GetShow() and Panel_Window_Quest_New:IsUISubApp() then
    HandleClicked_QuestNew_Close()
  end
  if Panel_Npc_Quest_Reward:IsUISubApp() then
    FGlobal_ShowRewardList(false, 0)
  end
  if Panel_WorkerManager:GetShow() and Panel_WorkerManager:IsUISubApp() then
    workerManager_Close()
  end
  if isUsedNewTradeEventNotice_chk() then
    if Panel_TradeEventNotice_Renewal:IsShow() and Panel_TradeEventNotice_Renewal:IsUISubApp() then
      FGlobal_TradeEventNotice_Renewal_Close()
    end
  elseif Panel_TradeMarket_EventInfo:IsShow() and Panel_TradeMarket_EventInfo:IsUISubApp() then
    TradeEventInfo_Close()
  end
  if Panel_Window_ItemMarket:GetShow() and Panel_Window_ItemMarket:IsUISubApp() then
    HandleClicked_ItemMarket_Close()
  end
  if Panel_Window_BlackSpiritAdventure:GetShow() and Panel_Window_BlackSpiritAdventure:IsUISubApp() then
    BlackSpiritAd_Hide()
  end
  if Panel_Window_Guild:GetShow() and Panel_Window_Guild:IsUISubApp() then
    HandleClickedGuildHideButton()
  end
  if Panel_GuildWarInfo:GetShow() and Panel_GuildWarInfo:IsUISubApp() then
    Panel_GuildWarInfo_Hide()
  end
  if Panel_Window_CharInfo_Status:GetShow() and Panel_Window_CharInfo_Status:IsUISubApp() then
    if isNewCharacterInfo() == false then
      CharacterInfoWindow_Hide()
    else
      PaGlobal_CharacterInfo:hideWindow()
    end
  end
end
