local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
function appear_blackSpirit(questNo, blackSpiritUIType)
  ToClient_SaveUiInfo(false)
  close_WindowPanelList()
  local preUIMode = GetUIMode()
  SetUIMode(UIMode.eUIMode_NpcDialog_Dummy)
  local callSummon = RequestAppearBlackSpirit(questNo, blackSpiritUIType)
  if callSummon then
    Panel_Npc_Dialog:SetShow(false)
    FGlobal_Dialog_renderMode:set()
  else
    SetUIMode(preUIMode)
    ToClient_PopBlackSpiritFlush()
    Panel_Npc_Dialog:SetShow(false)
  end
end
registerEvent("appear_blackSpirit", "appear_blackSpirit")
