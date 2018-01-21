Panel_Cutscene:SetPosX(0)
Panel_Cutscene:SetPosY(0)
Panel_Cutscene:SetShow(false, false)
Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
Panel_Cutscene:SetIgnore(true)
local renderMode = RenderModeWrapper.new(99, {
  Defines.RenderMode.eRenderMode_CutScene
}, false)
local Static_LatterBoxTop = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxTop")
local Static_LatterBoxBottom = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxBottom")
local Static_LetterBoxLeft = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxLeft")
local Static_LetterBoxRight = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxRight")
local Static_FadeScreen = UI.getChildControl(Panel_Cutscene, "Static_FadeScreen")
local Multiline_Subtitle = UI.getChildControl(Panel_Cutscene, "MultilineText_Subtitle")
local Static_SupportVoice = UI.getChildControl(Panel_Cutscene, "StaticText_SupportVoice")
local IM = CppEnums.EProcessorInputMode
local UIMode = Defines.UIMode
local prevUIMode = UIMode.eUIMode_Default
local isCutScenePlay = false
function FGlobal_SetIsCutScenePlay(isValid)
  isCutScenePlay = isValid
end
function FGlobal_GetIsCutScenePlay()
  return isCutScenePlay
end
Panel_Cutscene:RegisterUpdateFunc("Update_Subtitle")
function Update_Subtitle(deltaTime)
  if isSubtitleDelete == false then
    subtitleTimer = subtitleTimer + deltaTime
    if subtitleTimer > subtitleDeleteTime then
      subtitleTimer = 0
      subtitleDeleteTime = 0
      isSubtitleDelete = true
      Multiline_Subtitle:SetText("")
    end
  end
end
function FromClient_PlayCutScene(cutSceneName, isFromServer)
  ToClient_SaveUiInfo(false)
  crossHair_SetShow(false)
  prevUIMode = GetUIMode()
  FGlobal_SetIsCutScenePlay(true)
  SetUIMode(Defines.UIMode.eUIMode_Cutscene)
  renderMode:set()
  Panel_SkillCommand:SetShow(false)
  Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Cutscene:SetShow(true)
  ToClient_CutscenePlay(cutSceneName, isFromServer)
  local latterHeight = (getScreenSizeY() - 0.5625 * getScreenSizeX()) / 2
  local letterWidth = (getScreenSizeX() - 1.7777777777777777 * getScreenSizeY()) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  if letterWidth < 0 then
    letterWidth = 0
  end
  Static_FadeScreen:SetShow(true)
  Static_FadeScreen:SetSize(getScreenSizeX(), getScreenSizeY())
  Static_FadeScreen:ComputePos()
  Static_LatterBoxTop:SetShow(true)
  Static_LatterBoxTop:SetSize(getScreenSizeX(), latterHeight)
  Static_LatterBoxTop:ComputePos()
  Static_LatterBoxBottom:SetShow(true)
  Static_LatterBoxBottom:SetSize(getScreenSizeX(), latterHeight)
  Static_LatterBoxBottom:ComputePos()
  Static_LetterBoxLeft:SetShow(true)
  Static_LetterBoxLeft:SetSize(letterWidth, getScreenSizeX())
  Static_LetterBoxLeft:ComputePos()
  Static_LetterBoxRight:SetShow(true)
  Static_LetterBoxRight:SetSize(letterWidth, getScreenSizeX())
  Static_LetterBoxRight:ComputePos()
  Static_SupportVoice:SetShow(false)
  Static_SupportVoice:ComputePos()
  Multiline_Subtitle:SetText("")
  Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
  Multiline_Subtitle:SetSpanSize(0, latterHeight + 10)
  Multiline_Subtitle:ComputePos()
end
function FromClient_StopCutScene(cutSceneName)
  Multiline_Subtitle:SetText("")
  Static_LatterBoxTop:SetShow(false)
  Static_LatterBoxBottom:SetShow(false)
  Static_LetterBoxRight:SetShow(false)
  Static_LetterBoxLeft:SetShow(false)
  Panel_Cutscene:SetShow(false)
  Static_FadeScreen:SetShow(false)
  if prevUIMode ~= Defines.UIMode.eUIMode_Cutscene then
    SetUIMode(prevUIMode)
  end
  FGlobal_SetIsCutScenePlay(false)
  renderMode:reset()
  crossHair_SetShow(true)
  postProcessMessageData()
  PaGlobal_TutorialManager:handleStopCutScene(cutSceneName)
end
function FromClient_SetSubtitle(subtitle, Time)
  Multiline_Subtitle:SetText(subtitle)
  subtitleTimer = 0
  subtitleDeleteTime = Time
  isSubtitleDelete = false
end
function FromClient_SetScreenAlpha(value)
  Static_FadeScreen:SetAlpha(value)
end
registerEvent("FromClient_PlayCutScene", "FromClient_PlayCutScene")
registerEvent("FromClient_StopCutScene", "FromClient_StopCutScene")
registerEvent("FromClient_SetScreenAlpha", "FromClient_SetScreenAlpha")
registerEvent("FromClient_SetSubtitle", "FromClient_SetSubtitle")
renderMode:setClosefunctor(renderMode, FromClient_StopCutScene)
