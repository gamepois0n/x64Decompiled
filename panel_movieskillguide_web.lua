local UI_TM = CppEnums.TextMode
PaGlobal_MovieSkillGuide_Web = {
  btn_Close = UI.getChildControl(Panel_MovieSkillGuide_Web, "Button_Close")
}
local _Web = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_MovieSkillGuide_Web, "WebControl_MovieSkillGuideWeb_WebLink")
_Web:SetShow(true)
_Web:SetPosX(12)
_Web:SetPosY(50)
_Web:SetSize(320, 430)
_Web:ResetUrl()
function PaGlobal_MovieSkillGuide_Web:init()
  self.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MovieSkillGuide_Web:Close()")
  local checkAgeType = ToClient_isAdultUser()
  if checkAgeType then
    _Web:SetMonoTone(false)
  else
    _Web:SetMonoTone(true)
  end
end
function PaGlobal_MovieSkillGuide_Web:Open()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local movieGuideWeb = PaGlobal_URL_Check(worldNo)
  Panel_MovieSkillGuide_Web:SetPosX(getScreenSizeX() / 2 - Panel_MovieSkillGuide_Web:GetSizeX() / 2)
  Panel_MovieSkillGuide_Web:SetPosY(getScreenSizeY() / 2 - Panel_MovieSkillGuide_Web:GetSizeY() / 2)
  if nil ~= movieGuideWeb then
    local url = movieGuideWeb .. "/MovieGuide/Index/IngameSkill?classType=" .. classType
    _Web:SetUrl(320, 430, url, false, true)
    Panel_MovieSkillGuide_Web:SetShow(true)
  end
end
function PaGlobal_MovieSkillGuide_Web:Close()
  Panel_MovieSkillGuide_Web:SetShow(false)
  _Web:ResetUrl()
end
PaGlobal_MovieSkillGuide_Web:init()
