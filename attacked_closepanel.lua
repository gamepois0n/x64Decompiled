function FromClient_CancelByAttacked()
  if not AllowChangeInputMode() then
    return
  end
  RenderModeAllClose()
  if Panel_PcRoomNotify:GetShow() then
    PcRoomNotify_Close()
  end
  if Panel_Window_GuildWharfFunction:GetShow() then
    GuildWharfFunction_Close()
  end
  ToClient_PopBlackSpiritFlush()
  if Panel_Npc_Trade_Market:IsShow() then
    closeNpcTrade_Basket()
  end
  if Panel_Win_System:GetShow() then
    MessageBox_Empty_function()
  end
  if Panel_KeyboardHelp:GetShow() then
    Panel_KeyboardHelp:SetShow(false)
  end
  if Panel_ChatOption:GetShow() then
    ChattingOption_Close()
  end
  if Panel_RecommandName:GetShow() then
    FGlobal_SendMailForHelpClose()
  end
  if Panel_Chatting_Filter:GetShow() then
    FGlobal_ChattingFilterList_Close()
  end
  if Panel_LocalWarInfo:GetShow() then
    FGlobal_LocalWarInfo_Close()
  end
  if Panel_SetShortCut:GetShow() then
    FGlobal_NewShortCut_Close()
  end
  if Panel_Window_Quest_New_Option:GetShow() then
    FGlobal_CheckedQuestOptionClose()
  end
  if Panel_Window_MonsterRanking:GetShow() then
    FGlobal_MonsterRanking_Close()
  end
  if isPhotoMode() then
    audioPostEvent_SystemUi(8, 14)
  end
  HandleClicked_HouseInstallation_Exit_ByAttacked()
  FGlobal_AgreementGuild_Close()
  FriendMessanger_KillFocusEdit()
  close_WindowMinigamePanelList()
  FGlobal_Gacha_Roulette_Close()
  if 0 ~= dialog_getTalkNpcKey() then
    global_setTrading(false)
  end
  if Panel_GameExit:GetShow() then
    GameExitShowToggle(true)
    FGlobal_ChannelSelect_Hide()
    Panel_GameExit_sendGameDelayExitCancel()
  end
  FGlobal_CloseNpcDialogForDetail()
  FGlobal_HideDialog(true)
  if GameOption_GetHideWindow() then
    ResetKeyCustombyAttacked()
    close_WindowPanelList()
  end
end
registerEvent("progressEventCancelByAttacked", "FromClient_CancelByAttacked")
