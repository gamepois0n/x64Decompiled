local HammerManagerNew = {
  _isStart,
  _uiProgressBG,
  _uiProgressBar,
  _percentValue,
  _resultValue,
  _dirGauge
}
function MiniGame_Hammer_Init()
  local this = HammerManagerNew
  this._uiProgressBG = UI.getChildControl(Panel_Hammer_New, "Static_GaugeBG")
  this._uiProgressBar = UI.getChildControl(Panel_Hammer_New, "Progress2_Gauge")
  this._isStart = false
  this._percentValue = 0
  this._resultValue = 0
  this._countEnd = 0
  Panel_Hammer_New:RegisterUpdateFunc("Update_HammerGauge")
end
function MiniGame_Hammer_Start()
  local this = HammerManagerNew
  Panel_Hammer_New:SetShow(true)
  this._isStart = true
  this._dirGauge = 5
  this._percentValue = 0
  this._resultValue = 0
  this._countEnd = 0
end
function Update_HammerGauge()
  _PA_LOG("\235\175\188\237\152\129", "\236\150\152\235\138\148 \236\150\184\236\160\156 \235\147\164\236\150\180\236\152\181\235\139\136\234\185\140?")
  local this = HammerManagerNew
  if false == this._isStart then
    return
  end
  this._percentValue = this._percentValue + this._dirGauge
  if this._percentValue > 100 then
    this._percentValue = 100
    this._dirGauge = -5
  elseif this._percentValue < 0 then
    this._percentValue = 0
    this._dirGauge = 5
    this._countEnd = this._countEnd + 1
  end
  this._uiProgressBar:SetProgressRate(this._percentValue)
  if this._countEnd > 3 then
    this._isStart = false
    MiniGame_Hammer_End()
  end
end
function MiniGame_Hammer_End()
  Panel_Hammer_New:SetShow(false)
end
Panel_Hammer_New:SetShow(false)
MiniGame_Hammer_Init()
